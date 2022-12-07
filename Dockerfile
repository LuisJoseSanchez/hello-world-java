FROM openjdk:11.0.7
ADD HelloWorld.class HelloWorld.class
ENTRYPOINT ["java", "HelloWorld"]
