# ETAPA 1: Construcción (Build)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /Springboot-API-REST-DESPACHO
COPY /Springboot-API-REST-DESPACHO/pom.xml .
COPY /Springboot-API-REST-DESPACHO/src ./src
RUN mvn dependency:go-offline
RUN mvn clean package -DskipTests

# ETAPA 2: Ejecución (Runtime)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# CORREGIDO: Cambiar /app/target por /Springboot-API-REST/target
COPY --from=build /Springboot-API-REST-DESPACHO/target/*.jar app.jar


# REQUISITO DE SEGURIDAD: Usuario no root (Ajustado para Alpine)
RUN addgroup -S devopsgroup && adduser -S devopsuser -G devopsgroup
USER devopsuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
