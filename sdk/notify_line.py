import os
import requests

def push_line_message(to, msg):
    token = os.getenv("LINE_TOKEN")
    url = "https://api.line.me/v2/bot/message/push"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    data = {
        "to": to,
        "messages": [
            {
                "type": "text",
                "text": msg
            }
        ]
    }
    res = requests.post(url, json=data, headers=headers)
    print("LINE推送结果:", res.status_code, res.text)

if __name__ == '__main__':
    user_id = os.getenv("LINE_USER_ID")
    message = "📢 青龙定时任务执行完成 ✅"
    push_line_message(user_id, message)
