#!/bin/bash
#
# joystick_ems.sh - Script de modificación del archivo es_input.cfg para ArkOS v1.1
#
# Copyright (c) 2024 gardav79
# https://github.com/gardav79/r36s_clone_scripts
#
# Permiso concedido bajo la licencia MIT:
# https://opensource.org/licenses/MIT
#
# Requisitos de atribución:
# - Debe mantenerse este aviso de copyright
# - Debe incluirse un enlace a la licencia MIT
# - Debe mencionarse al autor original
# 
# Se concede permiso por la presente, de forma gratuita, a cualquier persona que obtenga una copia
# de este software y de los archivos de documentación asociados (el "Software"), para utilizar
# el Software sin restricción, incluyendo sin limitación los derechos de uso, copia, modificación,
# fusión, publicación, distribución, sublicencia y/o venta de copias del Software, y para permitir
# a las personas a las que se les proporcione el Software a hacer lo mismo, sujeto a las siguientes condiciones:
# 
# El aviso de copyright anterior y este aviso de permiso se incluirán en todas las copias
# o partes sustanciales del Software.
# 
# EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA,
# INCLUYENDO PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN, IDONEIDAD PARA UN PROPÓSITO PARTICULAR
# Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGÚN
# RECLAMO, DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO O CUALQUIER OTRO MOTIVO,
# QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U OTRO TIPO DE ACCIONES EN EL SOFTWARE.
# 
# ADVERTENCIA: Este script se ofrece sin garantía de ningún tipo y se proporciona "COMO ESTÁ".
# El autor declina expresamente toda responsabilidad por cualquier daño, pérdida o problema que pueda
# surgir del uso de este software. El usuario utiliza este script bajo su propio riesgo y responsabilidad.



# Debe colocarse junto con es_input.cfg en la carpeta tools de easyroms

# Instrucciones
# Este script está pensado para solucionar el problema del joystick invertido
# en emulationstation consolas r36s en principio "clónicas" aunque funcionaría en "originales"
# también sin problema. 
#
# El script tiene dos funciones:
# -. Si no encuentra archivo es_input.cfg, obtiene el es_input.cfg de la consola
#    para su posterior corrección
#
# -. Si encuentra archivo es_input.cfg, realiza una copia de seguridad del archivo
#    es_input.cfg de la consola, y copia el es_input.cfg que ha encontrado en su lugar
#
# Instalación 
# Para hacer funcionar el script, hay que copiarlo a la carpeta tools de la partición EASYROMS
# de la tarjeta SD. Si se tiene archivo es_input.cfg ya modificado, se deja en la misma 
# carpeta tools junto con el script.
# 
# Funciones posibles:
#
# A) Si no se dispone de archivo es_input.cfg con la configuración ya corregida, se copia únicamente 
# el script a la carpeta tools. Al ejecutarlo, el script detectará que no hay archivo de configuración (es_input.cfg)
# y realizará dos backups del archivo de configuración interno de los joysticks de emulationstation. 
# Una copia la dejará en la misma ruta del archivo de configuración (/etc/emulationstation del partición root)
# y otra copia la dejará en la carpeta tools de la partición EASYROMS junto al script.
#
# Esto permite tener, por un lado, un backup del archivo de configuración en la SD a parte de tener otro en la 
# ruta original, y poder modificarlo para cambiarlo posteriormente. El archivo corregido debe llamarse es_input.cfg
# para su posterior sustitución por el incorrecto.

# B) Si se dispone de archivo es_input.cfg o se ha corregido el archivo de backup con el paso A (recordar renombrarlo 
# como es_input.cfg), se copia junto al script en la carpeta tools de la partición EASYROMS. El script realizará un 
# backup (si no existe backup previamente, si existe omite realizar el backup) y seguidamente sustituye el 
# archivo es_input.cfg de la consola, que se encuentra en la partición root de la SD, en la carpeta 
# /etc/emulationstation por el suministrado junto al script. 
#
# C) Si por el contrario, hemos perdido el archivo de backup que había en la SD, para poder restaurar la copia
# interna de que se realizó en cualquiera de los pasos A o B, solo hay que dejar junto al script en la carpeta tools
# un archivo de texto vacío junto al script y llamarlo restore. Importante: sin dejar archivo es_input.cfg o no restaurá 
# la copia interna. 
#
# Al ejecutar el script, este encontrará el archivo restore y procederá a copiar el backup interno que se grabó 
# en /etc/emulationstation de la partición root a la misma ruta, con el nombre es_input.cfg dejando de este modo 
# restaurada la copia de seguridad (no la borra)
#

# Buscar directorio tools
find_tools() {
    local log_file="$1"
    local tools_dirs=("/roms/tools" "/storage/roms/tools")
    #local target_dir=""
    
    write_to_fb "Buscando directorio tools..."
    
    # Buscar directorio tools existente
    for dir in "${tools_dirs[@]}"; do
        if [ -d "$dir" ]; then
            SOURCE_DIR="$dir"
            write_to_fb ""
            write_to_fb " Directorio tools encontrado: $SOURCE_DIR"
            break
        fi
    done
    
    # Verificar que tenemos un directorio target
    if [ -z "$SOURCE_DIR" ]; then
        write_to_fb ""
        write_to_fb "❌ No se pudo encontrar o crear directorio tools"
        return 1
    fi
    
}


find_tools

LOG_FILE="$SOURCE_DIR/joystick_ems.log"


log_message() {
    echo "$1" >> "$LOG_FILE"
}

export TERM=dumb

# Escribir directamente al framebuffer si es posible
#write_to_fb() {
#    local message="$1"
#
 #   # Intentar escribir en diferentes dispositivos de consola
#    echo "$message" > /dev/tty0 2>/dev/null || \
#    echo "$message" > /dev/console 2>/dev/null || \
#    echo "$message" > /dev/fb0 2>/dev/null || \
#    echo "$message"
#    echo "$message" >> "$LOG_FILE"
#}
write_to_fb() {
    local message="$1"
    local console_device=""
    
    # Detectar dispositivo de consola actual
    if [ -c "/dev/tty0" ]; then
        console_device="/dev/tty0"
    elif [ -c "/dev/console" ]; then
        console_device="/dev/console"
    elif [ -c "/dev/fb0" ]; then
        console_device="/dev/fb0"
    fi
    
    # Escribir en la consola detectada
    if [ -n "$console_device" ]; then
        echo "$message" | sudo tee "$console_device" >/dev/null 2>&1 || \
        echo "$message" > "$console_device" 2>/dev/null || \
        echo "$message"
    else
        echo "$message"
    fi
    
    echo "$message" >> "$LOG_FILE"
}

# Definir rutas
BACKUP_DIR="/etc/emulationstation"
TARGET_FILE="$BACKUP_DIR/es_input.cfg"
BACKUP_FILE="$BACKUP_DIR/es_input.cfg.backup"
SOURCE_FILE="$SOURCE_DIR/es_input.cfg"
BACKUP_SD_FILE="$SOURCE_DIR/es_input.cfg.backup"
RESTORE_FILE="$SOURCE_DIR/restore"

# Función para mostrar mensajes de error
error_msg() {
    write_to_fb "ERROR: $1"
    #log_message "ERROR: $1"
}

# Función para mostrar mensajes de éxito
success_msg() {
    write_to_fb "$1"
    #log_message "$1"
}

# Función para mostrar mensajes informativos
info_msg() {
    write_to_fb "️$1"
    #log_message "$1"
}

main() {
    # Mostrar directorio actual
    info_msg "Directorio tools: $SOURCE_DIR"

    # Verificar que el archivo fuente existe
    info_msg "Buscando $SOURCE_FILE..."
    if [ ! -f "$SOURCE_FILE" ]; then
        #error_msg "El archivo $SOURCE_FILE no existe."
        #error_msg "Coloca es_input.cfg en $SOURCE_DIR"
        error_msg "El archivo es_input.cfg no existe en la carpeta tools"
	error_msg "Coloca es_input.cfg en la carpeta tools"
	info_msg ""
        info_msg "Procedo a obtener el archivo $TARGET_FILE"
        sleep 10
        #exit 1
    fi

    
    success_msg "Archivo fuente encontrado"

    # Verificar si ya existe un backup
    if [ -f "$BACKUP_FILE" ]; then
        info_msg "Backup ya existe, se omite creación"
    else
        # Crear backup del archivo original si existe
        if [ -f "$TARGET_FILE" ]; then
            info_msg "Creando backup del original..."
            if sudo cp "$TARGET_FILE" "$BACKUP_FILE"; then
                success_msg "Backup creado"
            else
                error_msg "No se pudo crear el backup."
                sleep 10
                exit 1
            fi
        else
            info_msg "No existe archivo original"
        fi
    fi

    # Copiar el archivo de backup a tools (si existe)
    if [ -f "$BACKUP_FILE" ]; then
        info_msg "Copiando backup a tools..."
        if sudo cp "$BACKUP_FILE" "$BACKUP_SD_FILE"; then
            success_msg "Backup copiado a SD"
        else
            error_msg "Error al copiar backup a SD"
            # No salir, continuar con el proceso principal
        fi
    fi
    
    # Si existe archivo restore UNICAMENTE restaura backup    
    if [ -f "$RESTORE_FILE" ] && [ ! -f "$SOURCE_FILE" ]; then
	info_msg "Se va a proceder a la restauración del backup interno"
	if sudo cp "$BACKUP_FILE" "$TARGET_FILE"; then
		success_msg "Backup interno restaurado."
		success_msg "Recuerda reiniciar emulationstation"
		sleep 10
		exit 1
	else 
		error_msg "No se pudo restaurar el backup interno"
		sleep 10
		exit 1
	fi	
    fi	

    # Copiar el nuevo archivo de configuración
    if [ -f "$SOURCE_FILE" ]; then 
    	info_msg "Copiando nueva configuración..."
    	if sudo cp "$SOURCE_FILE" "$TARGET_FILE"; then
        	success_msg "Configuración copiada exitosamente"
        
        	# Verificar permisos
        	sudo chmod 644 "$TARGET_FILE"
        	sudo chown root:root "$TARGET_FILE"
        	success_msg "Permisos configurados"
        
    	else
        	error_msg "Error al copiar la configuración"
        	sleep 10
		exit 1
    	fi
    fi

    success_msg "Proceso completado!"
}

# Limpiar pantalla
clear > /dev/tty0 2>/dev/null || clear

write_to_fb "========================================"
write_to_fb "  CONFIGURACIÓN DE JOYSTICK EMULATIONSTATION"
write_to_fb "  Por favor espere..."
write_to_fb "========================================"

# Ejecutar main y guardar log
main 2>&1 | tee "$LOG_FILE"

# Feedback final
write_to_fb ""
write_to_fb "CONFIGURACIÓN COMPLETADA"
write_to_fb ""
sleep 15


# Esperar entrada
#read -n 1 -s -t 30 > $(tty) 2>/dev/null || read -n 1 -s -t 30

exit 0
