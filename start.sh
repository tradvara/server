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
java -Xms2G -Xmx2G -jar paper-1.21.1-131.jar nogui
EOL
sudo mv r_start_server.sh server

# Crear el script para iniciar el servidor.
echo "Creando el script para serveo..."
cat > r_serveo.sh <<EOL
#!/bin/bash
ssh -R 25565:localhost:25565 serveo.net
EOL
sudo mv r_serveo.sh server

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
    ["WAYSTONE"]="https://www.curseforge.com/minecraft/mc-mods/waystones/install/5841763"
    ["AUTOPLANTER"]="https://cdn.modrinth.com/data/DXtdbdDH/versions/ecD08Lf1/AutoPlanter-Forge-1.21.1-21.1.1.jar"
    ["OPLENTY"]="https://cdn.modrinth.com/data/HXF82T3G/versions/rM5ofJWs/BiomesOPlenty-forge-1.21.1-21.1.0.7.jar"
    ["COLLECTIVE"]="https://cdn.modrinth.com/data/e0M1UDsY/versions/nwmUrrgY/collective-1.21.1-7.87.jar"
    ["FALLING"]="https://cdn.modrinth.com/data/Fb4jn8m6/versions/c04fsPim/FallingTree-1.21.1-1.21.1.2.jar"
    ["GLITCH"]="https://cdn.modrinth.com/data/s3dmwKy5/versions/PCy0sobG/GlitchCore-forge-1.21.1-2.1.0.0.jar"
    ["HEALTH"]="https://www.curseforge.com/minecraft/mc-mods/health-indicator-txf/install/5846530"
    ["JOURNEY"]="https://www.curseforge.com/minecraft/mc-mods/journeymap/install/5789363"
    ["ORE"]="https://cdn.modrinth.com/data/Xiv4r347/versions/ugXfLS9y/oreharvester-1.21.1-1.4.jar"
    ["STRUCTURES"]="https://cdn.modrinth.com/data/j3FONRYr/versions/IGlyM8iH/Structory_Towers_1.21.x_v1.0.9.jar"
    ["TERRA"]="https://cdn.modrinth.com/data/kkmrDlKT/versions/4OYhD4bm/TerraBlender-forge-1.21.1-4.1.0.5.jar"
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
