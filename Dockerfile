FROM tomcat:9-jre9
COPY ./target/abhi.war /usr/local/tomcat/webapps/
