#!/bin/bash
ctags -R --languages=php \
    --php-kinds=+cf-v \
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/^interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)+function ([^ (]*)/\2/f/' \
    --exclude="CVS" \
    --exclude=".git" \
    --exclude=".svn" \
    --exclude="wp-admin/includes/noop.php" \
    --exclude="wp-content/plugins/*" \
    --exclude="wp-includes/ID3/*" \
    --exclude="lib/yuilib/*" \
    --exclude="lib/adodb/*" \
    --exclude="vendor/*" \
    --exclude="theme/*" \
    --exclude="lang/*" \
    --exclude="blocks/configurable_reports/*" \
    --exclude="mod/apply/*" \
    --exclude="mod/attendance/*" \
    --exclude="mod/dataform/*" \
    --exclude="backup/util/ui/*" \
    --exclude="local/codechecker/*" \
    --exclude="local/tophat/*" \
    --exclude="lib/simplepie/*" \
    --exclude="lib/htmlpurifier/*" \
    --exclude="lib/phpexcel/*" \
    --exclude="lib/typo3/*" \
    --exclude="lib/phpmailer/*" \
    --exclude="lib/google/*" \
    --exclude="lib/tcpdf/*" \
    --exclude="lib/pear/*" \
    --exclude="lib/phpunit/*" \
    --exclude="lib/php-css-parser/*" \
    --exclude="lib/dml/mysqli*" \
    --exclude="lib/dml/mssql*" \
    --exclude="lib/dml/maria*" \
    --exclude="lib/dml/pdo*" \
    --exclude="lib/dml/pgsql*" \
    --exclude="lib/dml/sqlsrv*" \
    --exclude="lib/dml/oci*" \
    --exclude="lib/ddl/postgresql*" \
    --exclude="lib/ddl/mysql*" \
    --exclude="lib/ddl/oracle*" \
    --exclude="*.js" \
    --exclude="*.html"
