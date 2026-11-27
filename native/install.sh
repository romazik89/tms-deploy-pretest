#!/bin/bash
# Установка TMS (нативный способ) — УЧЕБНЫЙ ПРИМЕР
# ВНИМАНИЕ: не для продакшена без адаптации под вашу среду.
# Требования: Ubuntu/Debian, sudo, .NET Runtime и PostgreSQL установлены.

set -euo pipefail

TMS_USER="tmsusr"
TMS_ROOT="/opt/TMS"
TMS_ARCHIVE="${1:-TMS_version.tar.gz}"  # путь к архиву TMS

echo "== 1. Проверка архива =="
if [[ ! -f "$TMS_ARCHIVE" ]]; then
  echo "Ошибка: архив $TMS_ARCHIVE не найден. Укажите путь: ./install.sh /path/to/TMS.tar.gz"
  exit 1
fi

echo "== 2. Создание пользователя и каталогов =="
id -u "$TMS_USER" &>/dev/null || useradd --system --home "$TMS_ROOT" --shell /usr/sbin/nologin "$TMS_USER"
mkdir -p "$TMS_ROOT/www" "$TMS_ROOT/TmsFileStorage"

echo "== 3. Распаковка архива =="
tar -xzf "$TMS_ARCHIVE" -C "$TMS_ROOT/www"

echo "== 4. Права =="
chown -R "$TMS_USER:$TMS_USER" "$TMS_ROOT"

echo "== 5. systemd-юнит =="
cat > /etc/systemd/system/tmsapp.service <<EOF
[Unit]
Description=TMS Application
After=network.target

[Service]
WorkingDirectory=$TMS_ROOT/www
ExecStart=/usr/share/dotnet/dotnet $TMS_ROOT/www/TMS.WebUI.dll --server.urls=http://0.0.0.0:5000
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=tmsapp
User=$TMS_USER
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now tmsapp

echo "== Готово =="
echo "Проверьте статус: systemctl status tmsapp"
echo "Веб-интерфейс: http://<IP>:5000"
