#!/usr/bin/env ruby
# encoding: utf-8

require 'webrick'
require 'json'

# Словарь транслитерации
TRANSLIT_MAP = {
  'а' => 'a', 'А' => 'A', 'б' => 'b', 'Б' => 'B',
  'в' => 'v', 'В' => 'V', 'г' => 'g', 'Г' => 'G',
  'д' => 'd', 'Д' => 'D', 'е' => 'e', 'Е' => 'E',
  'ж' => 'j', 'Ж' => 'J', 'з' => 'z', 'З' => 'Z',
  'и' => 'i', 'И' => 'I', 'й' => 'i', 'Й' => 'I',
  'к' => 'k', 'К' => 'K', 'л' => 'l', 'Л' => 'L',
  'м' => 'm', 'М' => 'M', 'н' => 'n', 'Н' => 'N',
  'о' => 'o', 'О' => 'O', 'п' => 'p', 'П' => 'P',
  'р' => 'r', 'Р' => 'R', 'с' => 's', 'С' => 'S',
  'т' => 't', 'Т' => 'T', 'у' => 'u', 'У' => 'U',
  'ф' => 'f', 'Ф' => 'F', 'х' => 'h', 'Х' => 'H',
  'ы' => 'y', 'Ы' => 'Y', 'ь' => '', 'Ь' => '',
  
  # Казахские буквы
  'ә' => 'ä', 'Ә' => 'Ä', 'і' => 'ı', 'І' => 'I',
  'ң' => 'ŋ', 'Ң' => 'Ŋ', 'ғ' => 'ğ', 'Ғ' => 'Ğ',
  'ү' => 'ü', 'Ү' => 'Ü', 'ұ' => 'ū', 'Ұ' => 'Ū',
  'қ' => 'q', 'Қ' => 'Q', 'ө' => 'ö', 'Ө' => 'Ö',
  'һ' => 'h', 'Һ' => 'H'
}

class APIServlet < WEBrick::HTTPServlet::AbstractServlet
  def service(req, res)
    # CORS headers
    res['Access-Control-Allow-Origin'] = '*'
    res['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    res['Access-Control-Allow-Headers'] = 'Content-Type'
    
    case req.request_method
    when 'OPTIONS'
      res.status = 200
    when 'GET'
      handle_get(req, res)
    when 'POST'
      handle_post(req, res)
    else
      send_error(res, 405, 'Method not allowed')
    end
  end

  private

  def handle_get(req, res)
    case req.path
    when '/'
      send_json(res, {
        message: "Kazakh Transliteration API",
        endpoints: [
          "POST /transliterate",
          "GET /health"
        ],
        example: { text: "Салем алем" }
      })
    when '/health'
      send_json(res, { status: 'ok' })
    else
      send_error(res, 404, 'Not found')
    end
  end

  def handle_post(req, res)
    case req.path
    when '/transliterate'
      handle_transliterate(req, res)
    else
      send_error(res, 404, 'Not found')
    end
  end

  def handle_transliterate(req, res)
    begin
      body = req.body
      if body.nil? || body.empty?
        return send_error(res, 400, 'Empty body')
      end

      data = JSON.parse(body)
      text = data['text']
      
      if text.nil? || text.to_s.empty?
        return send_error(res, 400, 'Text required')
      end
      
      # Транслитерация
      result = text.to_s.chars.map { |char| TRANSLIT_MAP[char] || char }.join
      
      send_json(res, {
        original: text.to_s,
        transliterated: result
      })
      
    rescue JSON::ParserError
      send_error(res, 400, 'Invalid JSON')
    rescue => e
      send_error(res, 500, 'Server error')
    end
  end

  def send_json(res, data)
    res.status = 200
    res.content_type = 'application/json; charset=utf-8'
    res.body = data.to_json
  end

  def send_error(res, status, message)
    res.status = status
    res.content_type = 'application/json; charset=utf-8'
    res.body = { error: message }.to_json
  end
end

# Запуск сервера
if __FILE__ == $0
  server = WEBrick::HTTPServer.new(
    Port: 4567,
    Logger: WEBrick::Log.new(nil, WEBrick::Log::ERROR),
    AccessLog: []
  )
  
  server.mount('/', APIServlet)
  
  trap('INT') { server.shutdown }
  
  puts "Kazakh API server started on http://localhost:4567"
  puts "Press Ctrl+C to stop"
  
  server.start
end