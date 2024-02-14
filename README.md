# Minimalist Health Check

Small bash script to check if your websites are still alive and return a 200 status code.

## Why ?

This script will be useful if you own a few websites and you want to be notified if one of them is down without manually checking.

You don't need to use a paid service for that.

You can use this script to check if your websites are still alive and return a 200 status code 👍

## How to use it ?

Simply clone the repo or copy the content of `ping_websites.sh` and paste it in a file of your choice.

Some changes need to be made:

1) Inside the `websites` array, write down the websites you wish to monitor (line 11)

2) If you want to receive an alert on Telegram, fill the `telegram_bot_token` and `telegram_chat_id` variables (line 18 and 20)
You can follow [this tutorial](https://www.youtube.com/watch?v=UQrcOj63S2o) to create a bot and [this one](https://www.alphr.com/find-chat-id-telegram/) to get your chat id.

Then you need to make the script executable:

```bash
chmod +x ping_websites.sh
```

You can now run it:

```bash
./ping_websites.sh
```

If everything is okay, you should now consider automatically running the script at intervals of your choice.

If you're under Linux, you can use `cronjob` or `systemd` to run it regularly.

1) To quickly set up a cronjob, run:

```bash
crontab -e
```

It will open a file, add the following line at the end, make sure to replace the path with the right one:

```bash
@reboot /path/to/ping_websites.sh
```

This will run the script at every reboot. Cron enable you to run the script at any interval you want. (Once a month, every Monday, Everyday at 6:00 PM ...)

If you need a more in-depth tutorial, I explained how to easily set up a cronjob and understand expressions in [this article](https://rayan.sh/blog/5).


2) If you prefer to use `systemd`, follow these steps:

I attached an example service file `ping_websites.service` that you can use as a template.
Simply mention the path to the script in the `ExecStart` field and copy the file to `/etc/systemd/system/`.

Then you can enable the service:

```bash
sudo systemctl enable ping_websites.service
```

To check the status of the service:

```bash
sudo systemctl status ping_websites.service
```

And to check the logs:

```bash
sudo journalctl -u ping_websites.service
```


# Disclaimer

This script is not perfect, **not production ready** and most of all **not a replacement for a real monitoring service**. It's just a minimalist and dependancy free way to check if your websites are still alive.

A better way would be to implement real health checks endpoints in your application and regularly fetch them.