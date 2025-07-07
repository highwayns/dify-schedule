<section align="center">
  <a href="https://github.com/leochen-g/dify-schedule" target="_blank">
    <img src="./static/logo.png" alt="Dify" width="260" />
  </a>
</section>

<h1 align="center">Dify工作流定时助手</h1>

<p align="center">由于Dify官方没有定时任务功能，对于一些工作流如果想执行定时任务会比较麻烦，所以才会有这个项目，利用github action 每天定时执行工作流，并发送通知</p>


## 如何使用?
使用自动化工作流有两种方式：快速使用(在线) 和 私有化部署(本地)

- 快速使用自动化：[阅读 使用](#使用)
- 青龙面板添加任务：[阅读 青龙面板使用](#青龙面板使用)

## 使用

自动化执行任务: 支持多个Dify工作流。\
自动化运行时间: 北京时间上午06:30

1. [Fork 仓库](https://github.com/leochen-g/dify-schedule)

2. 仓库 -> Settings -> Secrets -> New repository secret, 添加Secrets变量如下:

   | Name | Value | Required |
   | --- | --- | --- |
   | DIFY_BASE_URL | Dify地址，如果是私有化部署，请确定公网可访问。不填默认为https://api.dify.ai/v1  | 否 |
   | DIFY_TOKENS | Dify工作流API密钥，必填。支持多个，使用`;`分割即可  | 是 |
   | DIFY_INPUTS | Dify工作流需要的变量，如果你在dify配置了必填，请务必配置此变量，同时必须是JSON格式，可以使用JSON在线工具校验一下  | 否 |
   | EMAIL_USER | 发件人邮箱地址(需要开启 SMTP) | 否 |
   | EMAIL_PASS | 发件人邮箱密码(SMTP密码) | 否 |
   | EMAIL_TO | 订阅人邮箱地址(收件人). 如需多人订阅使用 `, ` 分割, 例如: `a@163.com, b@qq.com` | 否 |
   | DINGDING_WEBHOOK | 钉钉机器人WEBHOOK | 否 |
   | PUSHPLUS_TOKEN | [Pushplus](http://www.pushplus.plus/) 官网申请，支持微信消息推送 | 否 |
   | SERVERPUSHKEY | [Server酱](https://sct.ftqq.com//) 官网申请，支持微信消息推送 | 否 |
   | WEIXIN_WEBHOOK | 企业微信机器人WEBHOOK | 否 |
   | FEISHU_WEBHOOK | 飞书机器人WEBHOOK | 否 |
   | AIBOTK_KEY  | OpenAPI发送到微信，注册[智能微秘书](https://wechat.aibotk.com?r=dBL0Bn&f=difySchedule)，个人中心获取apikey | 否 |
   | AIBOTK_ROOM_RECIVER  | [智能微秘书](https://wechat.aibotk.com?r=dBL0Bn&f=difySchedule)需要发送的群名 | 否 |
   | AIBOTK_CONTACT_RECIVER  | [智能微秘书](https://wechat.aibotk.com?r=dBL0Bn&f=difySchedule)需要发送的好友昵称 | 否 |

4. 仓库 -> Actions, 检查Workflows并启用。

## 预览

| Dify工作流执行-微信 | Dify工作流执行-邮件|
|:-----------:| :-----------:|
| ![Dify工作流执行](./static/chat.png) |![Dify工作流执行](./static/chat2.png) |

## 青龙面板使用

1、在青龙面板添加订阅

```shell
ql repo https://github.com/leochen-g/dify-schedule.git "ql_" "utils" "sdk"
ql raw https://raw.githubusercontent.com/highwayns/dify-schedule/refs/heads/main/sdk/dify.py
```
2、在面板菜单-依赖管理-NodeJs 添加依赖 `axios`

3、在环境变量中添加`DIFY_TOKENS` 和 `DIFY_BASE_URL`

青龙面板，添加环境变量`DIFY_TOKENS`和`DIFY_BASE_URL`，支持多个工作流Token，DIFY_TOKENS内容中多个token用`;`分割即可

4、默认使用青龙自带的通知，请自行配置即可

## 常见问题

### 如何获取Dify工作流token

打开Dify网站

> 必须是工作流应用才行，其他应用暂不支持:


<img width="1156" alt="gettoken" src="./static/dify1.png">
<img width="1156" alt="gettoken" src="./static/dify2.png">

### 为什么访问不通

如果你是私有化部署的Dify，请确保公网能够访问，否则在github workflows里肯定无法访问本地部署的服务

### 执行有报错

1、首先确认你的应用是否是工作流应用，目前只支持工作流应用

2、如果有必填的变量输入，请配置环境变量`DIFY_INPUTS`，同时必须是JSON格式，可以使用JSON在线工具校验一下后填入

3、仔细看报错内容提示，根据提示排查问题，或者携带日志提出issues,注意隐藏敏感信息

## 贡献
 
您可以将任何想法作为 [拉取请求](https://github.com/leochen-g/dify-schedule/pulls) 或 [GitHub问题](https://github.com/leochen-g/dify-schedule/issues) 提交。

## 许可

[MIT](./LICENSE)

docker run -dit \
  -v $PWD/ql/data:/ql/data \
  -p 5700:5700 \
  --name qinglong \
  --hostname qinglong \
  --restart unless-stopped \
  whyour/qinglong:latest

  docker exec -it qinglong bash

 命令总览与用法详解：
序号	命令	说明
1	update	更新并重启青龙面板
- 作用：从 GitHub 拉取最新的面板代码并自动重启容器或服务。
- 使用场景：你希望将青龙升级到最新版本时。
2	extra	运行自定义脚本
- 会执行 config 目录下 extra.sh 中定义的脚本。
- 使用场景：你在 extra.sh 中定义了比如环境变量处理、私有脚本安装等逻辑。
3	raw <fileurl>	下载指定脚本文件
- 例子：raw https://example.com/my_script.js
- 使用场景：从外部网址临时获取单个脚本进行调试或执行。
4	repo <repo_url> <path> <blacklist> <dependence> <branch> <extensions>	克隆/拉取脚本仓库
- 这是最常用的命令，用于从 Git 仓库拉取脚本。
- 示例：repo https://github.com/user/repo.git "scripts" "env.js" "requirements.txt" "main" "js py"
- 参数说明：
- repo_url: 仓库地址
- path: 拉取后存放的目录
- blacklist: 拉取时要忽略的文件名
- dependence: 依赖文件名，比如 requirements.txt
- branch: 指定分支，默认是 main
- extensions: 要识别的脚本文件后缀
5	rmlog <days>	删除旧日志
- 删除几天前的任务执行日志。
- 示例：rmlog 7（删除 7 天前的日志）
- 用于定期清理磁盘空间。
6	bot	启动 tg-bot（Telegram 机器人）
- 需提前配置 bot token 和 chat id。
- 可接收通知、执行远程任务命令等。
- 启动后自动监听并运行。
7	check	检测并修复青龙环境问题
- 会检测 Node、Python 环境是否异常，修复依赖、修复路径问题。
- 使用场景：青龙启动异常、脚本执行报错。
8	resetlet	重置登录错误次数
- 你在后台登录输错太多次会被锁，这条命令可解锁。
9	resettfa	禁用两步验证登录（2FA）
- 如果你开启了 2FA 但无法获取验证码，可通过此命令禁用 2FA。
10	resetpwd	重置管理员登录密码
- 运行后系统会提示你输入新密码。
11	resetname	重置管理员用户名
- 运行后提示输入新用户名。

💡 常见使用示例
从 GitHub 拉取脚本仓库：

bash
コピーする
編集する
repo https://github.com/KingRan/KR/main "scripts" "" "" "main" "js"
下载并执行一个脚本：

bash
コピーする
編集する
raw https://raw.githubusercontent.com/xxx/script.js
清理旧日志：

bash
コピーする
編集する
rmlog 10
启动机器人监听 Telegram 命令：

bash
コピーする
編集する
bot
修复青龙环境（如出错或缺少依赖）：

bash
コピーする
編集する
check
🛠️ 故障排查建议
如果你运行命令出现“命令输入错误...”，请检查：

是否在正确的终端容器中执行（如 docker exec -it qinglong bash）。

是否是 root 权限。

是否在青龙 v2.x / v3.x 中使用这些命令（不同版本可能命令变化）。

命令是否拼写错误或缺少必要参数。