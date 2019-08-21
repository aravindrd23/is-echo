# How to use this project
    1. Pull the project to local machine using git clone.
         ``git clone <project location>``
    2. cd to the directory
    Gradle:
        Compile:
             ``./gradlew clean build``
        Run project
             ``./gradlew bootrun``
        Run project using a profile
        "java -jar -Dspring.profiles.active=<profile-name> build/libs/is-echo-health-1.0.0.jar"

    Maven:
       Compile:
        mvn clean install
       Run project
        mvn spring-boot:run
    
# Go to urls ans see it's working
    1. Get environment variables
         ``http://localhost:8080/env``
    2. Get all the end points available in the application
         ``http://localhost:8080/management``
         Azure end points
            "http://localhost:8080/zu2health"
            "http://localhost:8080/zu2management"
            "http://localhost:8080/zu2env"
    3. Swagger ui
         ``http://localhost:8080/swagger-ui.html``
