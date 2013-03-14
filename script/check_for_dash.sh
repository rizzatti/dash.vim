#!/usr/bin/env bash

set -e

APPLESCRIPT=`cat <<EOF
try
  tell application "Finder"
    set appname to name of application file id "com.kapeli.dash"
    return 1
  end tell
on error err_msg number err_num
  return 0
end try
EOF`

retcode=`osascript -e "$APPLESCRIPT"`
exit $retcode
