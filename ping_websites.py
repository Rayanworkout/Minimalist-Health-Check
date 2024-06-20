import requests

urls = [
    "https://rayan.sh",
    "url_2",
    "url_3",
    ...
]

# Telegram bot token and chat id
telegram_bot_token = "TOKEN"
telegram_chat_id = "CHAT_ID"

s = requests.Session()

# Ping url with a timeout
for url in urls:
    try:
        s.get(url, timeout=6)
        print(f"{url} is up")

    except (requests.ConnectionError, Exception):
        msg = f"{url} is down"

        s.get(
            f"https://api.telegram.org/bot{telegram_bot_token}/sendMessage?chat_id={telegram_chat_id}&text={msg}"
        )
