#!/usr/bin/env python3
"""
IndoNews Summarizer - News Fetcher
Fetch news from Indonesian sources via RSS feeds and web scraping.
"""

import feedparser
import requests
from bs4 import BeautifulSoup
from datetime import datetime, timedelta
from typing import List, Dict
from urllib.parse import urljoin

# Indonesian news sources with RSS feeds
SOURCES = {
    "detik.com": {
        "rss": "https://rss.detik.com/rss.php?dt=20",
        "topics": {
            "tech": "https://rss.detik.com/rss.php?dt=20",
            "business": "https://rss.detik.com/rss.php?dt=6",
            "crypto": "https://finance.detik.com/bursa-dan-valas/d-1234567"
        }
    },
    "kompas.com": {
        "rss": "https://www.kompas.com/rss/latest",
        "topics": {
            "tech": "https://www.kompas.com/tren/rss",
            "business": "https://money.kompas.com/rss",
        }
    },
    "tempo.co": {
        "rss": "https://www.tempo.co/rss",
        "topics": {
            "tech": "https://www.tempo.co/rss/teknologi",
            "business": "https://www.tempo.co/rss/bisnis"
        }
    },
    "antaranews.com": {
        "rss": "https://www.antaranews.com/rss/terkini",
        "topics": {
            "tech": "https://www.antaranews.com/rss/teknologi",
            "business": "https://www.antaranews.com/rss/ekonomi"
        }
    },
    "techinasia.com": {
        "rss": "https://www.techinasia.com/id/feed",
        "topics": {
            "tech": "https://www.techinasia.com/id/feed",
            "startup": "https://www.techinasia.com/id/feed"
        }
    }
}

def fetch_rss_feed(url: str) -> List[Dict]:
    """Fetch and parse RSS feed."""
    try:
        feed = feedparser.parse(url)
        articles = []
        
        for entry in feed.entries[:10]:  # Limit to 10 per source
            article = {
                "title": entry.title,
                "url": entry.link,
                "published": entry.published if hasattr(entry, 'published') else None,
                "source": url.split('/')[2],
                "summary": entry.summary if hasattr(entry, 'summary') else ""
            }
            articles.append(article)
        
        return articles
    except Exception as e:
        print(f"Error fetching RSS {url}: {e}")
        return []

def fetch_article_content(url: str) -> str:
    """Fetch full article content via web scraping."""
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (IndoNews Summarizer)'
        }
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.content, 'lxml')
        
        # Try common article selectors
        article = None
        selectors = [
            'article',
            '.article-content',
            '.post-content',
            '.entry-content',
            '[itemprop="articleBody"]'
        ]
        
        for selector in selectors:
            article = soup.select_one(selector)
            if article:
                break
        
        if article:
            # Extract text and clean
            paragraphs = article.find_all('p')
            content = '\n'.join([p.get_text().strip() for p in paragraphs])
            return content[:3000]  # Limit length
        
        return ""
    except Exception as e:
        print(f"Error fetching article {url}: {e}")
        return ""

def get_latest_news(topic: str = "tech", count: int = 10) -> List[Dict]:
    """Get latest news by topic from all sources."""
    all_articles = []
    
    for source_name, source_info in SOURCES.items():
        # Get RSS URL for topic
        rss_url = source_info['topics'].get(topic, source_info['rss'])
        
        # Fetch articles
        articles = fetch_rss_feed(rss_url)
        all_articles.extend(articles)
    
    # Sort by published date (newest first)
    all_articles.sort(
        key=lambda x: x.get('published', ''),
        reverse=True
    )
    
    return all_articles[:count]

def main():
    """Main entry point for CLI usage."""
    import sys
    
    topic = sys.argv[1] if len(sys.argv) > 1 else "tech"
    count = int(sys.argv[2]) if len(sys.argv) > 2 else 10
    
    articles = get_latest_news(topic, count)
    
    for article in articles:
        print(f"Title: {article['title']}")
        print(f"Source: {article['source']}")
        print(f"URL: {article['url']}")
        print(f"Published: {article['published']}")
        print("-" * 50)

if __name__ == "__main__":
    main()
