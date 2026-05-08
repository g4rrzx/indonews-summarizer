# 🔄 IndoNews Summarizer - Workflow

Diagram alur kerja dan penjelasan bagaimana IndoNews Summarizer Agent bekerja.

---

## 📊 Overview Workflow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    INDONEWS SUMMARIZER WORKFLOW                         │
└─────────────────────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │   START      │
    └──────┬───────┘
           │
           ▼
    ┌──────────────────┐
    │  User Command    │
    │  (--latest,      │
    │   --search,      │
    │   --digest, etc) │
    └──────┬───────────┘
           │
           ▼
    ┌──────────────────────────────────────────┐
    │           COMMAND ROUTER                 │
    │  indonews.sh parses & routes command     │
    └──────┬───────────────────────────────────┘
           │
    ┌──────┴──────┬─────────────┬──────────────┬──────────────┐
    │             │             │              │              │
    ▼             ▼             ▼              ▼              ▼
┌────────┐  ┌──────────┐  ┌─────────┐  ┌──────────┐  ┌──────────┐
│ LATEST │  │  SEARCH  │  │ DIGEST  │  │ TRENDING │  │SUMMARIZE │
└───┬────┘  └────┬─────┘  └────┬────┘  └────┬─────┘  └────┬─────┘
    │            │             │            │             │
    └────────────┴──────┬──────┴────────────┴─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   NEWS FETCHER          │
            │   - RSS Feed Parser     │
            │   - Web Scraper         │
            │   - Source: Detik,Kompas│
            │     Tempo,Antara,etc    │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   Article Extractor     │
            │   - Title               │
            │   - Content             │
            │   - Publish Date        │
            │   - Author              │
            │   - Category            │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   AI Summarizer (LLM)   │
            │   - Call OpenClaw API   │
            │   - Prompt: "Summarize  │
            │     into 5 bullet points│
            │     in Indonesian"      │
            │   - Parse response      │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   Sentiment Analysis    │
            │   - Positive/Negative/  │
            │     Neutral detection   │
            │   - Score: 0-100        │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   Save to History       │
            │   - history/YYYY-MM-DD  │
            │   - Store metadata      │
            │   - Cache for search    │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │   Format & Deliver      │
            │   - Telegram/WhatsApp   │
            │   - CLI Output          │
            │   - Email (optional)    │
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────┐
            │      END        │
            └─────────────────┘
```

---

## 🔀 Detailed Workflows

### 1️⃣ Latest News Workflow

```
User: ./indonews.sh --latest --topic tech --count 5
         │
         ▼
┌─────────────────────────┐
│  1. Load Config         │
│     - Read config.json  │
│     - Get sources[]     │
│     - Get topics[]      │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  2. Fetch RSS Feeds     │
│     - For each source:  │
│       • detik.com/rss   │
│       • kompas.com/rss  │
│       • tempo.co/rss    │
│     - Parse XML         │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  3. Filter by Topic     │
│     - Match category    │
│     - Tech articles only│
│     - Sort by date      │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  4. Fetch Full Content  │
│     - HTTP GET article  │
│     - Parse HTML        │
│     - Extract text      │
│     - Clean formatting  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  5. AI Summarization    │
│     - Call LLM API      │
│     - Prompt per article│
│     - Get 5 bullets     │
│     - Rate limit handle │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  6. Format Output       │
│     - Add emojis        │
│     - Source attribution│
│     - Time ago          │
│     - Read time estimate│
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  7. Display to User     │
│     "📰 Tech News       │
│      1. Startup AI...   │
│      2. Google Buka..." │
└─────────────────────────┘
```

---

### 2️⃣ Search Workflow

```
User: ./indonews.sh --search "AI startup Indonesia"
         │
         ▼
┌─────────────────────────┐
│  1. Parse Query         │
│     - Keywords:         │
│       ["AI", "startup", │
│        "Indonesia"]     │
│     - Date range:       │
│       default 30 days   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  2. Search History      │
│     - Query cached news │
│     - Full-text search  │
│     - Relevance scoring │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  3. Fetch More (if <10) │
│     - Google News API   │
│     - Source search     │
│     - Add to cache      │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  4. Rank Results        │
│     - Keyword match     │
│     - Recency boost     │
│     - Source authority  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  5. Summarize Top 10    │
│     - AI summary each   │
│     - Consistent format │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  6. Display Results     │
│     "🔍 Search:         │
│      'AI startup...'    │
│      Found: 15 articles │
│      1. ..."            │
└─────────────────────────┘
```

---

### 3️⃣ Daily Digest Workflow

```
Scheduler: Daily at 07:00 WIB
         │
         ▼
┌─────────────────────────┐
│  1. Fetch Today's News  │
│     - Since 00:00 WIB   │
│     - All sources       │
│     - All topics        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  2. Select Top Stories  │
│     - By topic          │
│     - Max 3 per topic   │
│     - Priority: viral   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  3. Generate Summary    │
│     - AI digest mode    │
│     - Ultra-short       │
│     - 5 min total read  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  4. Format Digest       │
│     - Date header       │
│     - Topic sections    │
│     - Read time         │
│     - Weather (bonus)   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  5. Deliver to User     │
│     - Telegram message  │
│     - Or WhatsApp       │
│     - Or Email          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  6. Log Delivery        │
│     - history/digest/   │
│     - Track open rate   │
│     - User feedback     │
└─────────────────────────┘
```

---

### 4️⃣ Trending Topics Workflow

```
User: ./indonews.sh --trending
         │
         ▼
┌─────────────────────────┐
│  1. Aggregate 24h News  │
│     - All sources       │
│     - Count by keyword  │
│     - Group by topic    │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  2. Calculate Trend     │
│     - Article count     │
│     - Velocity (Δ/hour) │
│     - Social signals    │
│     - Source diversity  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  3. Rank Topics         │
│     - Trending score    │
│     - Top 10 topics     │
│     - Include Δ%        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  4. Get Top Article     │
│     - Per trending topic│
│     - Most representative│
│     - Summarize         │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  5. Display Trending    │
│     "🔥 Trending Today  │
│      1. #Pilpres2026    │
│         (+250%)         │
│      2. #HargaEmas      │
│         (+180%)         │
│      ..."               │
└─────────────────────────┘
```

---

### 5️⃣ Summarize URL Workflow

```
User: ./indonews.sh --summarize "https://detik.com/..."
         │
         ▼
┌─────────────────────────┐
│  1. Validate URL        │
│     - Check domain      │
│     - Is Indonesian news│
│     - HTTP GET          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  2. Extract Content     │
│     - Parse HTML        │
│     - Get title         │
│     - Get article body  │
│     - Remove ads/nav    │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  3. AI Summarization    │
│     - Call LLM API      │
│     - Custom prompt     │
│     - 5 bullet points   │
│     - Key quotes        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  4. Sentiment Analysis  │
│     - Article sentiment │
│     - Score 0-100       │
│     - Positive/Neg/Neutral│
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  5. Display Summary     │
│     "📝 Summary:        │
│      Title: ...         │
│      Source: detik.com  │
│      • Point 1          │
│      • Point 2          │
│      ...                │
│      😊 Sentiment: +72" │
└─────────────────────────┘
```

---

## 📎 Data Structures

### Article Object
```json
{
  "id": "detik-20260508-001",
  "title": "Startup AI Jakarta Raih Funding $5M",
  "url": "https://detik.com/...",
  "source": "detik.com",
  "author": "John Doe",
  "publishedAt": "2026-05-08T10:30:00+07:00",
  "category": "tech",
  "content": "Full article text...",
  "summary": [
    "Startup fokus computer vision",
    "Funding led by East Ventures",
    "Akan hire 50 engineer baru",
    "Target ekspansi ke SEA",
    "Product launch Q3 2026"
  ],
  "sentiment": {
    "label": "positive",
    "score": 85
  },
  "readTime": 3
}
```

### Daily Digest Object
```json
{
  "date": "2026-05-08",
  "totalArticles": 6,
  "readTime": 5,
  "topics": {
    "tech": 3,
    "business": 2,
    "sports": 1
  },
  "articles": [...],
  "deliveredAt": "2026-05-08T07:00:00+07:00",
  "deliveredTo": ["telegram:@g4rrzx"]
}
```

---

## 🔧 Error Handling

| Error | Handling |
|-------|----------|
| Source down | Skip, try backup source |
| RSS parse fail | Fallback to web scrape |
| LLM timeout | Retry with backoff, use cached summary |
| Rate limit | Queue request, retry after delay |
| Invalid URL | Show error, suggest valid format |

---

## 🚀 Performance Optimization

1. **Caching:** Cache summaries for 24h
2. **Batch Processing:** Summarize multiple articles in one API call
3. **Incremental Fetch:** Only fetch new articles since last run
4. **Lazy Loading:** Load full content on-demand
5. **CDN:** Use CDN for static assets (if web UI)

---

**This workflow ensures fast, accurate, and reliable news delivery!** 📰🇮🇩
