require 'sinatra'
require 'json'
require 'logger'

configure do
  # Настройка логгера
  logger = Logger.new('logs/application.log', 'daily')
  logger.level = Logger::INFO
  set :logger, logger
  
  # Настройка CORS для API
  set :bind, '0.0.0.0'
  set :port, 4567
  set :show_exceptions, false
end

# Словарь для замены символов (строчные и заглавные)
TRANSLIT_DICT = {
  "й" => "i", "Й" => "I", "и" => "i", "И" => "I", "у" => "u", "У" => "U", "к" => "k", "К" => "K",
  "е" => "e", "Е" => "E", "н" => "n", "Н" => "N", "г" => "g", "Г" => "G", "ш" => "ş", "Ш" => "Ş",
  "з" => "z", "З" => "Z", "х" => "h", "Х" => "H", "ф" => "f", "Ф" => "F", "ы" => "y", "Ы" => "Y",
  "в" => "v", "В" => "V", "а" => "a", "А" => "A", "п" => "p", "П" => "P", "р" => "r", "Р" => "R",
  "о" => "o", "О" => "O", "л" => "l", "Л" => "L", "д" => "d", "Д" => "D", "ж" => "j", "Ж" => "J",
  "с" => "s", "С" => "S", "м" => "m", "М" => "M", "т" => "t", "Т" => "T", "ь" => "'", "Ь" => "'",
  "б" => "b", "Б" => "B", "ё" => "e", "Ё" => "E", "ә" => "ä", "Ә" => "Ä", "і" => "ı", "І" => "I",
  "ң" => "ŋ", "Ң" => "Ŋ", "ғ" => "ğ", "Ғ" => "Ğ", "ү" => "ü", "Ү" => "Ü", "ұ" => "ū", "Ұ" => "Ū",
  "қ" => "q", "Қ" => "Q", "ө" => "ö", "Ө" => "Ö", "һ" => "h", "Һ" => "H"
}.freeze

# Вспомогательные методы
helpers do
  def json_response(status_code, data)
    content_type :json
    status status_code
    data.to_json
  end

  def transliterate(text)
    return '' if text.nil? || text.empty?
    text.chars.map { |char| TRANSLIT_DICT[char] || char }.join
  end
end

# CORS headers
before do
  headers({
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Allow-Methods' => ['POST', 'OPTIONS'],
    'Access-Control-Allow-Headers' => 'Content-Type'
  })
end

# Options для CORS preflight requests
options '/transliterate' do
  200
end

# Основной маршрут для транслитерации
post '/transliterate' do
  begin
    request_data = JSON.parse(request.body.read)
    
    # Проверка наличия текста
    unless request_data.key?('text')
      return json_response(400, { error: 'Missing required parameter: text' })
    end

    text = request_data['text'].to_s
    transliterated_text = transliterate(text)
    
    # Логирование успешного запроса
    settings.logger.info("Successfully transliterated text. Length: #{text.length}")
    
    json_response(200, {
      original: text,
      transliterated: transliterated_text,
      timestamp: Time.now.utc.iso8601
    })
    
  rescue JSON::ParserError => e
    settings.logger.error("JSON parsing error: #{e.message}")
    json_response(400, { error: 'Invalid JSON format' })
  rescue StandardError => e
    settings.logger.error("Unexpected error: #{e.message}")
    json_response(500, { error: 'Internal server error' })
  end
end

# Маршрут для проверки здоровья сервиса
get '/health' do
  json_response(200, { 
    status: 'ok',
    version: '1.0.0',
    timestamp: Time.now.utc.iso8601
  })
end

# Обработка ошибок
not_found do
  json_response(404, { error: 'Route not found' })
end

error do
  json_response(500, { error: 'Internal server error' })
end
