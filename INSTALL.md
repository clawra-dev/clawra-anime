# Installation Guide

## Quick Install (5 minutes)

### Method 1: Automatic (Recommended)

```bash
npx clawra-anime@latest
```

This will guide you through the entire setup process.

---

### Method 2: Manual Installation

#### Step 1: Clone Repository

```bash
git clone https://github.com/clawra-dev/clawra-anime.git
cd clawra-anime
```

#### Step 2: Copy Skill to OpenClaw

```bash
cp -r skill ~/.openclaw/skills/clawra-anime-selfie

# Verify installation
ls ~/.openclaw/skills/clawra-anime-selfie
```

#### Step 3: Get fal.ai API Key

1. Visit: https://fal.ai/dashboard/keys
2. Sign up / Login
3. Click "Create new key"
4. Copy the API key (format: `fal-xxx-xxx`)

#### Step 4: Configure OpenClaw

Edit `~/.openclaw/openclaw.json` and add:

```json
{
  "skills": {
    "entries": {
      "clawra-anime-selfie": {
        "enabled": true,
        "env": {
          "FAL_KEY": "paste_your_fal_key_here"
        }
      }
    }
  }
}
```

#### Step 5: Update Persona

Add the content from `templates/soul-waifu-persona.md` to your `~/.openclaw/workspace/SOUL.md`:

```bash
# View the template
cat templates/soul-waifu-persona.md

# Append to your SOUL.md
cat templates/soul-waifu-persona.md >> ~/.openclaw/workspace/SOUL.md
```

#### Step 6: Restart OpenClaw

```bash
openclaw gateway restart
```

---

## Testing

After installation, test in your chat:

```
You: "Send me a selfie"
Assistant: [generates and sends anime-style selfie]

You: "What are you doing?"
Assistant: "Reading a book~ Want to see a photo?"
```

---

## Manual Script Usage (Advanced)

If you want to call the script directly:

```bash
# Set environment variable
export FAL_KEY="your_fal_key"

# Generate selfie
bash ~/.openclaw/skills/clawra-anime-selfie/scripts/clawra-anime-selfie.sh \
  "at a coffee shop drinking latte" \
  "telegram" \
  "Afternoon coffee time ☕"
```

---

## Troubleshooting

### Image generation fails?
**Check:**
1. FAL_KEY is correctly configured
2. fal.ai account has credits/balance
3. Network connection is stable

### Image send fails?
**Check:**
1. OpenClaw Gateway is running (`openclaw status`)
2. Channel name is correct
3. Permissions are sufficient

### Style not anime enough?
**Solution:** Edit `skill/scripts/clawra-anime-selfie.sh`, add more anime keywords in FULL_PROMPT:
```bash
FULL_PROMPT="anime style, manga illustration, detailed anime art, cute anime elf girl, $USER_PROMPT, ..."
```

### Want different character?
**Solution:** Replace `skill/assets/clawra.png` with your preferred anime character image!

---

## Cost Estimate

Using fal.ai Grok Imagine:
- ~$0.05-0.10 per image
- Free tier: New users get free credits for testing

Assuming 5-10 selfies per day:
- Monthly cost: ~$10-30

---

## Support

For issues:
1. Check OpenClaw logs: `openclaw logs`
2. Check skill status: `openclaw skills`
3. Submit GitHub issue

---

**Enjoy your anime virtual girlfriend!** (｡･ω･｡)ﾉ♡
