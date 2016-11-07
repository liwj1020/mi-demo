# Base image
FROM centos:latest
ENV TZ Asia/Shanghai
# install tools
RUN yum install git java-1.8.0-openjdk-devel  -y

# install tomcat

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
RUN cd /root && curl -o apache-tomcat.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.72/bin/apache-tomcat-7.0.72.tar.gz && tar -zxvf apache-tomcat.tar.gz && mv /root/apache-tomcat-7.0.72/* /usr/local/tomcat/ && rm -rf /usr/local/tomcat/webapps/* && rm -rf apache-tomcat*

# copy war to tomcat
COPY mi.war /usr/local/tomcat/webapps/ROOT.war

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
# 
WORKDIR $CATALINA_HOME
EXPOSE 8080
CMD ["catalina.sh", "run"]
