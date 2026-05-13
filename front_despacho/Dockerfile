# ETAPA 1: Construcción (Build)
# Usamos Node.js para transformar tu código JSX en archivos que el navegador entienda.
FROM node:18-alpine AS build-stage
WORKDIR /app

# Copiamos los archivos de dependencias primero para aprovechar la caché de Docker.
COPY package*.json ./
RUN npm install

# Copiamos el resto de tus archivos (src, public, tailwind.config.js, etc.)[cite: 13].
COPY . .

# Generamos la carpeta 'dist' con los archivos finales.
RUN npm run build

# ETAPA 2: Servidor de Producción (Nginx)
# Usamos Nginx para entregar tu Frontend de forma profesional y ligera.
FROM nginx:stable-alpine

# IMPORTANTE: Copiamos los archivos generados en la etapa anterior.
# En React con Vite, la carpeta de salida suele ser 'dist'.
COPY --from=build-stage /app/dist /usr/share/nginx/html

# REQUISITO DE EVALUACIÓN: Seguridad (Usuario no root)[cite: 13, 91].
# Configuramos permisos para que Nginx no necesite ser administrador.
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d
USER nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]