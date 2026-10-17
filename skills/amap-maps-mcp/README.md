# amap-maps-mcp
高德地图（Amap Maps）MCP 调用技能：POI 搜索/地理编码/路线规划/天气查询等 16 个标准工具

## 仓库内容
- `SKILL.md`：技能说明（16 个 MCP 工具目录）
- `mcp.json`：高德 MCP Server 接入配置（Streamable HTTP + Node.js I/O 两种方式）
- `.env.example`：Key 变量名模板（**不含真实值**）

## 密钥来源

本仓库**不存放任何真实 Key**。实际值统一放在私密仓库 `VINK77aaaa/rideclaw-credentials`，
本机同步到 `~/.rideclaw/credentials.env`（变量名 `AMAP_API_KEY`）。

```bash
# 取用
export AMAP_MAPS_API_KEY=$(grep '^AMAP_API_KEY=' ~/.rideclaw/credentials.env | cut -d= -f2)
```

`mcp.json` 里的 `<AMAP_MAPS_API_KEY>` 是占位符，填入时请用上面的变量替换，
不要把真实值提交回来。

## MCP 接入
官方 MCP Server：`@amap/amap-maps-mcp-server`（npm），官方文档 https://lbs.amap.com/api/mcp-server/gettingstarted

### Streamable HTTP（推荐）
```json
{
  "mcpServers": {
    "amap-maps-streamableHTTP": {
      "url": "https://mcp.amap.com/mcp?key=<AMAP_MAPS_API_KEY>"
    }
  }
}
```

### Node.js I/O（npx 本地启动，需 Node ≥ v22.14.0）
```json
{
  "mcpServers": {
    "amap-maps": {
      "command": "npx",
      "args": ["-y", "@amap/amap-maps-mcp-server"],
      "env": {
        "AMAP_MAPS_API_KEY": "<AMAP_MAPS_API_KEY>"
      }
    }
  }
}
```

## 安全说明

- 高德 Key 按调用量计费，超额会被限流或扣费，等同于可消费凭据。
- 建议在高德控制台为该 Key 配置**域名/IP 白名单**，限制被盗用后的影响面。
- 一旦 Key 曾以明文进入 git 历史，**删除文件不等于删除历史**——历史提交里依然可以翻出来。
  唯一彻底的处置是去控制台**吊销并重签**。
- 本仓库由旧仓库重建而来，历史已清空；旧仓库中曾明文提交的 Key 已作废。
