# telegram-notifiers
Shell scripts to notify team on some project changes with command line

## Deploy
Use `notify-tg.sh` to send message with current version and commit description to some chat
to get you team notified about some updates deployed.

### Arguments and options

There are
- Required arguments
    - Telegram chat id
    - Telegram Bot token
- Options
    - `-app` to specify app instance name in message

```shell
bash notify-tg.sh "your_chat_id" "your_tg_bot_token" -app "stg.my_project"
```
**Sends message like**:
```text
#deploy
app: `stg.my_project`
version: `v0.0.1`

Some commit message...
```
