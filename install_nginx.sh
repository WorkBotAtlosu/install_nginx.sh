#!/bin/bash

# Проверка на выполнение от имени root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запусти скрипт с правами root."
  exit 1
fi

echo "Начинаю установку Nginx..."

# Обновление списков пакетов (на случай, если давно не обновлялись)
apt-get update

# Установка пакета nginx
echo "Устанавливаю пакет nginx..."
apt-get install -y nginx

# Добавление в автозагрузку и немедленный запуск
echo "Добавляю Nginx в автозагрузку и запускаю службу..."
systemctl enable --now nginx

# Проверка статуса
echo "Проверка статуса службы..."
if systemctl is-active --quiet nginx; then
    echo "Nginx успешно установлен и запущен!"
else
    echo "Внимание: Nginx установлен, но не смог запуститься."
    echo "Возможно, порт 80 уже занят службой Apache (httpd2)."
    echo "Проверь логи командой: journalctl -xeu nginx"
fi
