#!/bin/bash


LOG_FILE="/var/log/test_monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"
PROCESS_NAME="test"

STATUS_FILE="/tmp/test_monitoring.status"


log_message() {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

is_process_running() {
        pgrep -x "$PROCESS_NAME" > /dev/null
}

send_request() {
        if curl -s -f --max-time 10 "$MONITORING_URL" > /dev/null; then
                return 0
        else
                log_message "ERROR: The monitoring server is unavailable"
                return 1
        fi

}

get_previous_status() {
        if [[ -f "$STATUS_FILE" ]]; then
                cat "$STATUS_FILE"
        else
                echo "unknown"
        fi
}

save_current_status() {
        echo "$1" > "$STATUS_FILE"
}

main() {
        local current_status
        local previous_status

        if is_process_running; then
                current_status="running"

                send_request

                previous_status=$(get_previous_status)
                if [[ "$previous_status" == "not_running" ]]; then
                        log_message "INFO: Process $PROCESS_NAME was restarted"
                fi

        else
                current_status="not_running"
        fi

        save_current_status "$current_status"
}


main "$@"