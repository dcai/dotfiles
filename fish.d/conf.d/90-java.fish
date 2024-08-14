set -gx JAVA_TOOL_OPTIONS "-Dfile.encoding=UTF8"
set -gx MAVEN_OPTS "-Xmx512m -XX:MaxPermSize=350m -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true -Dwebdriver.chrome.driver=/usr/local/bin/chromedriver"
