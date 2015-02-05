#!/bin/bash

SCRIPT_NAME=`basename $0`
JAVA_EXECUTABLE='bin/java'
JCMD_EXECUTABLE='bin/jcmd'
JCONSOLE_EXECUTABLE='bin/jconsole'
SECURITY_PROPERTIES='lib/security/java.security'
LOCAL_POLICY='lib/security/local_policy.jar'

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $SCRIPT_NAME JAVA_HOME" >&2
  exit 1
fi

if [ ! -f "$1/$JAVA_EXECUTABLE" ]; then
  echo "$1/bin/java not found $1 is not a JDK installation folder" >&2
  exit 1
fi

if [ ! -f "$1/$SECURITY_PROPERTIES" ] && [ ! -f "$1/jre/$SECURITY_PROPERTIES" ]; then
  echo "[jre/]$SECURITY_PROPERTIES not found. $1 is not a Java 8 installation folder" >&2
  exit 1
fi

if [ ! -f "$1/$LOCAL_POLICY" ] && [ ! -f "$1/jre/$LOCAL_POLICY" ]; then
  echo "[jre]/$LOCAL_POLICY not found. $1 is not a JDK 8 installation folder" >&2
  exit 1
fi



"$1/$JAVA_EXECUTABLE" -version

if [ ! -f "$1/$JCMD_EXECUTABLE" ]; then
  echo "JRE"
elif [ ! -f "$1/$JCONSOLE_EXECUTABLE" ]; then
  echo "server JRE"
else
  echo "full JDK"
fi

grep "^securerandom\\.source" "$1"/jre/lib/security/java.security

if [ -d "$1/jre" ]; then
  unzip -qc "$1"/jre/lib/security/local_policy.jar default_local.policy
else
  unzip -qc "$1"/lib/security/local_policy.jar default_local.policy
fi

