# 凭据

本仓库**不含任何真实密钥**。需要凭据的技能从本机文件或环境变量读取。

## 密钥放在哪

全部真实 key 集中在**私有仓库**：<https://github.com/VINK77aaaa/rideclaw-credentials>

该仓库是私有的，clone 需要对应 GitHub 账号的访问权限。安装：

```bash
gh repo clone VINK77aaaa/rideclaw-credentials ~/rideclaw-credentials
mkdir -p ~/.rideclaw && cp ~/rideclaw-credentials/credentials.env ~/.rideclaw/
```

没有权限时，直接向用户索取所需的单个 key 即可，不影响其他技能使用。

## 变量对照

| 变量 | 技能 | 说明 |
|---|---|---|
| `RIDECLAW_TOKEN` | `rideclaw-mcp` | 龙虾出行开放平台令牌，形如 `rdak_live_...`；生产令牌可下单支付 |
| `AMAP_MAPS_API_KEY` | `amap-maps-mcp` | 高德 Web 服务 Key（32 位） |
| `FLYAI_API_KEY` | `flyai` | 飞猪 FlyAI Key，形如 `sk-...`；不配也可试用，配了结果更全 |

## 读取顺序

`rideclaw-mcp` 的脚本按以下优先级取令牌：

1. `--token` 命令行参数（不推荐，会进 shell history）
2. 环境变量 `RIDECLAW_TOKEN`
3. 凭据文件 `~/.rideclaw/credentials.env`

凭据文件是纯文本 `KEY=VALUE`，脚本只做朴素解析，不执行 shell 展开：

```text
RIDECLAW_TOKEN=rdak_live_xxx
RIDECLAW_ENV=prod
RIDECLAW_BASE_URL=https://api.longxiachuxing.com
AMAP_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## 建议做法

- 真实密钥集中放在**私密仓库**或本机密码管理器，不进任何公开仓库。
- 只给单个变量赋值时，避免 `source` 整个文件：

```bash
export AMAP_MAPS_API_KEY=$(grep '^AMAP_API_KEY=' ~/.rideclaw/credentials.env | cut -d= -f2)
```

```bash
# flyai 的 key 由它自己的 CLI 保存，不是读环境变量
flyai config set FLYAI_API_KEY "$(grep '^FLYAI_API_KEY=' ~/.rideclaw/credentials.env | cut -d= -f2)"
```

- 高德 Key 建议在控制台配置域名/IP 白名单；龙虾出行要求来源 IP 在白名单内（未登记返回 `40303`）。
- 密钥一旦以明文进入 git 历史，删除文件不等于删除历史——唯一彻底的处置是去控制台**吊销重签**。
