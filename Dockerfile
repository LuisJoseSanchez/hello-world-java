FROM alpine:latest
ENV JAVA_HOME C:\Program Files\Java\jdk-11.0.14
ENV PATH $PATH:C:\Program Files\Java\jdk-11.0.14\bin
ADD HelloWorld.class HelloWorld.class
ENTRYPOINT ["java", "HelloWorld"]
