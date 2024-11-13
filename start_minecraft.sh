#!/bin/bash

# Autenticarse con Ngrok usando el authtoken de la variable de entorno
ngrok authtoken $NGROK_AUTHTOKEN

# Iniciar el servidor de Minecraft con el archivo correcto
java -Xmx1024M -Xms1024M -jar /paper-1.21.1-131.jar nogui

