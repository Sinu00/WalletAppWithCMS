# Use the official Tomcat image as the base
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /app

# Copy the source code to the image
COPY . /app

# Run Maven to build the WAR file
RUN apt-get update && apt-get install -y maven && mvn clean package

# Copy the WAR file to the Tomcat webapps directory
COPY target/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
