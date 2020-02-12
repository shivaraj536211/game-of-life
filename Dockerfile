FROM tomcat
MAINTAINER shivaraj
ARG CONT_IMG_VER
WORKDIR /root/apache-tomcat-8.5.50/webapps
EXPOSE 8080
COPY  ./A--CI-CD/gameoflife-web/target/gameoflife.war /root/apache-tomcat-8.5.50/webapps

