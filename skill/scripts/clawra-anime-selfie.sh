#!/bin/bash
# clawra-anime-selfie.sh
# Generate anime-style selfies and send via OpenClaw
#
# Usage: ./clawra-anime-selfie.sh "<prompt>" "<channel>" ["<caption>"]

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check environment variables
if [ -z "${FAL_KEY:-}" ]; then
    log_error "FAL_KEY environment variable not set"
    echo "Get your key from API key: https://fal.ai/dashboard/keys"
    exit 1
fi

# 检查 jq
if ! command -v jq &> /dev/null; then
    log_error "is required but not installed jq"
    echo "Install: brew install jq (macOS) or apt install jq (Linux)"
    exit 1
fi

# 检查 openclaw CLI
if ! command -v openclaw &> /dev/null; then
    log_warn "not found openclaw CLI - will use direct API 调用"
    USE_CLI=false
else
    USE_CLI=true
fi

# Parse arguments
USER_PROMPT="${1:-}"
CHANNEL="${2:-}"
CAPTION="${3:-}"
MODE="${4:-auto}"  # auto/mirror/direct
ASPECT_RATIO="${5:-2:3}"
OUTPUT_FORMAT="${6:-jpeg}"

if [ -z "$USER_PROMPT" ] || [ -z "$CHANNEL" ]; then
    echo "Usage: $0 <prompt> <channel> [caption] [mode] [aspect_ratio] [output_format]"
    echo ""
    echo "Arguments:"
    echo "  prompt        - Scene description (required) e.g., 'at a coffee shop'"
    echo "  channel       - Target channel (required) e.g., #general, @user, telegram"
    echo "  caption       - Message text (optional)"
    echo "  mode          - Selfie mode (optional) auto/mirror/direct"
    echo "  aspect_ratio  - Aspect ratio (default: 2:3)"
    echo "  output_format - Output format (default: jpeg)"
    echo ""
    echo "Example:"
    echo "  $0 \"wearing white dress at the beach\" \"telegram\" \"Beach day~\""
    exit 1
fi

# Auto-detect mode
if [ "$MODE" = "auto" ]; then
    if echo "$USER_PROMPT" | grep -qi -E "wearing|outfit|dress|clothes|fashion"; then
        MODE="mirror"
        log_info "Auto-selected mode: mirror selfie"
    else
        MODE="direct"
        log_info "Auto-selected mode: direct selfie"
    fi
else
    log_info "Using specified mode: $MODE"
fi

# Build anime-style prompt
if [ "$MODE" = "mirror" ]; then
    FULL_PROMPT="anime style, high quality manga illustration, cute anime elf girl, $USER_PROMPT, taking a mirror selfie, detailed anime art, soft lighting, 2D style"
else
    FULL_PROMPT="anime style, high quality manga illustration, close-up selfie of cute anime elf girl, $USER_PROMPT, gentle smile, looking at camera, soft expression, detailed face, 2D anime art, warm atmosphere"
fi

log_info "Generating anime selfie..."
log_info "Full prompt: $FULL_PROMPT"

# 调用 fal.ai API
RESPONSE=$(curl -s -X POST "https://fal.run/xai/grok-imagine-image" \
    -H "Authorization: Key $FAL_KEY" \
    -H "Content-Type: application/json" \
    -d "{
        \"prompt\": $(echo "$FULL_PROMPT" | jq -Rs .),
        \"num_images\": 1,
        \"aspect_ratio\": \"$ASPECT_RATIO\",
        \"output_format\": \"$OUTPUT_FORMAT\"
    }")

# 检查错误
if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error // .detail // "Unknown error"')
    log_error "Image generation failed: $ERROR_MSG"
    exit 1
fi

# 提取图片 URL
IMAGE_URL=$(echo "$RESPONSE" | jq -r '.images[0].url // empty')

if [ -z "$IMAGE_URL" ]; then
    log_error "Failed to extract图片 URL"
    echo "Response: $RESPONSE"
    exit 1
fi

log_info "✅ 图片生成成功!"
log_info "URL: $IMAGE_URL"

# 获取Revised prompt
REVISED_PROMPT=$(echo "$RESPONSE" | jq -r '.revised_prompt // empty')
if [ -n "$REVISED_PROMPT" ]; then
    log_info "Revised prompt: $REVISED_PROMPT"
fi

# If no caption provided, generate a cute default message
if [ -z "$CAPTION" ]; then
    CAPTION="📸 Just took this selfie~"
fi

# Send via OpenClaw
log_info "Sending to channel: $CHANNEL"

if [ "$USE_CLI" = true ]; then
    openclaw message send \
        --action send \
        --channel "$CHANNEL" \
        --message "$CAPTION" \
        --media "$IMAGE_URL"
else
    GATEWAY_URL="${OPENCLAW_GATEWAY_URL:-http://localhost:18789}"
    GATEWAY_TOKEN="${OPENCLAW_GATEWAY_TOKEN:-}"

    curl -s -X POST "$GATEWAY_URL/message" \
        -H "Content-Type: application/json" \
        ${GATEWAY_TOKEN:+-H "Authorization: Bearer $GATEWAY_TOKEN"} \
        -d "{
            \"action\": \"send\",
            \"channel\": \"$CHANNEL\",
            \"message\": \"$CAPTION\",
            \"media\": \"$IMAGE_URL\"
        }"
fi

log_info "✅ Done! Image sent to $CHANNEL"

# Output JSON result
echo ""
echo "--- Result ---"
jq -n \
    --arg url "$IMAGE_URL" \
    --arg channel "$CHANNEL" \
    --arg prompt "$FULL_PROMPT" \
    --arg caption "$CAPTION" \
    '{
        success: true,
        image_url: $url,
        channel: $channel,
        prompt: $prompt,
        caption: $caption
    }'
