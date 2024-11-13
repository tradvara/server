#!/bin/bash

# Actualizar el sistema e instalar OpenJDK 17 y wget
echo "Actualizando el sistema e instalando OpenJDK 17..."
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless wget curl

# Verificar la instalación de Java
echo "Verificando la instalación de Java..."
java -version

# Descargar e instalar ngrok
echo "Descargando e instalando ngrok..."
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok.zip
unzip ngrok.zip
sudo mv ngrok /usr/local/bin/ngrok
rm ngrok.zip

# Verificar la instalación de ngrok
echo "Verificando la instalación de ngrok..."
ngrok version

# Descargar PaperMC (versión 1.21.1-131)
echo "Descargando PaperMC..."
wget https://papermc.io/api/v2/projects/paper/versions/1.21.1/builds/131/downloads/paper-1.21.1-131.jar -O paper-1.21.1-131.jar

# Crear el script para iniciar el servidor
echo "Creando el script para iniciar el servidor de Minecraft..."
cat > start_server.sh <<EOL
#!/bin/bash
# Iniciar el servidor de Minecraft con 1GB de RAM mínima y 2GB de RAM máxima
java -Xms1G -Xmx2G -jar paper-1.21.1-131.jar nogui
EOL

# Crear el script para iniciar el servidor
echo "Creando el script para iniciar el servidor de Minecraft..."
cat > ngrok.sh <<EOL
#!/bin/bash
# Iniciar el servidor de Minecraft con 1GB de RAM mínima y 2GB de RAM máxima
ngrok authtoken 2om1MM3EqD8R48t9OS4WyfbwQ1Z_VNTxSnT76VSZB8ExKMUw
ngrok tcp 25565
EOL


# Dar permisos de ejecución al script
chmod +x start_server.sh
chmod +x ngrok.sh

# Instrucciones para ejecutar ngrok
echo "Para exponer el servidor a través de ngrok, ejecuta el siguiente comando en otra terminal:"
echo "ngrok tcp 25565"

# Mensaje final
echo "¡Todo listo! Ahora puedes ejecutar el servidor con './start-server.sh'."

# Finalizar el script
exit 0