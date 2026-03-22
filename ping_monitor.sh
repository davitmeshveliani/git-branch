#!/bin/bash

HOST="${1:-8.8.8.8}"
FAILED=0
THRESHOLD=100
INTERVAL=1

echo "--- Monitoring $HOST ---"

while true; do
    # ვუშვებთ პინგს და ვიღებთ მხოლოდ შედეგს
    OUTPUT=$(ping -n 1 -w 1000 "$HOST")
    NOW=$(date +"%H:%M:%S")

    # ვეძებთ დროს (ms) ტექსტში, ენის მიუხედავად
    TIME=$(echo "$OUTPUT" | grep -a "ms" | sed -n 's/.*=\([0-9.]*\)ms.*/\1/p' | tr -d ' ')

    if [ -z "$TIME" ]; then
        FAILED=$((FAILED + 1))
        echo "[$NOW] Connection lost ($FAILED/3)"
        if [ "$FAILED" -ge 3 ]; then
            echo "[$NOW] 🚨 ALERT: 3+ Fails!"
        fi
    else
        FAILED=0
        # წერტილის მოცილება შედარებისთვის
        LATENCY_INT=$(echo "$TIME" | cut -d. -f1)

        if [ "$LATENCY_INT" -gt "$THRESHOLD" ] 2>/dev/null; then
            echo "[$NOW] High Latency: $TIME ms"
        else
            echo "[$NOW] OK: $TIME ms"
        fi
    fi
    sleep $INTERVAL
done


