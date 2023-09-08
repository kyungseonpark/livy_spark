FROM aizen_spark:j8_s323

USER root
ENV LIVY_HOME /opt/aizen/livy
WORKDIR /opt/aizen/

COPY /built_livy $LIVY_HOME
RUN mkdir $LIVY_HOME/logs \
    && chown -R 1001:1001 $LIVY_HOME

USER 1001
