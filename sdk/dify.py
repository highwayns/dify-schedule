import yaml
import json
import os
import argparse
from datetime import datetime
import requests
#import schedule
import time

def call_ScheduleTest(platform, purpose):

    # Dify Chat API endpoint
    url = "http://localhost/v1/workflows/run"

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
        print(response.text)

#def send_to_qinglong(command):
    # 示例：通过 exec 发送脚本到容器中执行
#    import subprocess
#    subprocess.run(["docker", "exec", "qinglong", "bash", "-c", command])

# ============ 程序入口 ============

if __name__ == "__main__":
    # 添加命令行参数解析
    parser = argparse.ArgumentParser(description="Generate Dify schedule test command.")
    parser.add_argument("platform", type=str, help="platform to send the request to, such as 'qinglong', 'telegram', etc.")
    parser.add_argument("purpose", type=str, help="purpose of the command.")
    args = parser.parse_args()
    # 生成工作流配置
    call_ScheduleTest(args.platform, args.purpose)

    print(f"✅ 生成完了！")