JDK Verifier
============

A simple script to verify a JDK installation.

Verifies:

 * whether it's a server JRE or full JDK
 * what the secure random source is (entropy gathering device), Java 8+ only
 * whether the JCE unlimited strength jurisdiction policy files have been installed

Usage
-----

```
./jdk-verifier.sh $JAVA_HOME
```

