#!/bin/sh

# Iniciar el servidor de Minecraft en segundo plano
java -Xmx1024M -Xms1024M -jar server.jar nogui &

# Espera unos segundos para que el servidor inicie correctamente
sleep 5

# Iniciar Ngrok y exponer el puerto 25565
ngrok tcp 25565

