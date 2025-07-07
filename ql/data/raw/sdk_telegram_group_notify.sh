#!/bin/bash

# 从环境变量加载信息
BOT_TOKEN="${TG_BOT_TOKEN}"
CHAT_ID="${TG_GROUP_ID}"   # 可以是用户ID 或 -100 开头的群组ID

# 消息内容（可用Markdown或HTML格式）
MESSAGE="🚀 很高兴大家的加入\n\n✅ 我会每天告诉大家一些有趣的事情，欢迎邀请朋友加入本群！\n📅 $(date "+%Y-%m-%d")"

# 发送 POST 请求到 Telegram API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d parse_mode="Markdown" \
  -d text="${MESSAGE}"
