#!/bin/bash

SCRIPT_NAME=`basename $0`


if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $SCRIPT_NAME JAVA_HOME" >&2
  exit 1
fi

if [ ! -f "$1"/bin/java ]; then
  echo "$1/bin/java not found $1 is not a JDK installation folder" >&2
  exit 1
fi

if [ ! -f "$1"/jre/lib/security/java.security ]; then
  echo "$1/jre/lib/security/java.security not found $1 is not a JDK 8 installation folder" >&2
  exit 1
fi

if [ ! -f "$1"/jre/lib/security/local_policy.jar ]; then
  echo "$1/jre/lib/security/local_policy.jar not found $1 is not a JDK 8 installation folder" >&2
  exit 1
fi



"$1"/bin/java -version

if [ -f "$1"/bin/javadoc ]; then
  echo "full JDK"
else
  echo "server JRE"
fi

grep "^securerandom\\.source" "$1"/jre/lib/security/java.security

unzip -qc "$1"/jre/lib/security/local_policy.jar default_local.policy

