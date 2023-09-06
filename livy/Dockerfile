FROM aizen_spark:230905

USER root
ENV LIVY_HOME /opt/aizen/livy
WORKDIR /opt/aizen/

COPY /livy/incubator-livy $LIVY_HOME
RUN mkdir $LIVY_HOME/logs \
    && chown -R 1001:1001 $LIVY_HOME

USER 1001
