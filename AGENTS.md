# AGENTS.md

给读到本仓库的 agent 的安装与使用约定。

## 你要做什么

1. 把本仓库 clone 到本地任意位置。
2. 将 `skills/` 下的每个目录复制（或软链）到你的技能目录：
   - WorkBuddy：`~/.workbuddy-ai/skills/`
   - Claude Code：`~/.claude/skills/`
   - 其他：遵循该 agent 的技能加载约定，通常是 `<skills-dir>/<name>/SKILL.md`
3. 若不确定，直接运行 `bash install.sh`，它会自动探测并安装。

不要修改 `SKILL.md` 的 frontmatter `name` 字段——它必须与所在目录名一致，否则技能可能注册失败或重复注册。

## 技能清单

- `skills/rideclaw-mcp` — 龙虾出行开放平台 MCP 调用器。脚本自带，可直接跑：
  `python3 skills/rideclaw-mcp/scripts/mcp_call.py list`
- `skills/amap-maps-mcp` — 高德地图。依赖运行时已绑定的高德 MCP Server，
  绑定方式见 `skills/amap-maps-mcp/mcp.json`（Streamable HTTP 或 npx 两种）。

## 密钥约定

- **本仓库永远不放真实密钥**，只放 `.env.example` 占位模板。
- 需要 key 的技能，从 `~/.rideclaw/credentials.env` 读取（纯文本 `KEY=VALUE`）。
- 不要在日志、回复、提交信息或任何产物里回显密钥值。

## 写操作约定

涉及下单、支付、退改、取消等外部写操作，必须先取得用户明确确认再执行。
价格、库存、班次一律以接口实时返回为准，不得凭记忆填充。
