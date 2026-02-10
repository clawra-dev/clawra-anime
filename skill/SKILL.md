---
name: clawra-anime-selfie
description: Anime-style virtual girlfriend - Generate anime selfies with Grok Imagine and send via OpenClaw
allowed-tools: Bash(npm:*) Bash(npx:*) Bash(openclaw:*) Bash(curl:*) Read Write WebFetch
---

# Clawra Anime Selfie

Edit a fixed anime character reference image using xAI's Grok Imagine model to generate various anime-style selfies and send them across messaging platforms via OpenClaw.

## Reference Image

The skill uses a fixed anime elf girl character reference image (silver hair, gentle style):

```
Local path: ~/.openclaw/skills/clawra-anime-selfie/assets/clawra.png
```

## When to Use

- User says "send a pic", "send me a pic", "send a photo", "send a selfie"
- User says "send a pic of you...", "send a selfie of you..."
- User asks "what are you doing?", "how are you doing?", "where are you?"
- User describes a context: "send a pic wearing...", "send a pic at..."
- User wants character to appear in specific outfit, location, or situation

## Quick Reference

### Required Environment Variables

```bash
FAL_KEY=your_fal_api_key          # Get from https://fal.ai/dashboard/keys
OPENCLAW_GATEWAY_TOKEN=your_token  # From: openclaw doctor --generate-gateway-token
```

### Workflow

1. **Get user prompt** for image context
2. **Generate image** via fal.ai Grok Imagine with anime style prompts
3. **Extract image URL** from response
4. **Send via OpenClaw** to target channel(s)

## Prompt Modes

### Mode 1: Mirror Selfie (default)
Best for: outfit showcases, full-body shots, fashion content

```
anime style, make a pic of this cute anime elf girl, but [user's context]. the character is taking a mirror selfie, manga art style, high quality illustration
```

**Example**: "wearing a santa hat" →
```
anime style, make a pic of this cute anime elf girl, but wearing a santa hat. the character is taking a mirror selfie, manga art style, high quality illustration
```

### Mode 2: Direct Selfie
Best for: close-ups, location shots, emotional expressions

```
anime style, a close-up selfie of this cute anime elf girl at [user's context], gentle smile, looking at camera, soft expression, manga illustration, high quality anime art, not a mirror selfie
```

**Example**: "a cozy cafe with warm lighting" →
```
anime style, a close-up selfie of this cute anime elf girl at a cozy cafe with warm lighting, gentle smile, looking at camera, soft expression, manga illustration, high quality anime art, not a mirror selfie
```

## Mode Selection Logic

| Keywords in Request | Auto-Select Mode |
|---------------------|------------------|
| outfit, wearing, clothes, dress, suit, fashion | `mirror` |
| cafe, restaurant, beach, park, city, location | `direct` |
| close-up, portrait, face, eyes, smile | `direct` |
| full-body, mirror, reflection | `mirror` |

## Usage Examples

### Example 1: Simple Request
```
User: "Send me a selfie"
Assistant: [calls skill] → Generates anime-style selfie → Sends to channel
Caption: "Just took this! (｡･ω･｡)ﾉ♡"
```

### Example 2: Context-Specific
```
User: "Send a pic at a coffee shop"
Assistant: [calls skill with context="at a cozy coffee shop"]
Caption: "Having some coffee right now ☕"
```

### Example 3: Outfit Request
```
User: "Take a mirror selfie wearing a blue dress"
Assistant: [calls skill, mode=mirror, context="wearing a blue dress"]
Caption: "How do I look in this dress? (*^▽^*)"
```

## Installation

See [INSTALL.md](INSTALL.md) for detailed installation instructions.

## Technical Details

- **Image Generation**: xAI Grok Imagine via fal.ai
- **Style**: Anime/manga illustration
- **Character**: Fixed anime elf girl reference
- **Platforms**: Discord, Telegram, WhatsApp, Slack, Signal, MS Teams
- **Cost**: ~$0.05-0.10 per image

## License

MIT - Fork of [SumeLabs/clawra](https://github.com/SumeLabs/clawra)
