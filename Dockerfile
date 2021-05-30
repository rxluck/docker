FROM openjdk:8-jre
MAINTAINER jiacai <jiacai@goeasy.io>

ADD target/${JAR_FILE} /usr/share/myservice/myservice.jar