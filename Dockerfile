FROM adoptopenjdk/openjdk11:alpine-jre
EXPOSE 8080
ARG APP_NAME="spring-boot-ci-cd"
ARG APP_VERSION="0.0.1"
ARG JAR_FILE="/build/libs/${APP_NAME}-${APP_VERSION}.jar"

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "app.jar"]
#
#FROM jenkins/jenkins:lts
## Install Slack Notification Plugin
#RUN jenkins-plugin-cli --plugins "slack:2.47"
#RUN jenkins-plugin-cli --plugins "configuration-as-code"
#RUN jenkins-plugin-cli --plugins "global-slack-notifier"
#ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs/jenkins.yaml
#COPY casc.yaml /var/jenkins_home/casc_configs/jenkins.yaml
#CMD ["java", "-Djenkins.install.runSetupWizard=false", "-jar", "/usr/share/jenkins/jenkins.war"]