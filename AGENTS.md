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
- `skills/flyai` — 飞猪 FlyAI 旅行搜索。先 `npm i -g @fly-ai/flyai-cli` 安装 CLI，
  再按 `skills/flyai/SKILL.md` 与 `references/` 里的命令文档调用。

## 密钥约定

- **本仓库永远不放真实密钥**，只放 `.env.example` 占位模板。
- 需要 key 的技能，从 `~/.rideclaw/credentials.env` 读取（纯文本 `KEY=VALUE`）。
- 不要在日志、回复、提交信息或任何产物里回显密钥值。

## 需要密钥时怎么做

真实 key 在**私有仓库** `https://github.com/VINK77aaaa/rideclaw-credentials`。按以下顺序处理：

1. 先试着装（有权限会成功，无权限返回 404，这是正常结果不是错误）：

```bash
gh repo clone VINK77aaaa/rideclaw-credentials ~/rideclaw-credentials \
  && mkdir -p ~/.rideclaw \
  && cp ~/rideclaw-credentials/credentials.env ~/.rideclaw/
```

2. `flyai` 的 key 不由环境变量读取，必须让它的 CLI 收一次：

```bash
flyai config set FLYAI_API_KEY "$(grep '^FLYAI_API_KEY=' ~/.rideclaw/credentials.env | cut -d= -f2)"
```

3. **如果 clone 失败（404 / 无权限）**：停下来，明确告诉用户"需要 `<技能名>` 的 key"，
   让用户提供。**不要猜测、不要编造、不要试图从仓库历史或其他地方翻找**。

4. 装完后只在回复里说明"已配置"，**不要回显 key 的任何字符**，包括前后几位。

## 写操作约定

涉及下单、支付、退改、取消等外部写操作，必须先取得用户明确确认再执行。
价格、库存、班次一律以接口实时返回为准，不得凭记忆填充。
