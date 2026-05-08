# 📰 IndoNews Summarizer

> AI-powered news aggregator untuk berita Indonesia. Hemat waktu baca dari 30 menit → 5 menit!

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT--0-green)
![Python](https://img.shields.io/badge/python-3.8+-blue)
![Indonesia](https://img.shields.io/badge/🇮🇩-Indonesia-red)

---

## 📌 Tentang Project

**IndoNews Summarizer** adalah AI agent yang aggregates berita dari sumber Indonesia terpercaya dan automatic summary jadi 5 poin singkat.

Perfect buat:
- 🎓 Student yang gak punya waktu baca berita panjang
- 💼 Professional yang mau stay updated dalam 5 menit
- 📈 Investor yang track news tentang market & crypto
- 🤖 AI enthusiast yang mau lihat use case NLP real-world

---

## ✨ Fitur Utama

### 📰 Multi-Source Aggregation
- Detik, Kompas, Tempo, Antara, Tech in Asia ID
- RSS feeds + web scraping
- Real-time update (setiap 15 menit)

### 🤖 AI Summarization
- Artikel 1000+ kata → 5 bullet points
- Extract key information only
- Preserve context & nuance
- Bahasa Indonesia natural

### 🏷️ Smart Filtering
- **Tech:** Startup, AI, gadgets, software
- **Business:** Market, IHSG, perusahaan, ekonomi
- **Crypto:** Bitcoin, altcoins, regulation
- **Politics:** Government, policy, elections
- **Sports:** Football, badminton, esports
- **Entertainment:** Movies, music, celebrities

### 📬 Daily Digest
- Auto-deliver tiap pagi (custom time)
- Top 10 stories of the day
- Categorized by topic
- 5-minute read total

### 🔍 Keyword Search
- Search by keyword ("AI", "startup", "Gojek")
- Filter by date range
- Relevance ranking

### 📊 Trending Topics
- Track viral topics di Indonesia
- Real-time trending score
- Related articles

### 😊 Sentiment Analysis
- Detect sentimen (positive/negative/neutral)
- Track sentiment trend per topik
- Alert untuk negative sentiment spike

---

## 🚀 Quick Start

### Prerequisites

```bash
# Python 3.8+
python --version

# Install dependencies
pip install -r requirements.txt
```

### Installation

```bash
# Clone repository
git clone https://github.com/g4rrzx/indonews-summarizer.git
cd indonews-summarizer

# Copy to OpenClaw skills directory
cp -r indonews-summarizer ~/.openclaw/workspace/skills/

# Configure
cp config.example.json config.json
# Edit config.json sesuai kebutuhan

# Restart OpenClaw
openclaw restart
```

### First Run

```bash
# Get latest tech news
./indonews.sh --latest --topic tech --count 5

# Search news
./indonews.sh --search "AI Indonesia"

# Daily digest
./indonews.sh --digest

# Trending topics
./indonews.sh --trending
```

---

## 📖 Documentation

| Doc | Description |
|-----|-------------|
| [SKILL.md](./SKILL.md) | Skill definition untuk ClawHub |
| [WORKFLOW.md](./WORKFLOW.md) | Workflow diagram & explanation |
| [SUBMISSION.md](./SUBMISSION.md) | Guide untuk submit ke Mimo |
| [config.json](./config.json) | Configuration reference |

---

## 🎯 Use Cases

### 🎓 Student
- Stay updated tanpa ganggu waktu belajar
- Search news untuk tugas & research
- Daily digest sebelum kuliah

### 💼 Professional
- Quick briefing pagi hari
- Track industry news (competitor, market)
- Meeting prep dengan latest info

### 📈 Investor/Trader
- Real-time news tentang IHSG & stocks
- Crypto regulation updates
- Sentiment analysis untuk market insight

### 🤖 Developer
- Track tech news (AI, startup, funding)
- Learn NLP use case real-world
- Build on top of this project

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| Runtime | OpenClaw |
| Language | Python 3.8+, Bash |
| AI/LLM | OpenClaw API |
| News Sources | RSS Feeds + Web Scraping |
| HTML Parsing | BeautifulSoup4 |
| RSS Parsing | Feedparser |
| Data Storage | JSON (local) |
| Notifications | Telegram, WhatsApp API |

---

## 📁 Project Structure

```
indonews-summarizer/
├── SKILL.md              # Skill definition
├── README.md             # This file
├── WORKFLOW.md           # Workflow documentation
├── config.json           # Configuration
├── indonews.sh           # Main CLI entry point
├── requirements.txt      # Python dependencies
├── FIELD_04.txt          # Mimo submission field
├── SUBMISSION.md         # Submission guide
├── scripts/
│   ├── news_fetcher.py      # Fetch news from sources
│   ├── summarizer.py        # AI summarization
│   ├── sentiment.py         # Sentiment analysis
│   └── trending.py          # Trending topics
├── history/              # News history (auto-created)
└── screenshots/          # Demo screenshots
```

---

## 📊 Demo

### Latest News Output
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
```

### Daily Digest Output
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
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 🗞️ Supported News Sources

| Source | Topics | RSS |
|--------|--------|-----|
| Detik.com | All | ✅ |
| Kompas.com | All | ✅ |
| Tempo.co | All | ✅ |
| Antara News | All | ✅ |
| Tech in Asia ID | Tech, Startup | ✅ |
| DailySocial | Tech, Startup | ✅ |
| Kontan | Business, Market | ✅ |
| Bola.net | Sports | ✅ |

*More sources coming soon!*

---

## 🔮 Roadmap

### v1.0 (Current)
- ✅ Multi-source aggregation
- ✅ AI summarization
- ✅ Topic filtering
- ✅ Daily digest
- ✅ Search & trending

### v1.1 (Next)
- [ ] WhatsApp integration
- [ ] Voice briefing (TTS)
- [ ] Personalized recommendations
- [ ] Export to PDF/Notion

### v2.0 (Future)
- [ ] Mobile app (React Native)
- [ ] Browser extension
- [ ] Real-time breaking news alert
- [ ] Multi-language (EN/ID)

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## 📝 License

This project is licensed under **MIT-0** (MIT No Attribution).

Free to use, modify, and redistribute. No attribution required.

---

---

## 🙏 Acknowledgments

- OpenClaw team for the amazing platform
- Mimo xiaomi for the opportunity
- All Indonesian news sources for RSS feeds
- Contributors and supporters

---

**Stay Updated, Stay Smart! 📰🇮🇩**
