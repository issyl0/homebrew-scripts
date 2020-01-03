#!/bin/bash

echo "Diffing homebrew-core and linuxbrew-core..."

for formula in $(diff --new-line-format="" --unchanged-line-format="" <(ls $LINUXBREW_REPO_DIR/Formula/ | sort) <( ls $HOMEBREW_REPO_DIR/Formula/ | sort)); do
  if ! grep "tag \"linux" ${LINUXBREW_REPO_DIR}/Formula/${formula} > /dev/null; then
    echo "The following formulae need deleting in Homebrew/linuxbrew-core:"
    echo $formula
  fi
done
