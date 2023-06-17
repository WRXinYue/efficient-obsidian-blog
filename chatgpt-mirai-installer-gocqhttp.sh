# 安装路径
INSTALL_DIR=./chatgpt-qq

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'


DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-`uname -s`-`uname -m`

echo -e "${GREEN}欢迎使用 chatgpt-mirai-qq-bot 一键部署脚本${PLAIN}"
echo -e "${GREEN}本程序将按照 wiki 步骤自动为您部署程序${PLAIN}"
echo -e "${GREEN}如果您遇到问题可以在这里寻找答案： ${PLAIN}"
echo -e "${YELLOW}https://github.com/lss233/chatgpt-mirai-qq-bot/issues/85${PLAIN}"
echo -e "${GREEN}如果您觉得此脚本对你有帮助的话，欢迎您在爱发电支持作者。${PLAIN}"
echo -e "${YELLOW}https://afdian.net/a/lss233${PLAIN}"

read -p "按下回车以继续……"

# Exit if any error occured
set -euo pipefail

if ! [ -x "$(command -v curl)" ]; then
  echo -e "${RED}错误：${PLAIN} 未检测到 curl，请先安装此程序。" 
fi

if ! [ -x "$(command -v docker)" ]; then
  echo -e "${YELLOW}警告：${PLAIN} 未检测到 Docker。" 
  while true; do
    read -p "是否自动为你安装？是则输入 Y 并回车，否则输入 N 并回车。 " yn
    case $yn in
        [Yy]* ) curl -fsSL https://get.docker.com -o get-docker.sh; sudo -E sh get-docker.sh; rm get-docker.sh; break;;
        [Nn]* ) exit 1;;
        * ) echo "请输入 y 或 n";;
    esac
  done
fi

if ! [ -x "$(command -v docker-compose)" ]; then
  echo -e "${YELLOW}警告：${PLAIN} 未检测到 Docker Compose。" 
  while true; do
    read -p "是否自动为你安装？是则输入 Y 并回车，否则输入 N 并回车。 " yn
    case $yn in
        [Yy]* ) sudo -E curl -L "${DOCKER_COMPOSE_URL}" -o /usr/local/bin/docker-compose; sudo -E chmod +x /usr/local/bin/docker-compose; break;;
        [Nn]* ) exit 1;;
        * ) echo "请输入 y 或 n";;
    esac
  done
fi

if [ -d $INSTALL_DIR ]; then
    echo -e "${RED}错误：检测到本程序已安装在 $(realpath $INSTALL_DIR)，无法重复安装。${PLAIN}" 
    echo -e "${GREEN}如果你想升级，请执行：${YELLOW}"
    echo "cd $INSTALL_DIR"
    echo "docker compose pull"
    echo "docker compose up -d"
    echo -e "${GREEN}如果你想重装，先删除此目录，并重新运行本程序：${PLAIN}"
    exit 1
fi

ask_openai_api() {
  read -p "请输入 OpenAI 的 API Key：" OPENAI_API_KEY
  cat >> $INSTALL_DIR/config.cfg << EOF
[openai]
[[openai.accounts]]
api_key = "${OPENAI_API_KEY}"
EOF
}

ask_openai_email() {
  read -p "请输入 OpenAI 的邮箱地址：" OPENAI_EMAIL
  read -p "请输入 OpenAI 的密码：" OPENAI_PASSWORD
  cat >> $INSTALL_DIR/config.cfg << EOF
[openai]
[[openai.accounts]]
email = "${OPENAI_ACCESS_TOKEN}"
password = "${OPENAI_PASSWORD}"
EOF
}

ask_openai_access_token() {
  echo "使用方法：https://chatgpt-qq.lss233.com/pei-zhi-wen-jian-jiao-cheng/jie-ru-ai-ping-tai/jie-ru-openai-de-chatgpt"
  read -p "请输入 OpenAI 的 access_token：" OPENAI_ACCESS_TOKEN
  cat >> $INSTALL_DIR/config.cfg << EOF
[openai]
[[openai.accounts]]
access_token = "${OPENAI_ACCESS_TOKEN}"
EOF
}

ask_qq() {
  read -p "请输入机器人 QQ 账号：" QQ_ACCOUNT
  read -p "请输入机器人 QQ 密码：" QQ_PASSWORD
  read -p "请输入你自己的 QQ 账号（设置机器人管理员）：" QQ_MANAGER_ACCOUNT

}

download_browser_edition() {
  mkdir -p $INSTALL_DIR/presets

  wget -O $INSTALL_DIR/docker-compose.yaml https://raw.githubusercontent.com/lss233/chatgpt-mirai-qq-bot/browser-version/docker-compose.go-cqhttp.yaml
  wget -O /tmp/awesome-chatgpt-qq-presets-presets.tar.gz https://github.com/lss233/awesome-chatgpt-qq-presets/archive/refs/heads/master.tar.gz
  tar -xzf /tmp/awesome-chatgpt-qq-presets-presets.tar.gz -C $INSTALL_DIR/presets --strip-components=1
}

configure_gocqhttp() {
  mkdir -p $INSTALL_DIR/gocqhttp/
  cat > $INSTALL_DIR/gocqhttp/config.yml << EOF
# go-cqhttp 默认配置文件

account: # 账号相关
  uin: ${QQ_ACCOUNT} # QQ账号
  password: '${QQ_PASSWORD}' # 密码为空时使用扫码登录
  encrypt: false  # 是否开启密码加密
  status: 0      # 在线状态 请参考 https://docs.go-cqhttp.org/guide/config.html#在线状态
  relogin: # 重连设置
    delay: 3   # 首次重连延迟, 单位秒
    interval: 3   # 重连间隔
    max-times: 0  # 最大重连次数, 0为无限制

  # 是否使用服务器下发的新地址进行重连
  # 注意, 此设置可能导致在海外服务器上连接情况更差
  use-sso-address: true

heartbeat:
  # 心跳频率, 单位秒
  # -1 为关闭心跳
  interval: 5

message:
  # 上报数据类型
  # 可选: string,array
  post-format: string
  # 是否忽略无效的CQ码, 如果为假将原样发送
  ignore-invalid-cqcode: false
  # 是否强制分片发送消息
  # 分片发送将会带来更快的速度
  # 但是兼容性会有些问题
  force-fragment: false
  # 是否将url分片发送
  fix-url: false
  # 下载图片等请求网络代理
  proxy-rewrite: ''
  # 是否上报自身消息
  report-self-message: false
  # 移除服务端的Reply附带的At
  remove-reply-at: false
  # 为Reply附加更多信息
  extra-reply-data: false
  # 跳过 Mime 扫描, 忽略错误数据
  skip-mime-scan: false

output:
  # 日志等级 trace,debug,info,warn,error
  log-level: warn
  # 日志时效 单位天. 超过这个时间之前的日志将会被自动删除. 设置为 0 表示永久保留.
  log-aging: 15
  # 是否在每次启动时强制创建全新的文件储存日志. 为 false 的情况下将会在上次启动时创建的日志文件续写
  log-force-new: true
  # 是否启用日志颜色
  log-colorful: true
  # 是否启用 DEBUG
  debug: false # 开启调试模式

# 默认中间件锚点
default-middlewares: &default
  # 访问密钥, 强烈推荐在公网的服务器设置
  access-token: ''
  # 事件过滤器文件目录
  filter: ''
  # API限速设置
  # 该设置为全局生效
  # 原 cqhttp 虽然启用了 rate_limit 后缀, 但是基本没插件适配
  # 目前该限速设置为令牌桶算法, 请参考:
  # https://baike.baidu.com/item/%E4%BB%A4%E7%89%8C%E6%A1%B6%E7%AE%97%E6%B3%95/6597000?fr=aladdin
  rate-limit:
    enabled: false # 是否启用限速
    frequency: 1  # 令牌回复频率, 单位秒
    bucket: 1     # 令牌桶大小

database: # 数据库相关设置
  leveldb:
    # 是否启用内置leveldb数据库
    # 启用将会增加10-20MB的内存占用和一定的磁盘空间
    # 关闭将无法使用 撤回 回复 get_msg 等上下文相关功能
    enable: true

  # 媒体文件缓存， 删除此项则使用缓存文件(旧版行为)
  cache:
    image: data/image.db
    video: data/video.db

# 连接服务列表
servers:
  - ws-reverse:
      universal: ws://chatgpt:8554/ws

EOF
  cat >> $INSTALL_DIR/config.cfg << EOF
[onebot]
qq=${QQ_ACCOUNT}
manager_qq=${QQ_MANAGER_ACCOUNT}
# 此处保持默认设置，无需修改
reverse_ws_port = 8554
EOF

}


if ! pgrep docker > /dev/null; then
  echo "Docker is not running. Starting Docker..."
  systemctl start docker.service
fi

echo "Docker is running."

mkdir -p $INSTALL_DIR
download_browser_edition
ask_qq
configure_gocqhttp


echo -e "${GREEN}请选择你的 OpenAI 登录方式：${PLAIN}"
echo -e "${GREEN}如果你想接入其他 AI，请阅读项目文档。${PLAIN}"
echo "1) accessToken 登录 （网页版 ChatGPT、Plus）"
echo "2) api_key 登录 （API 版 ChatGPT）"
while true; do
  read -p "你的选择： " yn
  case $yn in
      1 ) ask_openai_access_token; break;;
      2 ) ask_openai_api; break;;
      * ) echo "请输入对应的数字";;
  esac
done

cd $INSTALL_DIR

echo -e "${GREEN}很棒！你已经完成了所有的初始化步骤。${PLAIN}"
echo -e "${GREEN}接下来为你启动程序……${PLAIN}"
echo "+ docker-compose up -d"
docker-compose up -d
echo -e "${GREEN}程序已被安装在 ${INSTALL_DIR} 下，${PLAIN}"
echo -e "${GREEN}以下是一些维护的注意事项：${PLAIN}"  && sleep 5
echo -e "${GREEN}1. 你需要先 ${YELLOW}cd ${INSTALL_DIR} ${GREEN} 才能进入到程序的安装目录。${PLAIN}"  && sleep 5
echo -e "${GREEN}2. 你可以输入${YELLOW}docker-compose logs -f --tail=100 ${GREEN}来观察运行日志。${PLAIN}"  && sleep 5
echo -e "${GREEN}3. 修改配置文件后，使用 ${YELLOW}docker-compose restart ${GREEN}重启程序。${PLAIN}"  && sleep 5
echo -e "${GREEN}4. 使用 ${YELLOW}docker-compose pull && docker-compose up -d ${GREEN}命令来更新程序${PLAIN}"  && sleep 5
echo -e "${GREEN}如果你记不住的话，可以把上面这段文字保存到一个文件里面，需要的时候再看。${PLAIN}"   && sleep 5
echo -e "${GREEN}如果您遇到问题可以在这里寻找答案： ${PLAIN}"
echo -e "${YELLOW}https://chatgpt-qq.lss233.com/${PLAIN}"   && sleep 5
echo -e "${GREEN}如果您觉得此脚本对你有帮助的话，欢迎您在爱发电支持作者。${PLAIN}"
echo -e "${YELLOW}https://afdian.net/a/lss233${PLAIN}"
echo -e "${GREEN}再见。${PLAIN}"