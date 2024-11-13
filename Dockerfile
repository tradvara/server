# Usa una imagen base con OpenJDK 17
FROM openjdk:17-jdk-slim

# Instalar Ngrok
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://bin.equinox.io/c/4VmDzA7iaJ7/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/

# Establecer la variable de entorno para el authtoken de Ngrok
ENV NGROK_AUTHTOKEN=tu_authtoken_aqui

# Copiar el archivo de inicio al contenedor
COPY start_minecraft.sh /start_minecraft.sh

# Dar permisos de ejecución
RUN chmod +x /start_minecraft.sh

# Copiar el archivo .jar del servidor de Minecraft
COPY paper-1.21.1-131.jar /paper-1.21.1-131.jar

# Configurar el script para usar el authtoken de Ngrok y luego iniciar el servidor
CMD /start_minecraft.sh
