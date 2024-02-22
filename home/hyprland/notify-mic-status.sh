mic_status=$(amixer get Capture | awk '/\[on\]/{print $6; exit}')

if [ "$mic_status" == "[on]" ]; then
  notify-send "Mic unmuted"
else
  notify-send "Mic muted"
fi