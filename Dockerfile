# 使用Tomcat作为基础镜像
FROM tomcat:9.0-jdk8-openjdk

# 设置工作目录
WORKDIR /usr/local/tomcat

# 删除Tomcat默认的webapps内容
RUN rm -rf webapps/*

# 复制WAR文件到Tomcat的webapps目录
COPY target/HospitalManage-1.0-SNAPSHOT.war webapps/ROOT.war

# 解压WAR文件以便后续可以修改配置文件
RUN cd webapps && \
    unzip -q ROOT.war -d ROOT && \
    rm -f ROOT.war

# 暴露Tomcat端口
EXPOSE 8080

# 启动Tomcat
CMD ["catalina.sh", "run"]

