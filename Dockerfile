FROM openjdk:8-jre-alpine

#WORKDIR ${application.workdir}
#COPY ${application.dependencies} ${application.dependencies}
#COPY ${project.build.finalName}.jar ${project.build.finalName}.jar

COPY is-echo-health-1.0.0.jar is-echo-health-1.0.0.jar

ENTRYPOINT ["/usr/bin/java", "-jar", "is-echo-health-1.0.0.jar"]
EXPOSE 8080