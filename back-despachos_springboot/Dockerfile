# ETAPA 1: Construcción (Build)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
RUN mvn clean package -DskipTests

# ETAPA 2: Ejecución (Runtime) - AQUÍ ESTÁ EL CAMBIO TÉCNICO
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copiamos el archivo .jar generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# REQUISITO DE SEGURIDAD: Usuario no root (Ajustado para Alpine)
RUN addgroup -S devopsgroup && adduser -S devopsuser -G devopsgroup
USER devopsuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
