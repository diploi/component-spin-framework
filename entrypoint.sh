#!/bin/bash

#
# Container startup script
#

# Replace placeholder in the Apache config with the current component folder 
# (seems there is no way to do this dynamically in apache)
sed -i "s|\${FOLDER}|${FOLDER}|g" /etc/apache2/sites-available/000-default.conf

# Run composer on first start in dev version
if [ ! -d "$FOLDER/vendor" ]; then
  cd "$FOLDER"
  composer update -o --no-dev  
fi

# Start Apache in foreground mode
exec apache2-foreground