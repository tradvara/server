#!/bin/bash

# Ejecutar Ngrok y exponer el puerto 25565
echo "Iniciando Ngrok..."
./ngrok authtoken <tu_authtoken_aqui>
./ngrok tcp 25565
