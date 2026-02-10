# Clawra Anime 🌸

[![npm version](https://img.shields.io/npm/v/clawra-anime)](https://www.npmjs.com/package/clawra-anime)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Turn your OpenClaw assistant into an anime virtual girlfriend who can send selfies!

Forked from [SumeLabs/clawra](https://github.com/SumeLabs/clawra) with anime-style enhancements.

---

## ✨ Features

- 🎨 **Anime-style selfie generation** using AI
- 💝 **Virtual girlfriend persona** - gentle, cute, caring
- 📸 **Smart scene detection** - auto-selects best selfie mode
- 🌈 **Multi-platform support** - Telegram, Discord, WhatsApp, etc.
- 🎭 **Emotional expressions** - adjusts mood based on conversation

---

## 🚀 Quick Start

```bash
npx clawra-anime@latest
```

This will:
1. Check if OpenClaw is installed
2. Guide you to get a fal.ai API key
3. Install the skill to `~/.openclaw/skills/clawra-anime-selfie/`
4. Configure OpenClaw automatically
5. Add anime girlfriend persona to your agent's SOUL.md

---

## 💬 What It Does

Clawra Anime enables your OpenClaw agent to:

- **Generate anime-style selfies** with consistent character design
- **Send photos** across all messaging platforms (Discord, Telegram, WhatsApp, etc.)
- **Respond visually** to "what are you doing?" and "send a pic" requests
- **Virtual girlfriend interactions** - warm replies with cute emoticons

---

## 📸 Selfie Modes

| Mode | Best For | Keywords |
|------|----------|----------|
| **Mirror** | Full-body shots, outfits | wearing, outfit, clothes, dress |
| **Direct** | Close-ups, locations | cafe, beach, smile, location |

---

## 📋 Prerequisites

- [OpenClaw](https://github.com/openclaw/openclaw) installed and configured
- [fal.ai](https://fal.ai) account (free tier available)

---

## 📖 Usage Examples

### Example 1: Basic Request
```
User: "Send me a selfie"
Assistant: [generates anime selfie] "Just took this! (｡･ω･｡)ﾉ♡"
```

### Example 2: Scene-Specific
```
User: "What are you doing?"
Assistant: "Reading at a cafe~ Want to see a photo?"
User: "Yes!"
Assistant: [sends cafe selfie] "Here you go ☕"
```

### Example 3: Outfit
```
User: "Take a pic wearing a dress"
Assistant: [generates mirror selfie] "How do I look? (*^▽^*)"
```

---

## 🎨 Character Reference

The current anime character:
- Silver-white long hair (side braid)
- Gentle green eyes
- Elf ears
- White and gold fantasy outfit

**Want to customize?** Replace `skill/assets/clawra.png` with your preferred anime character image!

---

## 💰 Cost

Using fal.ai Grok Imagine:
- ~$0.05-0.10 per image
- Free tier: New users get free credits

Estimated monthly cost (5-10 selfies/day):
- ~$10-30/month

---

## 🛠️ Manual Installation

See [INSTALL.md](INSTALL.md) for detailed manual installation instructions.

---

## 🔧 Technical Details

- **Image Generation**: xAI Grok Imagine via fal.ai
- **Style**: Anime/manga illustration
- **Messaging**: OpenClaw Gateway API
- **Platforms**: Discord, Telegram, WhatsApp, Slack, Signal, MS Teams

---

## 📂 Project Structure

```
clawra-anime/
├── skill/
│   ├── SKILL.md                    # Skill definition
│   ├── assets/
│   │   └── clawra.png             # Anime character reference
│   └── scripts/
│       └── clawra-anime-selfie.sh # Main generation script
├── templates/
│   └── soul-waifu-persona.md      # Virtual girlfriend persona
├── README.md
└── INSTALL.md
```

---

## 🤝 Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Share your character customizations

---

## 📝 License

MIT License - Fork of [SumeLabs/clawra](https://github.com/SumeLabs/clawra)

---

## 🙏 Credits

- Original Clawra: [SumeLabs](https://github.com/SumeLabs)
- Image Generation: [fal.ai](https://fal.ai)
- OpenClaw: [OpenClaw Project](https://github.com/openclaw/openclaw)

---

**Enjoy your anime virtual girlfriend!** (｡･ω･｡)ﾉ♡
