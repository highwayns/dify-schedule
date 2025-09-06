#!/bin/bash

# 从环境变量加载信息
BOT_TOKEN="${TG_BOT_TOKEN}"
CHAT_ID="${TG_GROUP_ID}"   # 可以是用户ID 或 -100 开头的群组ID

# 消息内容（可用Markdown或HTML格式）
# 消息内容（可用Markdown或HTML格式）
#MESSAGE="🚀 每日提醒\n\n✅ 请记得提交日报或打卡签到！\n📅 $(date "+%Y-%m-%d")"
NEWS=$(python3 - <<EOF
import yaml
import json
import os
import argparse
from datetime import datetime
import requests
#import schedule
import time
import html

def call_ScheduleTest(platform, purpose):

    # Dify Chat API endpoint
    url = "http://172.17.0.1/v1/workflows/run"

    # 请求头
    headers = {
        "Authorization": "Bearer app-cCPungNOx1UsMA69v8iKRKOD",
        "Content-Type": "application/json"
    }

    # 请求体
    payload = {
        "inputs": {
            "platform": platform,
            "purpose": purpose,
        },
        "user": "abc-123"
    }

    # 发起 POST 请求
    response = requests.post(url, headers=headers, json=payload)

    # 检查响应状态
    if response.status_code == 200:
        result = response.json()
        # 保存响应到文件
        script_text = result.get("data", {}).get("outputs", "").get("text", "")
        #send_to_qinglong(script_text)
        print(f"收到命令: {script_text}")
    else:
        print(f"❌ 请求失败，状态码: {response.status_code}")
        print(html.escape(response.text))

#def send_to_qinglong(command):
    # 示例：通过 exec 发送脚本到容器中执行
#    import subprocess
#    subprocess.run(["docker", "exec", "qinglong", "bash", "-c", command])

# ============ 程序入口 ============

if __name__ == "__main__":
    # 添加命令行参数解析
    #parser = argparse.ArgumentParser(description="Generate Dify schedule test command.")
    #parser.add_argument("platform", type=str, help="platform to send the request to, such as 'qinglong', 'telegram', etc.")
    #parser.add_argument("purpose", type=str, help="purpose of the command.")
    #args = parser.parse_args()
    # 生成工作流配置
    platform = "人工智能"  # 可以根据需要修改
    purpose = "毎日新聞"  # 可以根据需要修改
    call_ScheduleTest(platform, purpose)    

EOF
)

MESSAGE=$(printf "📢 每日新闻播报：\n%s" "$(printf "%s" "$NEWS" | sed 's/\\n/\n/g')")
# 发送 POST 请求到 Telegram API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d parse_mode="Markdown" \
  -d text="${MESSAGE}"
