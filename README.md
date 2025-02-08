# dashj-bls

> A Java library for working with BLS Signatures for Dash

[![Tests](https://github.com/dashevo/dashj-bls/workflows/Java%20CI/badge.svg?branch=master)](https://github.com/dashevo/dashj-bls/actions)
![codecov](https://codecov.io/gh/dashevo/dashj-bls/branch/master/graph/badge.svg)
### Welcome to dashj

The dashj-bls library is a Java implementation of the Dash BLS library.

### Technologies

* Java 11
* [Maven 3+](http://maven.apache.org) - for building the project

### Getting started

To get started, it is best to have the latest JDK and Maven installed. The HEAD of the `master` branch contains the latest development code and various production releases are provided on feature branches.

#### Building from the command line
To initialize the repo after cloning it: 
```
git submodule update  --init --recursive
git apply catch_changes.patch
```
To perform a full build use (this includes the dashjbls shared library):
```
mvn clean package -Dmaven.javadoc.skip=true
```
To perform a full build without building the bls shared library and skip the test:
```
mvn clean package -Pno-build-bls -DskipTests -Dmaven.javadoc.skip=true
```
To perform a full build and install it in the local maven repository:
```
mvn clean install
```
You can also run
```
mvn site:site
```
to generate a website with useful information like JavaDocs.

To publish to maven central:
```bash
mvn deploy -DskipTests -Dmaven.javadoc.skip=true

```


The outputs are under the `target` directory.

#### Deployment

To deploy to the maven repository:

mvn clean deploy -DskipTests -P release

#### Building from an IDE

Alternatively, just import the project using your IDE. [IntelliJ](http://www.jetbrains.com/idea/download/) has Maven integration built-in and has a free Community Edition. Simply use `File | Import Project` and locate the `pom.xml` in the root of the cloned project source tree.

The dashjbls library must still be built with `mvn`.
