#!/bin/bash

# /!\ Disclaimer /!\
# This script is not perfect, not production ready and most of all 
# not a replacement for a real monitoring service. It's just a simple way
# to check if your websites are still alive. A better way would be to implement
# real health checks endpoints in your application and regularly fetch them.

# List of websites to check
# Note that they are not comma separated
websites=(
"https://rayan.sh"
"https://another-website.com"
)


# If you wish to send a message to a telegram channel or group, fill these
telegram_bot_token="YOUR BOT TOKEN" # without "bot"
# The chat id where you want to receive messages
telegram_chat_id="YOUR CHAT ID"

# Function to extract domain from a full url
# https://example.com/some/path => example.com
extract_domain() {
    local url="$1"
    local domain=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
    echo "$domain"
}

# Function to check status codes returned by a specific website
check_website() {
    local url="$1"
    # using -L to follow any redirect
    local status_code=$(curl -s -o /dev/null -w "%{http_code}" -L "$url")

    if [ $status_code -ne 200 ]; then
        "$url is offline (code $status_code)"

        # Extract domain from full url
        local domain=$(extract_domain "$url")
        local msg=$(jq -rn --arg x "$domain is offline. (status $status_code)" '$x|@uri')
        local tg_url="https://api.telegram.org/bot$telegram_bot_token/sendMessage?chat_id=$telegram_chat_id&text=$msg"
        local resp=$(curl -s "$tg_url")

        # Or do what you want here
        #
        #
        #
        #
        #

    else
        echo -e " \xE2\x9C\x93 $url"
    fi
}

# Loop through websites
for url in "${websites[@]}"; do
    check_website "$url"
done
