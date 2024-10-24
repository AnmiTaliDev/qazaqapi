require 'sinatra'
require 'json'

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
}

# Функция для транслитерации текста
def transliterate(text)
  text.chars.map { |char| TRANSLIT_DICT[char] || char }.join
end

# Определение маршрута для обработки запроса
post '/transliterate' do
  request_data = JSON.parse(request.body.read)
  text = request_data['text']
  transliterated_text = transliterate(text)
  content_type :json
  { original: text, transliterated: transliterated_text }.to_json
end

# Запуск приложения на порту 4567
set :port, 4567
