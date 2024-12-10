# Use an official Tomcat base image
FROM tomcat:9.0-jdk11

# Copy the WAR file to the Tomcat webapps directory
COPY target/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
