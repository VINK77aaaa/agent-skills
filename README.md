# agent-skills

个人自用的 Agent 技能集合。**把仓库链接发给任意 agent，clone 一次就能拿到全部技能。**

```bash
git clone https://github.com/VINK77aaaa/agent-skills.git ~/agent-skills
bash ~/agent-skills/install.sh
```

## 包含的技能

| 技能 | 用途 | 依赖 |
|---|---|---|
| [`rideclaw-mcp`](skills/rideclaw-mcp/) | 龙虾出行开放平台：机票/酒店/打车/巴士/高铁查询与订单，含 Code Mode 沙箱编排（实测 59 个 MCP 工具） | Python 3.8+，零第三方依赖 |
| [`amap-maps-mcp`](skills/amap-maps-mcp/) | 高德地图：POI 搜索/地理编码/路径规划/天气（16 个 MCP 工具） | 需绑定高德 MCP Server（见该目录 mcp.json） |
| [`flyai`](skills/flyai/) | 飞猪 FlyAI：机票/酒店/火车/景点/门票搜索与预订（Fliggy MCP，关键词/语义双搜索） | Node 18+，`npm i -g @fly-ai/flyai-cli` |

## 安装

`install.sh` 会自动探测已存在的技能目录并安装（符号链接优先，失败自动退回复制）：

```bash
bash install.sh                  # 自动探测
bash install.sh --copy           # 强制复制而非软链
bash install.sh --target ~/.claude/skills   # 指定目录，可重复
```

探测顺序：`~/.workbuddy-ai/skills` → `~/.claude/skills` → `~/.codex/skills`；都没找到时装到 `~/.agent-skills`。

装完重启 agent 会话，技能才会被加载。

## 凭据

**本仓库不含任何真实密钥。** 需要 key 的技能从本机凭据文件读取，详见 [docs/credentials.md](docs/credentials.md)。

## 给 agent 的说明

如果你是读到这个仓库的 agent，请直接看 [`AGENTS.md`](AGENTS.md)，里面有安装与使用约定。
