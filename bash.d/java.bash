### https://docs.oracle.com/javase/8/docs/technotes/tools/unix/
## Monitor the JVM
# jps
# jstat
# jstatd
# jmc

## Monitor Java Application
# jconsole
# jvisualvm
killjava() {
  #ps xu | grep java | grep -v grep | awk '{ print $2 }' | xargs kill -9
  pgrep java | xargs kill -9
}

mvn-init() {
  groupid=$1
  project=$2
  mvn archetype:generate -DgroupId="${groupid}" \
    -DartifactId="${project}" \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false
}

scala-init() {
  mkdir -p src/main/{resources,scala,java} src/test/{resources,scala,java}
}

killequellaserver() {
  #PID=$(ps xu | grep equellaserver | grep -v grep | awk '{ print $2 }')
  PID=$(pgrep equellaserver)
  if [[ -z "$PID" ]]; then
    echo 'There is no active EQUELLA server'
  else
    kill -9 "$PID"
  fi
}

mvn-java-app() {
  mvn archetype:generate -DgroupId=org.dongsheng -DartifactId="$1" \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false
}
