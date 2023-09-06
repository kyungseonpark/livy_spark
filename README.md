# livy_spark

## Information
### Description
This repository was created for versioning tests for livy and Spark

Apache Livy: 0.9.0 (nightly, github master branch 23-09-05)

Apache Spark: 3.2.3+Hadoop2.7

### environment
MacOS 13.2

Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)

## for Use
### 1. Build Livy
```shell
cd livy/incubator-livy
mvn clean package -B -V -e \                                                                         
        -Pspark3 \     
        -Pthriftserver \
        -DskipTests \
        -DskipITs \
        -Dmaven.javadoc.skip=true
```
### 2. if you want to change spark version
check /spark/linux_os/rootfs/opt/aizen/spark

### 3. docker compose up
```shell
cd /livy
docker compose up --build
```