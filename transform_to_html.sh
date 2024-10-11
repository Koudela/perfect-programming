#!/bin/bash

node node_modules/markdown-to-html-cli/lib/cli.js --source README.md --output var/deploy/index.html --title "Perfect Programming - a pragmatic approach" --author "Thomas Koudela"

sed -i -e 's/max-width: 960px; margin: 0 auto 60px auto; padding: 8px;max-width: 960px;/max-width: 960px; margin: 48px auto 60px auto; padding: 8px;max-width: 960px;/g' var/deploy/index.html
sed -i -e 's/position: fixed; top: 8px; left: 10px; z-index: 999;/position: fixed; top: 8px; left: 10px; z-index: 999; background: grey; padding: 4px; border-radius: 8px;/g' var/deploy/index.html

bash var/deploy/deploy.sh
