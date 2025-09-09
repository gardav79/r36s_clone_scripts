#!/bin/bash
#
# diagnostico.sh - Script de diagnóstico para ArkOS v1.1
#
# Copyright (c) 2024 gardav79
#
# Permiso concedido bajo la licencia MIT:
# https://opensource.org/licenses/MIT
#
# Requisitos de atribución:
# - Debe mantenerse este aviso de copyright
# - Debe incluirse un enlace a la licencia MIT
# - Debe mencionarse al autor original
# 
# REGISTRO DE CAMBIOS
#
# Cambiado para que funcione desde el directorio tools
# Muestra de información en pantalla, con espera para lectura
# Modificada la función para que se asegure que escribe el log en tools
#
# Agradecimientos
# A @Xcorpion82 por la sugerencia de cambio a tools



TARGET_DIR=""

# Escribir en la pantalla
write_to_fb() {
    local message="$1"

    # Si no se pasa mensaje, leer de stdin
    if [ -z "$message" ]; then
        while IFS= read -r line; do
            echo "$line" > /dev/tty0 2>/dev/null || \
            echo "$line" > /dev/console 2>/dev/null || \
            echo "$line"
        done
    else
        # Usar el mensaje como parámetro
        echo "$message" > /dev/tty0 2>/dev/null || \
        echo "$message" > /dev/console 2>/dev/null || \
        echo "$message"
    fi
}

# Buscar directorio tools
find_tools() {
    local log_file="$1"
    local tools_dirs=("/roms/tools" "/storage/roms/tools")
    #local target_dir=""
    
    write_to_fb "Buscando directorio tools..."
    
    # Buscar directorio tools existente
    for dir in "${tools_dirs[@]}"; do
        if [ -d "$dir" ]; then
            TARGET_DIR="$dir"
            write_to_fb ""
            write_to_fb " Directorio tools encontrado: $TARGET_DIR"
            break
        fi
    done
    
    # Verificar que tenemos un directorio target
    if [ -z "$TARGET_DIR" ]; then
        write_to_fb ""
        write_to_fb "❌ No se pudo encontrar o crear directorio tools"
        return 1
    fi
    
}

# Copiar el log a la carpeta tools si no está allí
copy_log_to_tools(){    
    # Verificar que el archivo log existe
    if [ ! -f "$TARGET_DIR/$LOG_FILE" ]; then
        echo "Archivo log no encontrado: $LOG_FILE"
        return 1
    fi
    
    # Copiar el archivo
    local target_file="$TARGET_DIR/$(basename "$LOG_FILE")"
    
    if cp "$LOG_FILE" "$TARGET_FILE" 2>/dev/null; then
        echo "Log copiado a: $TARGET_FILE"
        echo "Tamaño: $(du -h "$TARGET_FILE" | cut -f1)"
        return 0
    else
        echo "Error al copiar el log a $TARGET_DIR"
        return 1
    fi
}

# Buscamos carpeta tools
find_tools

NOMBRE_ARCHIVO="diagnostico.log"
LOG_FILE="$TARGET_DIR/$NOMBRE_ARCHIVO"

# Función para registrar mensajes en el log
log_message() {
    echo "$1" >> "$LOG_FILE"
}

# Función para listar directorios dentro de roms que busque archivos de estado y salvado
list_parent_subdirs_with_saves() {
    {
        echo "Subdirectorios en los directorios de roms:"
        echo "========================================"
        
        local total_srm=0
        local total_state=0
        local total_dirs=0
        
        for dir in $PORTS_DIR/../*/; do
            if [ -d "$dir" ]; then
                ((total_dirs++))
                base_dir=$(basename "$dir")
                echo "» $base_dir/"
                
                # Listar subdirectorios y buscar archivos de guardado
                local has_subdirs=false
                local subdir_count=0
                
                for subdir in "$dir"*/; do
                    if [ -d "$subdir" ] && [ "$subdir" != "$dir" ]; then
                        if [ "$has_subdirs" = false ]; then
                            has_subdirs=true
                        fi
                        
                        subdir_name=$(basename "$subdir")
                        echo "  ├── $subdir_name/"
                        
                        # Buscar archivos .srm y .state en este subdirectorio
                        local srm_files=()
                        local state_files=()
                        
                        # Buscar archivos .srm
                        while IFS= read -r -d '' file; do
                            srm_files+=("$(basename "$file")")
                        done < <(find "$subdir" -maxdepth 1 -name "*.srm" -print0 2>/dev/null)
                        
                        # Buscar archivos .state
                        while IFS= read -r -d '' file; do
                            state_files+=("$(basename "$file")")
                        done < <(find "$subdir" -maxdepth 1 -name "*.state" -print0 2>/dev/null)
                        
                        # Mostrar archivos encontrados
                        if [ ${#srm_files[@]} -gt 0 ] || [ ${#state_files[@]} -gt 0 ]; then
                            # Archivos .srm
                            if [ ${#srm_files[@]} -gt 0 ]; then
                                echo "  │   ├──  .srm: ${srm_files[*]}"
                                ((total_srm += ${#srm_files[@]}))
                            fi
                            
                            # Archivos .state
                            if [ ${#state_files[@]} -gt 0 ]; then
                                echo "  │   ├──  .state: ${state_files[*]}"
                                ((total_state += ${#state_files[@]}))
                            fi
                        else
                            echo "  │   └──  Sin archivos de estado y guardado"
                        fi
                        
                        ((subdir_count++))
                    fi
                done
                
                # Si no hay subdirectorios en este directorio principal
                if [ "$has_subdirs" = false ]; then
                    echo "  └──  Sin subdirectorios"
                    
                    # Buscar archivos .srm y .state en el directorio principal también
                    local main_srm_files=()
                    local main_state_files=()
                    
                    while IFS= read -r -d '' file; do
                        main_srm_files+=("$(basename "$file")")
                    done < <(find "$dir" -maxdepth 1 -name "*.srm" -print0 2>/dev/null)
                    
                    while IFS= read -r -d '' file; do
                        main_state_files+=("$(basename "$file")")
                    done < <(find "$dir" -maxdepth 1 -name "*.state" -print0 2>/dev/null)
                    
                    if [ ${#main_srm_files[@]} -gt 0 ] || [ ${#main_state_files[@]} -gt 0 ]; then
                        if [ ${#main_srm_files[@]} -gt 0 ]; then
                            echo "     ├──  .srm: ${main_srm_files[*]}"
                            ((total_srm += ${#main_srm_files[@]}))
                        fi
                        
                        if [ ${#main_state_files[@]} -gt 0 ]; then
                            echo "     ├──  .state: ${main_state_files[*]}"
                            ((total_state += ${#main_state_files[@]}))
                        fi
                    else
                        echo "     └──  Sin archivos de estado y guardado"
                    fi
                fi
                
                echo ""
            fi
        done
        
        # Mostrar resumen general
        echo "========================================"
        echo " RESUMEN:"
        echo "   Directorios analizados: $total_dirs"
        echo "   Archivos .srm encontrados: $total_srm"
        echo "   Archivos .state encontrados: $total_state"
        
        if [ $total_srm -eq 0 ] && [ $total_state -eq 0 ]; then
            echo "    No se encontraron archivos de guardado"
        else
            echo "    Se encontraron archivos de guardado"
        fi
        echo "========================================"
    }
}

# Función para obtener información del panel
get_panel_info() {
    echo "=== INFORMACIÓN DEL PANEL Y DRIVERS ==="
    echo ""
    
    # 1. Información del framebuffer
    echo " FRAMEBUFFER:"
    if [ -f "/proc/fb" ]; then
        echo "Dispositivos fb:"
        cat /proc/fb
        echo ""
        
        # Información de cada framebuffer
        for fb in /dev/fb*; do
            if [ -c "$fb" ]; then
                echo "--- $fb ---"
                if command -v fbset >/dev/null 2>&1; then
                    fbset -fb "$fb" -s 2>/dev/null | head -10
                fi
            fi
        done
    else
        echo " /proc/fb no disponible"
    fi
    echo ""
    
    # 2. Información DRM
    echo " DRM (Direct Rendering Manager):"
    if [ -d "/sys/class/drm" ]; then
        echo "Tarjetas DRM disponibles:"
        ls /sys/class/drm/card*
        echo ""
        
        # Información de conectores
        echo "Conectores y estados:"
        for connector in /sys/class/drm/*/status; do
            if [ -f "$connector" ]; then
                conn_name=$(dirname "$connector" | xargs basename)
                status=$(cat "$connector")
                echo "  $conn_name: $status"
                
                # Mostrar modos disponibles si está conectado
                if [ "$status" = "connected" ]; then
                    modes_file="$(dirname "$connector")/modes"
                    if [ -f "$modes_file" ]; then
                        echo "    Modos: $(head -1 "$modes_file")"
                    fi
                fi
            fi
        done
    else
        echo " DRM no disponible"
    fi
    echo ""
    
    # 3. Módulos del kernel
    echo " MÓDULOS DE VIDEO:"
    echo "Módulos cargados:"
    lsmod | grep -E "drm|fb|panel|display|gpu|vga" | head -10
    echo ""
    
    # 4. Dispositivos PCI/USB de video
    echo "️  DISPOSITIVOS:"
    if command -v lspci >/dev/null 2>&1; then
        lspci | grep -i "vga\|display\|3d\|2d" 2>/dev/null || echo "  No se encontraron dispositivos VGA"
    fi
    echo ""
    
    # 5. Información de EDID
    echo " EDID:"
    edid_files=$(find /sys/devices/ -name edid 2>/dev/null)
    if [ -n "$edid_files" ]; then
        for edid_file in $edid_files; do
            echo "  Archivo EDID: $edid_file"
            if [ -s "$edid_file" ]; then
                echo "    Tamaño: $(wc -c < "$edid_file") bytes"
            else
                echo "    Vacío o no disponible"
            fi
        done
    else
        echo "  ❌ No se encontraron archivos EDID"
    fi
    echo ""
    
    # 6. Configuración específica de ArkOS
    echo " CONFIGURACIÓN ArkOS:"
    if [ -d "/opt/system" ]; then
        echo "Scripts de video en /opt/system/:"
        find /opt/system/ -name "*.sh" -exec grep -l "display\|panel\|fb\|drm" {} \; 2>/dev/null
    fi
    echo ""
    
    # 7. Variables de entorno relevantes
    echo " VARIABLES DE ENTORNO:"
    env | grep -E "DISPLAY|FRAMEBUFFER|DRM|VIDEO" | head -10
    echo ""
}

# Función específica para displays en dispositivos embebidos
get_embedded_display_info() {
    echo "=== INFORMACIÓN PARA DISPLAYS EMBEBIDOS ==="
    echo ""
    
    # 1. Buscar dispositivos de panel específicos
    echo " Dispositivos de panel en /sys/class/backlight/:"
    ls /sys/class/backlight/ 2>/dev/null || echo "  No hay control de backlight"
    echo ""
    
    # 2. Información de backlight
    if [ -d "/sys/class/backlight" ]; then
        for bl in /sys/class/backlight/*; do
            if [ -d "$bl" ]; then
                echo " Backlight: $(basename "$bl")"
                echo "   Brightness: $(cat "$bl/brightness" 2>/dev/null || echo "N/A")/$(cat "$bl/max_brightness" 2>/dev/null || echo "N/A")"
            fi
        done
    fi
    echo ""
    
    # 3. Buscar en device tree
    echo " Device Tree:"
    find /proc/device-tree/ -name "*panel*" -o -name "*display*" -o -name "*lcd*" 2>/dev/null | head -5
    echo ""
    
    # 4. Información de resoluciones
    echo " RESOLUCIONES:"
    if command -v fbset >/dev/null 2>&1; then
        fbset 2>/dev/null | grep -E "geometry|mode"
    fi
    echo ""
    
    # 5. Logs del kernel relacionados con display
    echo " LOGS DEL KERNEL:"
    dmesg | grep -i "drm\|panel\|display\|fb\|lcd" | tail -5
    echo ""
}


# Función para listar los dispositivos de audio y sus salidas
get_audio_info() {
    echo "INFORMACIÓN DE SALIDAS DE AUDIO"
    echo "=========================================="
    
    # 1. Información ALSA
    echo "--- ALSA Sound System ---"
    if command -v aplay >/dev/null 2>&1; then
        echo "Tarjetas de sonido:"
        aplay -l 2>/dev/null | grep -E '^card' || echo "  No se detectaron tarjetas"
        echo ""
        
        echo "Dispositivos disponibles:"
        aplay -L 2>/dev/null | grep -E '^(hw|plughw|default)' | head -10
    else
        echo "aplay no disponible"
    fi
    echo ""
    
    # 2. Información PulseAudio
    echo "--- PulseAudio ---"
    if command -v pactl >/dev/null 2>&1; then
        echo "Salidas de audio (sinks):"
        pactl list short sinks 2>/dev/null | while read -r line; do
            echo "  $line"
        done || echo "  No hay sinks disponibles"
        
        echo ""
        echo "Perfiles activos:"
        pactl list short cards 2>/dev/null | while read -r line; do
            card_num=$(echo "$line" | awk '{print $1}')
            profile=$(echo "$line" | awk '{print $3}')
            echo "  Card $card_num: $profile"
        done
    else
        echo "PulseAudio no disponible"
    fi
    echo ""
    
    # 3. Información del sistema
    echo "--- Información del Sistema ---"
    echo "Tarjetas en /proc/asound/cards:"
    if [ -f /proc/asound/cards ]; then
        cat /proc/asound/cards
    else
        echo "  No disponible"
    fi
    echo ""
    
    # 4. Dispositivos USB de audio
    echo "--- Dispositivos USB de Audio ---"
    if command -v lsusb >/dev/null 2>&1; then
        lsusb | grep -i audio | head -5 || echo "  No se encontraron dispositivos USB de audio"
    else
        echo "lsusb no disponible"
    fi
    echo ""
    
    # 5. Control de volumen actual
    echo "--- Estado de Volumen ---"
    if command -v amixer >/dev/null 2>&1; then
        echo "Controles simples:"
        amixer scontrols 2>/dev/null | head -5
        echo ""
        
        echo "Volumen maestro:"
        amixer get Master 2>/dev/null | grep -E '\[on\]|\[off\]' | head -2 || echo "  No disponible"
    else
        echo "amixer no disponible"
    fi
    echo ""
    
    echo "=========================================="
}

# Función para ejecutar comandos y registrar resultados
run_command() {
    local section="$1"
    local command="$2"
    
    log_message ""
    log_message "=== SECCIÓN: $section ==="
    log_message "Comando ejecutado: $command"
    log_message "Resultado:"
    eval "sudo $command" >> "$LOG_FILE" 2>&1
    log_message "=== FIN SECCIÓN: $section ==="
    log_message ""
}

# Función para llamar funciones
run_command_functions() {
    local section="$1"
    local command="$2"

    log_message ""
    log_message "=== SECCIÓN: $section ==="
    log_message "Función ejecutada: $command"
    log_message "Resultado:"
    eval "$command" >> "$LOG_FILE" 2>&1
    log_message "=== FIN SECCIÓN: $section ==="
    log_message ""
}


# Función para verificar permisos de escritura
check_write_permissions() {
    local current_dir=$(pwd)
    local error_msg=""
    
    # Verificar si el directorio existe
    if [ ! -d "$current_dir" ]; then
        error_msg="El directorio no existe: $current_dir"
    # Verificar permisos de escritura
    elif [ ! -w "$current_dir" ]; then
        error_msg="Sin permisos de escritura en el directorio: $current_dir"
    # Verificar espacio en disco
    else
        local available_space=$(df "$current_dir" | awk 'NR==2 {print $4}')
        if [ "$available_space" -lt 1024 ]; then
            error_msg="Espacio insuficiente en disco (menos de 1MB libre)"
        fi
    fi
    
    # Si hay error, mostrar mensaje y salir
    if [ -n "$error_msg" ]; then
        echo "Error: $error_msg"
        echo "El script se cerrará en 5 segundos..."
        sleep 5
        exit 1
    fi
    
    echo "Permisos de escritura verificados correctamente"
}

# Función principal
main() {
    
    # Verificar permisos de escritura
    echo "Verificando permisos de escritura en: $(pwd)"
    check_write_permissions
    
    # Añadir fecha y hora al archivo de log
    echo "Iniciando diagnóstico del sistema..."
    echo "================================================================" > "$LOG_FILE"
    log_message "DIAGNÓSTICO DEL SISTEMA - $(date)"
    log_message "================================================================"
    
    # Obtener información del sistema
    run_command "Sistema operativo" "cat /etc/os-release"
    run_command "Versión del CFW" "cat /usr/share/plymouth/themes/text.plymouth | grep ArkOS | cut -c 7-50 || echo 'Información del CFW no disponible'"
    run_command "Kernel y arquitectura" "uname -a"
    
    # Información de hardware
    run_command "Procesador (CPU)" "cat /proc/cpuinfo"
    run_command "Info extendida CPU" "lscpu || echo 'lscpu no disponible'"
    run_command "Memoria RAM" "free -h"
    run_command "Información de memoria detallada" "cat /proc/meminfo"
    run_command "Información de memoria iomem" "cat /proc/iomem" 

    # Joystick
    run_command "Nombre del joystick" "cat /sys/class/input/event0/device/name || echo 'nombre del joystick no disponible'"
    run_command "Configuración del joystick en emulationstation" "cat /etc/emulationstation/es_input.cfg || echo 'configuración no disponible'"
    run_command "Configuración del joystick en PortMaster" "cat $PORTS_DIR/../tools/PortMaster/gamecontrollerdb.txt | grep -i $(cat /sys/class/input/event0/device/name) || echo 'Información del joystick en Portmaster no disponible'"

    # Dispositivos de audio
    run_command_functions "Tarjeta de sonido" "get_audio_info"

    # Almacenamiento
    run_command "Particiones con fdisk" "fdisk -l"
    run_command "Particiones y espacio en disco" "df -h"
    run_command "Particiones montadas" "mount | grep -E '^/dev/'"
    run_command "Dispositivos de bloque" "lsblk"

    # Estado partición ROMS
    run_command "Permisos de la partición" "ls -la $PORTS_DIR/../"
    run_command_functions "Permisos de salvados retroarch" "list_parent_subdirs_with_saves"

    # Configuración gamedb portmaster  
  
    # Información de la consola/terminal
    run_command "Entorno de consola" "echo \"Terminal: \$TERM\"; echo \"Usuario: \$(whoami)\"; echo \"Shell: \$SHELL\""
    
    # Información de red
    run_command "Configuración de red" "ip addr show"
    run_command "Tabla de ruteo" "ip route"
    run_command "DNS y resolución de nombres" "cat /etc/resolv.conf"
    run_command "Puertos abiertos" "ss -tuln | head -20"
    
    # Información de GPU
    run_command "Resolución del panel" "cat /sys/class/graphics/fb0/modes"
    run_command "Nombre" "cat /sys/class/graphics/fb0/name"
    run_command "Bits por pixel" "cat /sys/class/graphics/fb0/bits_per_pixel"
    
    # Información completa del panel
    run_command_functions "Información del Panel" "get_panel_info"

    # Información específica para embebidos
    run_command_functions  "Display Embebido" "get_embedded_display_info"

    # Información dispositivos DRM
    run_command "DRM Devices" \
    'ls -la /sys/class/drm/ 2>/dev/null; \
     echo ""; \
     echo "Conectores:"; \
     for conn in /sys/class/drm/*/status; do \
         [ -f "$conn" ] && echo "$(dirname "$conn" | xargs basename): $(cat "$conn")"; \
     done'

     run_command "Kernel Video Modules" 'lsmod | grep -E "drm|fb|panel|display|gpu" | head -15'

    # Información de batería (si aplica)
    run_command "Carga de la batería (en %)" "cat /sys/class/power_supply/battery/capacity || echo 'Información de batería no disponible'"
    run_command "Vida útil de la batería" "cat /sys/class/power_supply/battery/health || echo 'estado de la batería no disponible'"
    run_command "Estado de la batería" "cat /sys/class/power_supply/battery/status || echo 'estado no disponible'"
    run_command "Voltaje actual de la batería" "cat /sys/class/power_supply/battery/voltage_now || echo 'Voltaje actual no disponible'"

    # Información del cargador (si aplica)
    run_command "Corriente máxima de carga (en mAh)" "cat /sys/class/power_supply/ac/current_max || echo 'Corriente no disponible'"
    run_command "Cargador detectado (1=si, 0=no)" "cat /sys/class/power_supply/ac/online || echo 'Detección cargador no disponible'"
    run_command "Estado del cargador (Charging/Discharging)" "cat /sys/class/power_supply/ac/status || echo 'Estado no disponible'"
    run_command "Voltaje máximo de carga" "cat /sys/class/power_supply/ac/voltage_max || echo 'Voltaje máximo no disponible'"

    # Información de temperatura (si aplica)
    run_command "Dispositivo (SOC)" "cat /sys/class/thermal/thermal_zone0/type || echo 'Dispositivo no disponible'"
    run_command "Temperatura (SOC)" "cat /sys/class/thermal/thermal_zone0/temp || echo 'Temperatura del SOC no disponible'"
    run_command "Dispositivo (GPU)" "cat /sys/class/thermal/thermal_zone1/type || echo 'Dispositivo no disponible'"
    run_command "Temperatura (GPU)" "cat /sys/class/thermal/thermal_zone1/temp || echo 'Temperatura de la GPU no disponible'"

    # Información de procesos
    run_command "Procesos en Ejecución" "ps aux --sort=-%cpu"
    run_command "Uso de Memoria por Procesos" "ps aux --sort=-%mem"
    
    # Información del sistema
    run_command "Uptime del Sistema" "uptime"
    run_command "Fecha y Hora del Sistema" "date; echo 'Reloj hardware:'; hwclock 2>/dev/null || echo 'No se puede acceder al reloj hardware'"
    run_command "Usuarios Loggeados" "who"
    run_command "Historial de Logins" "last | head -10"
    
    # Información de hardware adicional
    run_command "Dispositivos USB" "lsusb 2>/dev/null || echo 'Comando lsusb no disponible'"
    
    # Variables de entorno relevantes
    run_command "Variables de Entorno" "printenv | grep -E '(PATH|HOME|USER|LANG|SHELL|TERM)'"
    
    # Finalizar log
    log_message "================================================================"
    log_message "DIAGNÓSTICO COMPLETADO - $(date)"
    log_message "================================================================"
    
    echo "Diagnóstico completado. La información se ha guardado en: $LOG_FILE"
    echo "Tamaño del archivo: $(du -h "$LOG_FILE" | cut -f1)"
}

# Forzar modo consola básico
export TERM=dumb

# Limpiar pantalla
clear > /dev/tty0 2>/dev/null || clear

# Primer mensaje tras encontrar tools
write_to_fb "========================================"
write_to_fb "   DIAGNÓSTICO EN EJECUCIÓN"
write_to_fb "   Guardando log en: $LOG_FILE"
write_to_fb "   Por favor espere..."
write_to_fb "========================================"

# Ejecutar diagnóstico
{
main
} > "$LOG_FILE"

# Mensaje final
write_to_fb ""
write_to_fb " DIAGNÓSTICO COMPLETADO"
write_to_fb " Log guardado en: $LOG_FILE"
write_to_fb ""

write_to_fb ""
write_to_fb "Primeras líneas del log:"
write_to_fb ""
tail -n 15 $LOG_FILE | write_to_fb

# Esperamos para que de tiempo a leero
sleep 10 

# Confirmamos que el log está en tools
copy_log_to_tools

# Esperar entrada
read -n 1 -s > /dev/tty0 2>/dev/null || read -n 1 -s

# Agurcito
exit 0
