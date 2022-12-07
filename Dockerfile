FROM alpine:latest
ADD HelloWorld.class HelloWorld.class
ENTRYPOINT ["java", "HelloWorld"]
