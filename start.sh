#!/bin/bash

Actualizar el sistema e instalar OpenJDK 17 y wget
echo "Actualizando el sistema e instalando OpenJDK 17..."
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless wget curl

# Verificar la instalación de Java
echo "Verificando la instalación de Java..."
java -version

sudo rm -rf server
mkdir -p server
sudo chmod u+w server

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

# Ejecuta start_server
. r_start_server.sh

# Descarga el mod
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.21.1-52.0.28/forge-1.21.1-52.0.28-installer.jar
java -jar forge-1.21.1-52.0.28-installer.jar

# Descarga AuthMe
cd plugins
wget https://github.com/AuthMe/AuthMeReloaded/releases/download/5.6.0/AuthMe-5.6.0-legacy.jar

# Modifica archivos
cd ..
sed -i 's/eula=false/eula=true/' eula.txt
sed -i 's/online-mode=true/online-mode=false/' server.properties

# Descarga mods
mkdir mods
cd mods

# Lista de URLs para los mods
declare -A mods=(
    ["JEI"]="https://www.curseforge.com/minecraft/mc-mods/jei/download/5846880"
    ["BALM"]="https://www.curseforge.com/minecraft/mc-mods/balm/install/5848102"
)

# Descargar cada mod
for mod in "${!mods[@]}"; do
    url="${mods[$mod]}"
    echo "Descargando $mod desde $url"
    wget "$url" -O "$mod.jar"
done

echo "Descarga completa en la carpeta 'mods'."


# Mensaje final
echo "¡Todo listo! Ahora puedes ejecutar el servidor con './r_start_server.sh'."

# Finalizar el script
exit 0
