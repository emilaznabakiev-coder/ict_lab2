#!/usr/bin/env bash
set -e

SOURCE_DIR="$HOME/ict_lab2/docs"
BACKUP_DIR="$HOME/ict_lab2/backup"
LOG_FILE="$HOME/ict_lab2/logs/backup.log"

# Проверка существования исходного каталога (Обработка ошибок)
if [ ! -d "$SOURCE_DIR" ]; then
  echo "[ERROR] Исходный каталог $SOURCE_DIR не существует!" >&2
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# Создание архива каталога docs
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$HOME/ict_lab2" docs

# Запись строки в журнал (лог)
echo "[$TIMESTAMP] Резервная копия $BACKUP_NAME успешно создана." >> "$LOG_FILE"

# Удаление архивов старше 7 дней
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm -f {} \;
