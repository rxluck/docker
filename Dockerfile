FROM ubuntu:18.04
MAINTAINER jiacai
ADD sso/${WAR_FILE} /usr/share/service/sso.war
ADD center/${WAR_FILE} /usr/share/service/center.war