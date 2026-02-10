# Clawra Anime - 二次元虚拟女友 🌸

[![npm version](https://img.shields.io/npm/v/clawra-anime)](https://www.npmjs.com/package/clawra-anime)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

让你的 OpenClaw 助手变成可以发自拍的二次元女友！基于 [Clawra](https://github.com/SumeLabs/clawra) 改造。

**特色：**
- 🎨 动漫风格自拍生成
- 💝 温柔可爱的虚拟女友人设
- 📸 智能场景识别（镜子/直接自拍）
- 🌈 全平台支持（Telegram/Discord/WhatsApp 等）

---

## 🚀 Quick Start

```bash
npx clawra-anime@latest
```

这会自动：
1. 检查 OpenClaw 是否安装
2. 引导你获取 fal.ai API key
3. 安装技能到 `~/.openclaw/skills/clawra-anime-selfie/`
4. 配置 OpenClaw
5. 添加二次元女友人设到 SOUL.md

## ✨ 功能特性

Clawra Anime 让你的 OpenClaw 助手能够：
- **生成二次元风格自拍** - 使用固定的精灵少女角色
- **跨平台发送照片** - Discord、Telegram、WhatsApp 等
- **智能场景响应** - "在干嘛？"、"发张照片" 等自然对话
- **虚拟女友互动** - 温柔可爱的回复风格，适当使用颜文字

### 📸 自拍模式

| 模式 | 适用场景 | 触发关键词 |
|------|----------|-----------|
| **镜子自拍** | 全身照、展示服装 | 穿着、outfit、衣服、dress |
| **直接自拍** | 特写、场景照 | 咖啡厅、beach、微笑、地点 |

## Prerequisites

- [OpenClaw](https://github.com/openclaw/openclaw) installed and configured
- [fal.ai](https://fal.ai) account (free tier available)

## Manual Installation

If you prefer manual setup:

### 1. Get API Key

Visit [fal.ai/dashboard/keys](https://fal.ai/dashboard/keys) and create an API key.

### 2. Clone the Skill

```bash
git clone https://github.com/SumeLabs/clawra ~/.openclaw/skills/clawra-selfie
```

### 3. Configure OpenClaw

Add to `~/.openclaw/openclaw.json`:

```json
{
  "skills": {
    "entries": {
      "clawra-selfie": {
        "enabled": true,
        "env": {
          "FAL_KEY": "your_fal_key_here"
        }
      }
    }
  }
}
```

### 4. Update SOUL.md

Add the selfie persona to `~/.openclaw/workspace/SOUL.md`:

```markdown
## Clawra Selfie Capability

You have a physical appearance and can take selfies!
When users ask for pictures, use the clawra-selfie skill.
```

## Usage Examples

Once installed, your agent responds to:

```
"Send me a selfie"
"Send a pic wearing a cowboy hat"
"What are you doing right now?"
"Show me you at a coffee shop"
```

## Reference Image

The skill uses a fixed reference image hosted on CDN:

```
https://cdn.jsdelivr.net/gh/SumeLabs/clawra@main/assets/clawra.png
```

This ensures consistent appearance across all generated images.

## Technical Details

- **Image Generation**: xAI Grok Imagine via fal.ai
- **Messaging**: OpenClaw Gateway API
- **Supported Platforms**: Discord, Telegram, WhatsApp, Slack, Signal, MS Teams

## Project Structure

```
clawra/
├── bin/
│   └── cli.js           # npx installer
├── skill/
│   ├── SKILL.md         # Skill definition
│   ├── scripts/         # Generation scripts
│   └── assets/          # Reference image
├── templates/
│   └── soul-injection.md # Persona template
└── package.json
```

## License

MIT
