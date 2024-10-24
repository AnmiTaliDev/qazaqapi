

```markdown
# Text Transliteration API

This API provides transliteration services by converting text from one script to another based on predefined character mappings. Specifically, it transliterates Cyrillic characters (Kazakh alphabet) into Latin characters.

## Features

- Supports both lowercase and uppercase letters
- Simple and efficient transliteration
- JSON-based API

## API Documentation

### Endpoint: `/transliterate`

- **Method**: `POST`
- **Content-Type**: `application/json`
- **Description**: Converts the input text from Cyrillic to Latin based on predefined rules.

#### Request

```json
{
  "text": "Your text here"
}
```

- **text**: (string) The input text that needs to be transliterated.

#### Response

```json
{
  "original": "Original text",
  "transliterated": "Transliterated text"
}
```

- **original**: (string) The original input text.
- **transliterated**: (string) The text after transliteration.

#### Example

**Request**:

```json
{
  "text": "Қазақша мәтін"
}
```

**Response**:

```json
{
  "original": "Қазақша мәтін",
  "transliterated": "Qazaqşa mätiin"
}
```

### Character Mapping

The following are examples of how characters are transliterated:

| Cyrillic | Latin | Cyrillic | Latin |
|----------|-------|----------|-------|
| а        | a     | А        | A     |
| ә        | ä     | Ә        | Ä     |
| б        | b     | Б        | B     |
| ғ        | ğ     | Ғ        | Ğ     |
| ң        | ŋ     | Ң        | Ŋ     |
| қ        | q     | Қ        | Q     |
| ө        | ö     | Ө        | Ö     |
| ү        | ü     | Ү        | Ü     |
| ұ        | ū     | Ұ        | Ū     |
| һ        | h     | Һ        | H     |

### Setup and Installation

1. Install the required dependencies:
   ```bash
   gem install sinatra
   ```

2. Run the application:
   ```bash
   ruby api.rb
   ```

3. The server will start at `http://localhost:4567`.

---

# Мәтінді транслитерациялау API

Бұл API мәтінді бір әліпбиден екінші әліпбиге аудару үшін транслитерация қызметін ұсынады. Нақтырақ айтқанда, ол қазақ әліпбиіндегі кирилл әріптерін латын әріптеріне ауыстырады.

## Қызмет ерекшеліктері

- Бас және кіші әріптерді қолдайды
- Жылдам және қарапайым транслитерация
- JSON негізіндегі API

## API құжаттамасы

### Мекен-жайы: `/transliterate`

- **Әдіс**: `POST`
- **Content-Type**: `application/json`
- **Сипаттама**: Берілген мәтінді кириллицадан латыншаға транслитерациялау.

#### Сұраныс

```json
{
  "text": "Мәтін осында"
}
```

- **text**: (жол) Транслитерациялау керек мәтін.

#### Жауап

```json
{
  "original": "Бастапқы мәтін",
  "transliterated": "Транслитерацияланған мәтін"
}
```

- **original**: (жол) Бастапқы мәтін.
- **transliterated**: (жол) Латын әріптеріне транслитерацияланған мәтін.

#### Мысал

**Сұраныс**:

```json
{
  "text": "Қазақша мәтін"
}
```

**Жауап**:

```json
{
  "original": "Қазақша мәтін",
  "transliterated": "Qazaqşa mätiin"
}
```

### Әріптерді сәйкестендіру

Әріптердің транслитерациясы төмендегідей:

| Кириллица | Латынша | Кириллица | Латынша |
|-----------|---------|-----------|---------|
| а         | a       | А         | A       |
| ә         | ä       | Ә         | Ä       |
| б         | b       | Б         | B       |
| ғ         | ğ       | Ғ         | Ğ       |
| ң         | ŋ       | Ң         | Ŋ       |
| қ         | q       | Қ         | Q       |
| ө         | ö       | Ө         | Ö       |
| ү         | ü       | Ү         | Ü       |
| ұ         | ū       | Ұ         | Ū       |
| һ         | h       | Һ         | H       |

### Орнату және баптау

1. Қажетті тәуелділіктерді орнатыңыз:
   ```bash
   gem install sinatra
   ```

2. Қолданбаны іске қосыңыз:
   ```bash
   ruby api.rb
   ```

3. Сервер `http://localhost:4567` мекен-жайында жұмыс істейді.

