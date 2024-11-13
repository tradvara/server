#!/bin/bash

# Actualizar el sistema e instalar OpenJDK 17 y wget
#echo "Actualizando el sistema e instalando OpenJDK 17..."
#sudo apt update -y
#sudo apt install -y openjdk-17-jre-headless wget curl

# Verificar la instalación de Java
echo "Verificando la instalación de Java..."
java -version

sudo rmdir server
mkdir -p server
sudo chmod u+w /server


# Descargar PaperMC (versión 1.21.1-131)
echo "Descargando PaperMC..."
wget https://papermc.io/api/v2/projects/paper/versions/1.21.1/builds/131/downloads/paper-1.21.1-131.jar -O paper-1.21.1-131.jar
sudo mv paper-1.21.1-131.jar server


# Crear el script para iniciar el servidor.
echo "Creando el script para iniciar el servidor de Minecraft..."
cat > r_start_server.sh <<EOL
#!/bin/bash
# Iniciar el servidor de Minecraft con 1GB de RAM mínima y 2GB de RAM máxima
java -Xms1G -Xmx2G -jar paper-1.21.1-131.jar nogui
EOL
sudo mv r_start_server.sh server

# Dar permisos de ejecución a los scripts.
cd server
chmod +x r_*

# Crea plugins
mkdir plugins
cd plugins
cd /home/tu_usuario/minecraft/plugins
wget https://github.com/AuthMe/AuthMeReloaded/releases/download/5.6.0/AuthMe-5.6.0-legacy.jar

# Mensaje final
echo "¡Todo listo! Ahora puedes ejecutar el servidor con './r_start_server.sh'."

# Finalizar el script
exit 0
