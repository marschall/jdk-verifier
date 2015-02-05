#!/bin/bash

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 JAVA_HOME" >&2
  exit 1
fi

$1/bin/java -version

# use jmap to check if we're dealing with a server jre
if [ -f $1/bin/jmap ]; then
  echo "full JDK"
else
  echo "server JRE"
fi

grep "^securerandom\\.source" $1/jre/lib/security/java.security

unzip -c $1/jre/lib/security/local_policy.jar default_local.policy

