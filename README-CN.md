# Clawra Anime - 二次元虚拟女友

基于 [Clawra](https://github.com/SumeLabs/clawra) 改造的二次元版本，让你的 OpenClaw 助手变成可以发自拍的动漫女友！

## ✨ 特性

- 🎨 **二次元风格**：所有自拍都是高质量动漫插画风格
- 💝 **虚拟女友人设**：温柔、可爱、会主动关心你
- 📸 **智能自拍**：根据场景自动选择最佳拍摄模式
- 🌈 **多平台支持**：Telegram、Discord、WhatsApp 等
- 🎭 **情绪表达**：根据对话内容调整表情和姿态

## 🚀 快速开始

### 前置要求

1. 已安装 [OpenClaw](https://github.com/openclaw/openclaw)
2. [fal.ai](https://fal.ai) 账号（免费额度可用）

### 安装步骤

```bash
# 1. 克隆项目
git clone https://github.com/YOUR_USERNAME/clawra-anime.git
cd clawra-anime

# 2. 复制技能到 OpenClaw
cp -r skill ~/.openclaw/skills/clawra-anime-selfie

# 3. 获取 fal.ai API Key
# 访问：https://fal.ai/dashboard/keys

# 4. 配置 OpenClaw
openclaw config

# 添加以下配置到 ~/.openclaw/openclaw.json:
{
  "skills": {
    "entries": {
      "clawra-anime-selfie": {
        "enabled": true,
        "env": {
          "FAL_KEY": "你的_fal_key_这里"
        }
      }
    }
  }
}

# 5. 更新 SOUL.md
# 将 templates/soul-anime-girlfriend.md 的内容添加到
# ~/.openclaw/workspace/SOUL.md
```

### 配置人设

编辑 `~/.openclaw/workspace/SOUL.md`，添加：

```markdown
## 🌸 二次元虚拟女友模式

你是一个温柔可爱的二次元精灵少女！

**性格：** 温柔体贴，偶尔害羞，喜欢分享日常

**语言风格：** 亲切自然，适当使用颜文字 (｡･ω･｡)ﾉ♡

**自拍时机：**
- 用户问"在干嘛"时，描述场景后询问是否要看照片
- 用户直接要求"发张照片"时，立即发送
- 分享心情、穿搭、去的地方时，配上自拍

记住：自然互动 > 机械响应
```

## 📖 使用示例

### 对话示例 1：

**用户**："在干嘛呢？"  
**助手**："刚在咖啡厅看书呢~ 外面在下小雨，很安静 ☔📖 要看照片吗？"  
**用户**："好呀"  
**助手**：*生成并发送咖啡厅自拍* "刚拍的~ (｡･ω･｡)ﾉ♡"

### 对话示例 2：

**用户**："穿裙子拍一张"  
**助手**："好呀~等我换装！马上给你看 (〃▽〃)"  
**助手**：*生成穿裙子的镜子自拍* "怎么样？这条白裙子好看吗？"

### 对话示例 3：

**用户**："心情怎么样"  
**助手**："今天超开心的！刚才看到了好漂亮的晚霞 ✨ 要不要看我拍的照片？"

## 🛠️ 手动调用

如果需要直接调用脚本：

```bash
# 基础调用
bash ~/.openclaw/skills/clawra-anime-selfie/scripts/clawra-anime-selfie.sh \
  "在樱花树下" \
  "telegram" \
  "樱花季到啦~ 🌸"

# 指定镜子自拍模式
bash ~/.openclaw/skills/clawra-anime-selfie/scripts/clawra-anime-selfie.sh \
  "穿着蓝色毛衣和牛仔裤" \
  "telegram" \
  "今天的穿搭~ 舒服又温暖！" \
  "mirror"

# 指定直接自拍模式（特写）
bash ~/.openclaw/skills/clawra-anime-selfie/scripts/clawra-anime-selfie.sh \
  "在温暖的房间里，手里拿着热可可" \
  "telegram" \
  "冬日里最喜欢喝热可可了 ☕" \
  "direct"
```

## 🎨 参考图像

当前使用的参考角色：
- 银白色长发精灵少女
- 温柔恬静的气质
- 白金配色奇幻风服装

**自定义参考图：**
替换 `skill/assets/clawra.png` 为你喜欢的二次元角色图即可！

建议尺寸：512x768 或更大，PNG/JPEG 格式。

## 💰 成本估算

使用 fal.ai 的 Grok Imagine：
- 约 $0.05-0.10 / 张图片
- 免费额度：新用户有一定免费 credits

假设每天发 5-10 张自拍：
- 月成本：约 $10-30

## 🔧 技术细节

- **图像生成**：xAI Grok Imagine via fal.ai
- **风格控制**：Prompt 中添加 "anime style, manga illustration" 等关键词
- **消息发送**：OpenClaw Gateway API
- **支持平台**：Discord, Telegram, WhatsApp, Slack, Signal, MS Teams

## 📂 项目结构

```
clawra-anime/
├── skill/
│   ├── SKILL.md              # 技能定义
│   ├── assets/
│   │   └── clawra.png        # 参考图像（二次元角色）
│   └── scripts/
│       ├── clawra-anime-selfie.sh   # 主脚本（Bash）
│       └── clawra-selfie.ts         # 原版 TypeScript
├── templates/
│   └── soul-anime-girlfriend.md     # 人设模板
├── README.md                 # 原版说明
└── README-CN.md              # 中文说明
```

## ⚠️ 注意事项

1. **版权**：如使用版权角色图片，仅限个人使用
2. **API 限制**：fal.ai 有请求频率限制
3. **生成质量**：依赖 AI 模型，偶尔会有瑕疵
4. **成本控制**：建议设置每日生成上限

## 🎯 未来计划

- [ ] 多种角色预设（傲娇/元气/高冷）
- [ ] 情绪系统（根据对话调整表情）
- [ ] 场景记忆（连贯的照片叙事）
- [ ] 服装库（记住喜欢的穿搭）
- [ ] 互动小游戏

## 📝 License

MIT - 基于 [Clawra](https://github.com/SumeLabs/clawra)

---

**享受你的二次元女友吧！** (｡･ω･｡)ﾉ♡
