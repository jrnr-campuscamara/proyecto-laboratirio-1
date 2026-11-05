# Copiamos Hadoop de la imagen que ya usas
FROM apache/hadoop:3.4.0 AS hadoop

# Base con Java 8 (la versión que necesita Sqoop)
FROM eclipse-temurin:8-jdk
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Hadoop + nuestra configuración
COPY --from=hadoop /opt/hadoop /opt/hadoop
COPY core-site.xml /opt/hadoop/etc/hadoop/core-site.xml

ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_COMMON_HOME=/opt/hadoop \
    HADOOP_HDFS_HOME=/opt/hadoop \
    HADOOP_MAPRED_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    SQOOP_HOME=/opt/sqoop
ENV PATH=$PATH:/opt/hadoop/bin:/opt/sqoop/bin

# Sqoop 1.4.7 + driver de MySQL + librería que le falta con Hadoop 3
RUN curl -fSL https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz | tar -xz -C /opt \
 && mv /opt/sqoop-1.4.7.bin__hadoop-2.6.0 /opt/sqoop \
 && curl -fSL -o /opt/sqoop/lib/mysql-connector-j-8.0.33.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
 && curl -fSL -o /opt/sqoop/lib/commons-lang-2.6.jar https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar

# ---------- PARTE B: Flume 1.11.0 + editor nano ----------
RUN apt-get update && apt-get install -y --no-install-recommends nano && rm -rf /var/lib/apt/lists/*

ENV FLUME_HOME=/opt/flume
ENV PATH=$PATH:/opt/flume/bin

RUN curl -fSL https://archive.apache.org/dist/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz | tar -xz -C /opt \
 && mv /opt/apache-flume-1.11.0-bin /opt/flume \
 && rm -f /opt/flume/lib/guava-*.jar \
 && curl -fSL -o /opt/flume/lib/guava-27.0-jre.jar https://repo1.maven.org/maven2/com/google/guava/guava/27.0-jre/guava-27.0-jre.jar \
 && curl -fSL -o /opt/flume/lib/failureaccess-1.0.jar https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0/failureaccess-1.0.jar
WORKDIR /root
CMD ["sleep", "infinity"]


#####