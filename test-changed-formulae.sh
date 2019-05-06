set -x

while read formula; do
    brew uninstall --force ${formula} > /dev/null 2>&1
    brew install ${formula} > /dev/null 2>&1
    brew test ${formula}
    brew audit --strict ${formula}
    brew uninstall --force ${formula} > /dev/null 2>&1
done
