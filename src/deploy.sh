#!/bin/bash

###> Colors ###
RED_COLOR='\033[0;31m'
CYAN_COLOR='\033[0;36m'
COLOR_OFF='\033[0m'
###< Colors ###

###> Telegram config
CHAT_ID=$1
if [ ! "$CHAT_ID" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide telegram chat id"
fi
BOT_TOKEN=$2
if [ ! "$BOT_TOKEN" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide telegram bot token"
fi
###< Telegram config

###> Getting version
WORKDIR="."
VERSION_FILE=$WORKDIR/VERSION
if [ ! -f "$VERSION_FILE" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: ${CYAN_COLOR}$VERSION_FILE${COLOR_OFF} not found"
fi
VERSION="$(cat $VERSION_FILE)"

# Getting current git branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT_MESSAGE=$(git log -1 origin "$BRANCH" --pretty=%B)
###< Getting version

###> Build message ###
MESSAGE="#deploy "
APP=""
while [ -n "$1" ]
do
# Specify app instance name
case "$1" in
-app)
  if [ ! "$2" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: app instance name"
    exit 128
  fi
  APP=$2
  ;;
esac

shift
done

if [ "$APP" ]; then
  MESSAGE="$MESSAGE
app: \`$APP\`"
fi

MESSAGE="$MESSAGE
version: \`$VERSION\`

$COMMIT_MESSAGE
"
###< Build message ###

###> Send message ###
curl -X POST -s -d "chat_id=$CHAT_ID" -d "disable_web_page_preview=true" -d "parse_mode=Markdown" -d "text=$MESSAGE" https://api.telegram.org/bot"$BOT_TOKEN"/sendMessage > /dev/null
###< Send message ###


