# Usar una imagen base de OpenJDK
FROM openjdk:17-jdk-slim

# Actualizar e instalar dependencias necesarias
RUN apt-get update && apt-get install -y wget unzip curl

# Descargar Paper para el servidor de Minecraft
RUN wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/131/downloads/paper-1.21.1-131.jar

# Copiar el script para iniciar el servidor de Minecraft
COPY start_minecraft.sh /start_minecraft.sh

# Copiar el script para iniciar ngrok
COPY start_ngrok.sh /start_ngrok.sh

# Hacer los scripts ejecutables
RUN chmod +x /start_minecraft.sh /start_ngrok.sh

# Exponer el puerto de Minecraft
EXPOSE 25565

# Comando para iniciar el servidor
CMD ["bash", "-c", "/start_ngrok.sh & /start_minecraft.sh"]
