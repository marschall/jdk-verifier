#!/bin/bash

SCRIPT_NAME=`basename $0`
JAVA_EXECUTABLE='bin/java'
JCMD_EXECUTABLE='bin/jcmd'
JCONSOLE_EXECUTABLE='bin/jconsole'
SECURITY_PROPERTIES='lib/security/java.security'
LOCAL_POLICY='lib/security/local_policy.jar'

print_usage_and_exit() {

[ -n "$1" ] && echo "$1"

  cat << EOF

Usage: $SCRIPT_NAME <javadir>
   or: $SCRIPT_NAME -h|--help

  <javadir>: Directory containing the Java installation
  -h, --help: Prints this help message
EOF

  [ -n "$1" ] && exit 1
  exit 0
}

# Input validation
[ "$#" -ne 1 ] && print_usage_and_exit "Wrong number of arguments"
[ "$1" = "-h" ] || [ "$1" = "--help" ] && print_usage_and_exit
[ ! -d "$1" ] && print_usage_and_exit "$1 is not a directory"

if [ -d "$1/jre" ]; then
  SECURITY_PROPERTIES="jre/$SECURITY_PROPERTIES"
  LOCAL_POLICY="jre/$LOCAL_POLICY"
fi

NOT_JAVA8_MSG="'$1' is not a Java 8 installation folder"
[ ! -f "$1/$JAVA_EXECUTABLE" ] &&  print_usage_and_exit "'$JAVA_EXECUTABLE' not found. $NOT_JAVA8_MSG"
[ ! -f "$1/$SECURITY_PROPERTIES" ] && print_usage_and_exit "'$SECURITY_PROPERTIES' not found. $NOT_JAVA8_MSG"
[ ! -f "$1/$LOCAL_POLICY" ] && print_usage_and_exit "'$LOCAL_POLICY' not found. $NOT_JAVA8_MSG"

# Main
"$1/$JAVA_EXECUTABLE" -version

echo
if [ ! -f "$1/$JCMD_EXECUTABLE" ]; then
  echo "Java Installation: JRE"
elif [ ! -f "$1/$JCONSOLE_EXECUTABLE" ]; then
  echo "Java Installation: server JRE"
else
  echo "Java Installation: full JDK"
fi

echo
grep "^securerandom\\.source" "$1/$SECURITY_PROPERTIES"

echo
echo "default_local.policy"
unzip -qc "$1/$LOCAL_POLICY" default_local.policy

