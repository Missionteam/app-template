#!/bin/bash

# ログファイルを監視して、「Installing build」という文字列が出現したら通知を送信
tail -f /path/to/flutter_log.txt | while read line
do
  if [[ "$line" == *"Installing build"* ]]; then
    osascript -e 'display notification "Flutter App Installed" with title "Flutter Build"'
  fi
done
