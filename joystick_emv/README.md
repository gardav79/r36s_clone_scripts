Debe colocarse junto con es_input.cfg en la carpeta tools de easyroms

Instrucciones
Este script está pensado para solucionar el problema del joystick invertido
en emulationstation consolas r36s en principio "clónicas" aunque funcionaría en "originales"
también sin problema. 

El script tiene dos funciones:
-. Si no encuentra archivo es_input.cfg, obtiene el es_input.cfg de la consola
   para su posterior corrección

-. Si encuentra archivo es_input.cfg, realiza una copia de seguridad del archivo
   es_input.cfg de la consola, y copia el es_input.cfg que ha encontrado en su lugar

Instalación 
Para hacer funcionar el script, hay que copiarlo a la carpeta tools de la partición EASYROMS
de la tarjeta SD. Si se tiene archivo es_input.cfg ya modificado, se deja en la misma 
carpeta tools junto con el script.

Funciones posibles:

A) Si no se dispone de archivo es_input.cfg con la configuración ya corregida, se copia únicamente 
el script a la carpeta tools. Al ejecutarlo, el script detectará que no hay archivo de configuración (es_input.cfg)
y realizará dos backups del archivo de configuración interno de los joysticks de emulationstation. 
Una copia la dejará en la misma ruta del archivo de configuración (/etc/emulationstation del partición root)
y otra copia la dejará en la carpeta tools de la partición EASYROMS junto al script.

![joystick_ems](https://github.com/user-attachments/assets/c0eb6c08-fe29-473a-82a4-05b1ff7af8f2)


Esto permite tener, por un lado, un backup del archivo de configuración en la SD a parte de tener otro en la 
ruta original, y poder modificarlo para cambiarlo posteriormente. El archivo corregido debe llamarse es_input.cfg
para su posterior sustitución por el incorrecto.

B) Si se dispone de archivo es_input.cfg o se ha corregido el archivo de backup con el paso A (recordar renombrarlo 
como es_input.cfg), se copia junto al script en la carpeta tools de la partición EASYROMS. El script realizará un 
backup (si no existe backup previamente, si existe omite realizar el backup) y seguidamente sustituye el 
archivo es_input.cfg de la consola, que se encuentra en la partición root de la SD, en la carpeta 
/etc/emulationstation por el suministrado junto al script. 

C) Si por el contrario, hemos perdido el archivo de backup que había en la SD, para poder restaurar la copia
interna de que se realizó en cualquiera de los pasos A o B, solo hay que dejar junto al script en la carpeta tools
un archivo de texto vacío junto al script y llamarlo restore. Importante: sin dejar archivo es_input.cfg o no restaurá 
la copia interna. 

Al ejecutar el script, este encontrará el archivo restore y procederá a copiar el backup interno que se grabó 
en /etc/emulationstation de la partición root a la misma ruta, con el nombre es_input.cfg dejando de este modo 
restaurada la copia de seguridad (no la borra)
