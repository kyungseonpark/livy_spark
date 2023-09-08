# livy_spark

## Information
### Description
This repository was created for versioning tests for livy and Spark

Apache Livy: 0.9.0 (nightly, github master branch 23-09-08, commit 8b2e29fe9fd42c20395c63e1571f2492f005162b)

Apache Spark: 3.2.3+Hadoop2.7

I created a Spark image using https://github.com/bitnami/containers/tree/main/bitnami/spark as a reference.

### environment
MacOS 13.2

Apache Maven 3.8.6

## for Use
### 1. Build Livy
```shell
sh build.sh
```

### 2. docker compose up
```shell
docker compose up --build
```
