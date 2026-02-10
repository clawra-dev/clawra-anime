#!/bin/bash
# clawra-anime-selfie.sh
# 生成二次元风格自拍并通过 OpenClaw 发送
#
# 用法: ./clawra-anime-selfie.sh "<prompt>" "<channel>" ["<caption>"]

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

# 检查环境变量
if [ -z "${FAL_KEY:-}" ]; then
    log_error "FAL_KEY 环境变量未设置"
    echo "请从这里获取 API key: https://fal.ai/dashboard/keys"
    exit 1
fi

# 检查 jq
if ! command -v jq &> /dev/null; then
    log_error "需要安装 jq"
    echo "安装: brew install jq (macOS) 或 apt install jq (Linux)"
    exit 1
fi

# 检查 openclaw CLI
if ! command -v openclaw &> /dev/null; then
    log_warn "未找到 openclaw CLI - 将使用直接 API 调用"
    USE_CLI=false
else
    USE_CLI=true
fi

# 解析参数
USER_PROMPT="${1:-}"
CHANNEL="${2:-}"
CAPTION="${3:-}"
MODE="${4:-auto}"  # auto/mirror/direct
ASPECT_RATIO="${5:-2:3}"
OUTPUT_FORMAT="${6:-jpeg}"

if [ -z "$USER_PROMPT" ] || [ -z "$CHANNEL" ]; then
    echo "用法: $0 <prompt> <channel> [caption] [mode] [aspect_ratio] [output_format]"
    echo ""
    echo "参数:"
    echo "  prompt        - 场景描述（必需）如：'在咖啡厅喝咖啡'"
    echo "  channel       - 目标频道（必需）如：#general, @user, telegram"
    echo "  caption       - 消息文字（可选）"
    echo "  mode          - 自拍模式（可选）auto/mirror/direct"
    echo "  aspect_ratio  - 比例（默认 2:3）"
    echo "  output_format - 格式（默认 jpeg）"
    echo ""
    echo "示例:"
    echo "  $0 \"穿着白色连衣裙在海边\" \"telegram\" \"今天的海滩~\""
    exit 1
fi

# 自动检测模式
if [ "$MODE" = "auto" ]; then
    if echo "$USER_PROMPT" | grep -qi -E "穿|wearing|outfit|衣服|dress"; then
        MODE="mirror"
        log_info "自动选择模式: 镜子自拍"
    else
        MODE="direct"
        log_info "自动选择模式: 直接自拍"
    fi
else
    log_info "使用指定模式: $MODE"
fi

# 构建二次元风格 prompt
if [ "$MODE" = "mirror" ]; then
    FULL_PROMPT="anime style, high quality manga illustration, cute anime elf girl, $USER_PROMPT, taking a mirror selfie, detailed anime art, soft lighting, 2D style"
else
    FULL_PROMPT="anime style, high quality manga illustration, close-up selfie of cute anime elf girl, $USER_PROMPT, gentle smile, looking at camera, soft expression, detailed face, 2D anime art, warm atmosphere"
fi

log_info "生成二次元自拍..."
log_info "完整 Prompt: $FULL_PROMPT"

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
    log_error "图片生成失败: $ERROR_MSG"
    exit 1
fi

# 提取图片 URL
IMAGE_URL=$(echo "$RESPONSE" | jq -r '.images[0].url // empty')

if [ -z "$IMAGE_URL" ]; then
    log_error "无法从响应中提取图片 URL"
    echo "响应内容: $RESPONSE"
    exit 1
fi

log_info "✅ 图片生成成功!"
log_info "URL: $IMAGE_URL"

# 获取优化后的 prompt
REVISED_PROMPT=$(echo "$RESPONSE" | jq -r '.revised_prompt // empty')
if [ -n "$REVISED_PROMPT" ]; then
    log_info "优化后的 prompt: $REVISED_PROMPT"
fi

# 如果没有提供 caption，生成一个可爱的默认消息
if [ -z "$CAPTION" ]; then
    CAPTION="📸 ${USER_PROMPT}的自拍~"
fi

# 通过 OpenClaw 发送
log_info "发送到频道: $CHANNEL"

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

log_info "✅ 完成! 图片已发送到 $CHANNEL"

# 输出 JSON 结果
echo ""
echo "--- 结果 ---"
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
