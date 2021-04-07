# Build stage
FROM maven:3-jdk-11 as build
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends nodejs

RUN useradd -m vaadindockerbuild
WORKDIR /app
RUN chown vaadindockerbuild:vaadindockerbuild /app
USER vaadindockerbuild

COPY --chown=vaadindockerbuild pom.xml ./
RUN mvn dependency:go-offline -Pproduction

COPY --chown=vaadindockerbuild:vaadindockerbuild src src
COPY --chown=vaadindockerbuild:vaadindockerbuild frontend frontend
COPY --chown=vaadindockerbuild:vaadindockerbuild package.json webpack.config.js ./

RUN mvn clean package -DskipTests -Pproduction

# Run stage
FROM openjdk:11

COPY --from=build /app/target/*.jar /usr/app/app.jar
RUN useradd -m vaadindockerbuild

USER vaadindockerbuild

EXPOSE 8080

CMD java -jar /usr/app/app.jar
