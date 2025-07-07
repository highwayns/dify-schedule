import os
import requests

def send_aibotk_msg(title, content):
    api_key = os.getenv("AIBOTK_KEY")
    bot_type = os.getenv("AIBOTK_TYPE", "room")
    name = os.getenv("AIBOTK_NAME")

    url = "http://wechat.aibotk.com/oapi/sendMsg"
    data = {
        "apikey": api_key,
        "type": bot_type,
        "name": name,
        "msg": f"{title}\n{content}"
    }

    res = requests.post(url, json=data)
    print("返回结果:", res.text)

if __name__ == '__main__':
    send_aibotk_msg("🔔 任务完成提醒", "✅ 今日签到已完成")
