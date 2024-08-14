#!/bin/bash
# $HOME/.config/composer/vendor/squizlabs/php_codesniffer/CodeSniffer.conf
# P_MOODLE=$HOME/.local/phpcs/moodle
P_WP=$HOME/.local/phpcs/wordpress

mkdir -p $P_WP

git clone --depth=1 -b master https://github.com/WordPress/WordPress-Coding-Standards.git $P_WP
# git clone https://github.com/moodlehq/moodle-local_codechecker.git $P_MOODLE --depth=1

phpcs_ipath=$(phpcs --config-show installed_paths)
oldpath=${phpcs_ipath##*:}
phpcs --config-set installed_paths ${oldpath},$P_WP
phpcs --config-show installed_paths
phpcs -i
# PEAR, Zend, PSR2, MySource, Squiz, PSR1, PSR12, WordPress, WordPress-Extra, WordPress-Docs and WordPress-Core
