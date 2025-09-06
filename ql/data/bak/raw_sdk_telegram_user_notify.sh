#!/bin/bash

# 从环境变量加载信息
BOT_TOKEN="${TG_BOT_TOKEN}"
CHAT_ID="${TG_USER_ID}"   # 可以是用户ID 或 -100 开头的群组ID

# 消息内容（可用Markdown或HTML格式）
#MESSAGE="🚀 每日提醒\n\n✅ 请记得提交日报或打卡签到！\n📅 $(date "+%Y-%m-%d")"
NEWS=$(curl -s "https://news.baidu.com/n?cmd=4&class=civilnews&tn=rss" | grep -o "<title>[^<]*</title>" | sed 's/<\/\?title>//g' | sed '1d' | head -5)

MESSAGE="📢 每日新闻播报：\n${NEWS}"

# 发送 POST 请求到 Telegram API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d parse_mode="Markdown" \
  -d text="${MESSAGE}"
