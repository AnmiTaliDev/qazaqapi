# 🇰🇿 Kazakh Transliteration API

Простой API для транслитерации казахского текста из кириллицы в латиницу.

## Использование

### Запуск
```bash
ruby app.rb
```

### API

**POST /transliterate**
```json
{
  "text": "Сәлем әлем"
}
```

Ответ:
```json
{
  "original": "Сәлем әлем",
  "transliterated": "Sälem älem"
}
```

**GET /health**
```json
{
  "status": "ok"
}
```

## Тестирование

```bash
ruby test_app.rb
```

## Примеры

| Кириллица | Латиница |
|-----------|----------|
| Қазақстан | Qazaqstan |
| Сәлем әлем | Sälem älem |
| Алматы | Almaty |

## Поддерживаемые символы

Все казахские буквы: `ә ө і ң ғ ү ұ қ һ` и их заглавные варианты.