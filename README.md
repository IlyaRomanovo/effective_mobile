Установка и настройка

Создание скрипта для мониторинга

`sudo vim /usr/local/bin/test_monitoring.sh`
`sudo chmod +x /usr/local/bin/test_monitoring.sh`

Создание systemd сервиса и таймера

`sudo vim /etc/systemd/system/test_monitoring.service`
`sudo vim /etc/systemd/system/test_monitoring.timer`

Создание лог-файла

`sudo touch /var/log/monitoring.log`
`sudo chmod 644 /var/log/monitoring.log`

Активация и запуск

`sudo systemctl daemon-reload`
`sudo systemctl enable test_monitoring.service`
`sudo systemctl enable test_monitoring.timer`
`sudo systemctl start test_monitoring.timer`

Проверка статуса таймера

`sudo systemctl status test_monitoring.timer`
