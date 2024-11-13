# Usa una imagen base de Java
FROM openjdk:17-jdk-alpine

# Crea y define el directorio de trabajo
WORKDIR /minecraft

# Descarga el archivo paper.jar
RUN wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/131/downloads/paper-1.21.1-131.jar

# Descarga e instala Ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin && \
    rm ngrok-stable-linux-amd64.zip

# Copia el archivo de inicio
COPY start.sh .

# Da permisos de ejecución al script
RUN chmod +x start.sh /usr/local/bin/ngrok

# Exponer el puerto de Minecraft
EXPOSE 25565

# Comando de inicio
CMD ["./start.sh"]

