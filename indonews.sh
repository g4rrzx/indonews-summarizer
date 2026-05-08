#!/bin/bash

###############################################################################
# IndoNews Summarizer - Main CLI Entry Point
# 
# AI-powered news aggregator untuk berita Indonesia
#
# Usage:
#   ./indonews.sh --latest --topic tech --count 5
#   ./indonews.sh --search "AI startup"
#   ./indonews.sh --digest
#   ./indonews.sh --trending
#   ./indonews.sh --summarize "https://..."
#
# Author: Tegar Andriansyah (@g4rrzx)
# License: MIT-0
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HISTORY_DIR="$SCRIPT_DIR/history"
CONFIG_FILE="$SCRIPT_DIR/config.json"

# Create directories if not exist
mkdir -p "$HISTORY_DIR"

# Load config
if [ -f "$CONFIG_FILE" ]; then
    DEFAULT_TOPICS=$(jq -r '.topics | join(",")' "$CONFIG_FILE" 2>/dev/null || echo "tech")
    SUMMARY_LENGTH=$(jq -r '.summaryLength' "$CONFIG_FILE" 2>/dev/null || echo "5")
    DIGEST_TIME=$(jq -r '.dailyDigest.time' "$CONFIG_FILE" 2>/dev/null || echo "07:00")
else
    DEFAULT_TOPICS="tech"
    SUMMARY_LENGTH="5"
    DIGEST_TIME="07:00"
fi

# Helper functions
print_header() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}📰 IndoNews Summarizer${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

show_help() {
    print_header
    echo ""
    echo -e "${PURPLE}Usage:${NC}"
    echo "  ./indonews.sh [COMMAND] [OPTIONS]"
    echo ""
    echo -e "${PURPLE}Commands:${NC}"
    echo "  --latest             Get latest news by topic"
    echo "  --search <query>     Search news by keyword"
    echo "  --digest             Get daily digest"
    echo "  --trending           Get trending topics"
    echo "  --summarize <url>    Summarize specific URL"
    echo "  --help               Show this help message"
    echo ""
    echo -e "${PURPLE}Latest Options:${NC}"
    echo "  --topic <name>       Topic: tech, business, crypto, etc."
    echo "  --count <number>     Number of articles (default: 5)"
    echo ""
    echo -e "${PURPLE}Examples:${NC}"
    echo "  ./indonews.sh --latest --topic tech --count 5"
    echo "  ./indonews.sh --search \"AI Indonesia\""
    echo "  ./indonews.sh --digest"
    echo "  ./indonews.sh --trending"
    echo "  ./indonews.sh --summarize \"https://detik.com/...\""
    echo ""
}

# Latest news function
do_latest() {
    local topic="$DEFAULT_TOPICS"
    local count="5"
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --topic)
                topic="$2"
                shift 2
                ;;
            --count)
                count="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    
    print_header
    echo ""
    print_info "Fetching latest news..."
    echo "  Topic: $topic"
    echo "  Count: $count"
    echo ""
    
    # Simulate news fetching (in production, call Python script)
    echo -e "${CYAN}📰 Latest $topic News - Indonesia${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    for i in $(seq 1 $count); do
        echo "$i. [Article Title About $topic]"
        echo "   📍 Source • 2 jam lalu"
        echo "   📝 Summary:"
        echo "   • AI-generated point 1"
        echo "   • AI-generated point 2"
        echo "   • AI-generated point 3"
        echo "   • AI-generated point 4"
        echo "   • AI-generated point 5"
        echo ""
    done
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    print_info "In production: Real news from Detik, Kompas, Tempo, etc!"
}

# Search function
do_search() {
    local query="$1"
    
    if [ -z "$query" ]; then
        print_error "Search query required!"
        echo "Usage: ./indonews.sh --search \"AI startup Indonesia\""
        exit 1
    fi
    
    print_header
    echo ""
    print_info "Searching news..."
    echo "  Query: $query"
    echo ""
    
    echo -e "${CYAN}🔍 Search Results: \"$query\"${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. [Relevant Article 1]"
    echo "   📍 detik.com • 1 jam lalu"
    echo "   📝 Summary: [5 bullet points]"
    echo ""
    echo "2. [Relevant Article 2]"
    echo "   📍 kompas.com • 3 jam lalu"
    echo "   📝 Summary: [5 bullet points]"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    print_info "In production: Real search across all sources!"
}

# Daily digest function
do_digest() {
    local date=$(date +"%A, %d %B %Y")
    
    print_header
    echo ""
    print_info "Generating daily digest..."
    echo "  Date: $date"
    echo "  Time: $DIGEST_TIME"
    echo ""
    
    echo -e "${GREEN}📬 Daily Digest - $date${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📊 Top Stories Hari Ini:"
    echo ""
    echo "🔥 Tech (3 artikel)"
    echo "• Startup AI Raih Funding"
    echo "• Google Buka Lab di Indonesia"
    echo "• Gojek Launch Fitur Baru"
    echo ""
    echo "💰 Business (2 artikel)"
    echo "• IHSG Naik 1.2%"
    echo "• Rupiah Menguat vs USD"
    echo ""
    echo "⚽ Sports (1 artikel)"
    echo "• Timnas Menang 3-1"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Total: 6 artikel • 5 min baca"
}

# Trending topics function
do_trending() {
    print_header
    echo ""
    print_info "Calculating trending topics..."
    echo ""
    
    echo -e "${PURPLE}🔥 Trending Topics - Indonesia${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. #Pilpres2026          🔼 +250%"
    echo "   45 artikel • Politics"
    echo ""
    echo "2. #HargaEmas            🔼 +180%"
    echo "   32 artikel • Business"
    echo ""
    echo "3. #AIIndonesia          🔼 +150%"
    echo "   28 artikel • Tech"
    echo ""
    echo "4. #TimnasIndonesia      🔼 +120%"
    echo "   25 artikel • Sports"
    echo ""
    echo "5. #CryptoRegulation     🔼 +95%"
    echo "   18 artikel • Crypto"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Summarize URL function
do_summarize() {
    local url="$1"
    
    if [ -z "$url" ]; then
        print_error "URL required!"
        echo "Usage: ./indonews.sh --summarize \"https://detik.com/...\""
        exit 1
    fi
    
    print_header
    echo ""
    print_info "Summarizing article..."
    echo "  URL: $url"
    echo ""
    
    echo -e "${CYAN}📝 Article Summary${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Title: [Article Title]"
    echo "Source: detik.com"
    echo "Author: John Doe"
    echo "Published: 2 jam lalu"
    echo ""
    echo "Summary:"
    echo "• AI-generated key point 1"
    echo "• AI-generated key point 2"
    echo "• AI-generated key point 3"
    echo "• AI-generated key point 4"
    echo "• AI-generated key point 5"
    echo ""
    echo "😊 Sentiment: Positive (+72)"
    echo "⏱️  Read Time: 3 min (original), 1 min (summary)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Main command router
main() {
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi
    
    case "$1" in
        --latest)
            shift
            do_latest "$@"
            ;;
        --search)
            shift
            do_search "$@"
            ;;
        --digest)
            do_digest
            ;;
        --trending)
            do_trending
            ;;
        --summarize)
            shift
            do_summarize "$@"
            ;;
        --help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main
main "$@"
