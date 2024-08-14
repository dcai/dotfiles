ckphp() {
  find . -name \*.php \! -exec php -l {} \; | grep "^Errors" --color
}

php_nginx_error_log() {
  local logfile='/var/log/nginx/error.log'
  if [ $# -ge 1 ]; then
    logfile=$1
  fi
  tail -f -n 50 $logfile |
    color.pl -l "\[.*\]","PHP Fatal error","PHP Warning","PHP Notice","Stack trace"
}

php_apache_error_log() {
  local logfile='/var/log/apache2/error_log'
  if [ $# -ge 1 ]; then
    logfile=$1
  fi
  tail -f -n 50 $logfile |
    color.pl -l "\[\:.*\]","error","Error code","line","Stack trace"
}
