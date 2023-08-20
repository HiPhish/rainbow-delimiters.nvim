set -l shells "$SHELL" /bin/{zsh,bash,sh} (which nu) /usr/bin/xonsh

echo "Your first few shells is $shells[1..3]"

if set -q shells[10]
    echo "You defined at least 10 shells"
end
