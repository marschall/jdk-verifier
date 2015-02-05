#!/bin/bash

SCRIPT_NAME=`basename $0`
JAVA_EXECUTABLE='bin/java'
SECURITY_PROPERTIES='jre/lib/security/java.security'
LOCAL_POLICY='jre/lib/security/local_policy.jar'

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $SCRIPT_NAME JAVA_HOME" >&2
  exit 1
fi

if [ ! -f "$1/$JAVA_EXECUTABLE" ]; then
  echo "$1/bin/java not found $1 is not a JDK installation folder" >&2
  exit 1
fi

if [ ! -f "$1/$SECURITY_PROPERTIES" ]; then
  echo "$SECURITY_PROPERTIES not found. $1 is not a Java 8 installation folder" >&2
  exit 1
fi

if [ ! -f "$1/$LOCAL_POLICY" ]; then
  echo "$LOCAL_POLICY not found. $1 is not a JDK 8 installation folder" >&2
  exit 1
fi



"$1/$JAVA_EXECUTABLE" -version

if [ -f "$1"/bin/javadoc ]; then
  echo "full JDK"
else
  echo "server JRE"
fi

grep "^securerandom\\.source" "$1"/jre/lib/security/java.security

unzip -qc "$1"/jre/lib/security/local_policy.jar default_local.policy

