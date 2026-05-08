# IndoNews Summarizer Agent

AI-powered news aggregator yang summary berita Indonesia jadi 5 poin singkat. Hemat waktu baca berita dari 30 menit → 5 menit!

---

## Deskripsi

IndoNews Summarizer Agent adalah skill untuk OpenClaw yang:
- 📰 Aggregates berita dari sumber Indonesia terpercaya
- 🤖 AI summary jadi 5 bullet points per artikel
- 🏷️ Filter by topik (tech, politics, sports, crypto, business)
- 📧 Daily digest mode (kirim summary tiap pagi)
- 🔍 Search berita by keyword
- 📊 Trending topics tracker

---

## Features

| Feature | Description |
|---------|-------------|
| Multi-Source | Detik, Kompas, Tempo, Antara, Tech in Asia ID, dll |
| AI Summary | Ringkas artikel panjang jadi 5 poin penting |
| Topic Filter | Tech, Politics, Business, Sports, Crypto, Entertainment |
| Daily Digest | Auto-deliver summary tiap pagi (custom time) |
| Keyword Search | Cari berita by keyword ("AI", "startup", "IHSG") |
| Trending Topics | Track topik yang lagi viral di Indonesia |
| Sentiment Analysis | Deteksi sentimen berita (positive/negative/neutral) |
| Multi-Platform | Telegram, WhatsApp, Discord delivery |

---

## Installation

```bash
# Clone atau download skill folder
git clone https://github.com/g4rrzx/indonews-summarizer.git

# Pindahkan ke OpenClaw skills directory
cp -r indonews-summarizer ~/.openclaw/workspace/skills/

# Install dependencies
pip install -r requirements.txt

# Restart OpenClaw
```

---

## Configuration

Edit `config.json` sesuai kebutuhan:

```json
{
  "sources": [
    "detik.com",
    "kompas.com",
    "tempo.co",
    "antaranews.com",
    "techinasia.com"
  ],
  "topics": ["tech", "business", "crypto"],
  "dailyDigest": {
    "enabled": true,
    "time": "07:00",
    "timezone": "Asia/Jakarta"
  },
  "summaryLength": 5,
  "language": "id",
  "notifications": {
    "telegram": true,
    "whatsapp": false,
    "email": false
  }
}
```

### Config Options

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sources[]` | array | [...] | List sumber berita |
| `topics[]` | array | ["tech"] | Topik yang diminati |
| `dailyDigest.enabled` | boolean | true | Enable daily digest |
| `dailyDigest.time` | string | 07:00 | Waktu kirim (HH:MM) |
| `dailyDigest.timezone` | string | Asia/Jakarta | Timezone |
| `summaryLength` | number | 5 | Jumlah bullet points |
| `language` | string | id | Bahasa (id/en) |
| `notifications.telegram` | boolean | true | Telegram delivery |
| `notifications.whatsapp` | boolean | false | WhatsApp delivery |
| `notifications.email` | boolean | false | Email delivery |

---

## Usage

### Get Latest News

```bash
./indonews.sh --latest --topic tech --count 5
```

### Search News

```bash
./indonews.sh --search "AI startup Indonesia"
```

### Daily Digest

```bash
./indonews.sh --digest
```

### Trending Topics

```bash
./indonews.sh --trending
```

### Summarize URL

```bash
./indonews.sh --summarize "https://detik.com/..."
```

---

## Output Example

### Latest Tech News
```
📰 Tech News - Indonesia
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Startup AI Jakarta Raih Funding $5M
   📍 detik.com • 2 jam lalu
   📝 Summary:
   • Startup fokus computer vision
   • Funding led by East Ventures
   • Akan hire 50 engineer baru
   • Target ekspansi ke SEA
   • Product launch Q3 2026

2. Google Buka AI Research Lab di Bandung
   📍 kompas.com • 4 jam lalu
   📝 Summary:
   • Lab pertama di Indonesia
   • Kolaborasi dengan ITB
   • Fokus AI untuk agriculture
   • 100 researcher akan hire
   • Resmikan bulan depan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Daily Digest
```
📬 Daily Digest - Senin, 8 Mei 2026
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Top Stories Hari Ini:

🔥 Tech (3 artikel)
• Startup AI Raih $5M
• Google Buka Lab di Bandung
• Gojek Launch Fitur Baru

💰 Business (2 artikel)
• IHSG Naik 1.2%
• Rupiah Menguat vs USD

⚽ Sports (1 artikel)
• Timnas Menang 3-1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: 6 artikel • 5 min baca
```

---

## Project Structure

```
indonews-summarizer/
├── SKILL.md              # This file
├── config.json           # Configuration
├── indonews.sh           # Main script
├── WORKFLOW.md           # Workflow documentation
├── README.md             # Project README
├── FIELD_04.txt          # Submission field
├── SUBMISSION.md         # Submission guide
├── requirements.txt      # Python dependencies
├── history/              # News history
│   └── YYYY-MM-DD.json
└── screenshots/          # Demo screenshots
    ├── 01_latest_news.png
    ├── 02_search.png
    ├── 03_summary.png
    ├── 04_daily_digest.png
    └── 05_trending.png
```

---

## Requirements

- OpenClaw runtime
- Python 3.8+
- `pip` packages:
  - `requests` (HTTP requests)
  - `beautifulsoup4` (HTML parsing)
  - `feedparser` (RSS feeds)
  - `openclaw-sdk` (OpenClaw integration)
- Internet connection
- News API access (free RSS feeds)

---

## API Integration

Skill ini menggunakan:
- RSS Feeds (gratis, no API key)
- Web scraping untuk full article
- OpenClaw LLM untuk summarization
- Telegram/WhatsApp API untuk delivery

---

## License

MIT-0 · MIT No Attribution

Free to use, modify, and redistribute. No attribution required.

---

## Author

**Tegar Andriansyah** (@g4rrzx)

- GitHub: https://github.com/g4rrzx
- LinkedIn: https://linkedin.com/in/tegar86
- X/Twitter: https://x.com/g4rrzx
- Website: https://g4rrzx.my.id

---

## Changelog

### v1.0.0
- Initial release
- Multi-source news aggregation
- AI-powered summarization (5 bullet points)
- Topic filtering (tech, business, crypto, etc.)
- Daily digest mode
- Keyword search
- Trending topics tracker
- Sentiment analysis
- Telegram/WhatsApp delivery
