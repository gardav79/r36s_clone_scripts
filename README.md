# r36s_clone_scripts
Repositorio con scripts para diagnósico de problemas comunes y solución (de momento solo diagnóstico)

El primer script, diagnóstico.sh, permite obtener información relevante para poder determinar problemas de la consola R36s "clónica" (de momento está sin probar en "originales") para poder determinar diferentes problemas que se suelen dar con estas consolas. Problemas como que el joystick esté cambiado, no tenga sonido, retroarch no permita guardar partidas... Es mucho más sencillo determinar la causa si se tiene información del sistema. 

El script debe guardarse en la carpeta ports, donde se ponen los juegos de PortMaster y lanzarlo desde emulationstation como un port más de PortMaster. Está configurado para que guarde un archivo llamado diagnostico.log en esta ruta (en mi caso, /ports de la partición EASYROMS). Ese archivo diagnostico.log es el que contendrá toda la información relevante sobre la consola para poder determinar que el causante del problema. 

Esto es un ejemplo del archivo diagnostico.log:

================================================================
DIAGNÓSTICO DEL SISTEMA - jue jul 17 21:10:35 CEST 2025
============Diagnóstico completado. La información se ha guardado en: /roms/ports/diagnostico.log
Tamaño del archivo: 96K
/etc/os-release
Resultado:
NAME="Ubuntu"
VERSION="19.10 (Eoan Ermine)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 19.10"
VERSION_ID="19.10"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=eoan
UBUNTU_CODENAME=eoan
=== FIN SECCIÓN: Sistema operativo ===


=== SECCIÓN: Versión del CFW ===
Comando ejecutado: cat /usr/share/plymouth/themes/text.plymouth | grep ArkOS | cut -c 7-50 || echo 'Información del CFW no disponible'
Resultado:
ArkOS - K36 (08112025)
=== FIN SECCIÓN: Versión del CFW ===


=== SECCIÓN: Kernel y arquitectura ===
Comando ejecutado: uname -a
Resultado:
Linux rg351mp 5.10.160-gc18be26ca0ba-dirty #1 SMP Thu Jun 5 17:15:31 CST 2025 aarch64 aarch64 aarch64 GNU/Linux
=== FIN SECCIÓN: Kernel y arquitectura ===


=== SECCIÓN: Procesador (CPU) ===
Comando ejecutado: cat /proc/cpuinfo
Resultado:
processor	: 0
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd04
CPU revision	: 2

processor	: 1
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd04
CPU revision	: 2

processor	: 2
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd04
CPU revision	: 2

processor	: 3
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd04
CPU revision	: 2

Serial		: 13c44ed02bffaed3
=== FIN SECCIÓN: Procesador (CPU) ===


=== SECCIÓN: Info extendida CPU ===
Comando ejecutado: lscpu || echo 'lscpu no disponible'
Resultado:
Architecture:                    aarch64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              1
Core(s) per socket:              4
Socket(s):                       1
Vendor ID:                       ARM
Model:                           2
Model name:                      Cortex-A35
Stepping:                        r0p2
CPU max MHz:                     1512,0000
CPU min MHz:                     408,0000
BogoMIPS:                        48.00
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Mmio stale data:   Not affected
Vulnerability Retbleed:          Not affected
Vulnerability Spec store bypass: Not affected
Vulnerability Spectre v1:        Mitigation; __user pointer sanitization
Vulnerability Spectre v2:        Not affected
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected
Flags:                           fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
=== FIN SECCIÓN: Info extendida CPU ===


=== SECCIÓN: Memoria RAM ===
Comando ejecutado: free -h
Resultado:
              total        used        free      shared  buff/cache   available
Mem:          468Mi       122Mi        90Mi       1,0Mi       255Mi       322Mi
Swap:         511Mi       106Mi       405Mi
=== FIN SECCIÓN: Memoria RAM ===


=== SECCIÓN: Información de memoria detallada ===
Comando ejecutado: cat /proc/meminfo
Resultado:
MemTotal:         479668 kB
MemFree:           92404 kB
MemAvailable:     329940 kB
Buffers:           88424 kB
Cached:            95580 kB
SwapCached:          712 kB
Active:           219460 kB
Inactive:          24824 kB
Active(anon):      42768 kB
Inactive(anon):    18836 kB
Active(file):     176692 kB
Inactive(file):     5988 kB
Unevictable:        1200 kB
Mlocked:               0 kB
SwapTotal:        524284 kB
SwapFree:         415228 kB
Dirty:                 4 kB
Writeback:             0 kB
AnonPages:         60828 kB
Mapped:            24960 kB
Shmem:              1324 kB
KReclaimable:      77772 kB
Slab:             102892 kB
SReclaimable:      77772 kB
SUnreclaim:        25120 kB
KernelStack:        2448 kB
PageTables:         2512 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      764116 kB
Committed_AS:     312504 kB
VmallocTotal:   263061440 kB
VmallocUsed:        7644 kB
VmallocChunk:          0 kB
Percpu:              672 kB
CmaTotal:         131072 kB
CmaAllocated:       1280 kB
CmaReleased:      129792 kB
CmaFree:           77664 kB
=== FIN SECCIÓN: Información de memoria detallada ===


=== SECCIÓN: Información de memoria iomem ===
Comando ejecutado: cat /proc/iomem
Resultado:
00110000-0012ffff : ramoops:dmesg
00130000-001affff : ramoops:console
001b0000-001fffff : ramoops:pmsg
00200000-083fffff : System RAM
  00400000-0174ffff : Kernel code
  01750000-01e8ffff : reserved
  01e90000-021fffff : Kernel data
  08300000-0831bfff : reserved
08c00000-1fffffff : System RAM
  0a200000-0ae95fff : reserved
  15c00000-1dbfffff : reserved
  1df00000-1e1effff : reserved
  1f540000-1fdfffff : reserved
  1fe07000-1fe07fff : reserved
  1fe08000-1fe7ffff : reserved
  1fe82000-1fe82fff : reserved
  1fe83000-1fe84fff : reserved
  1fe85000-1fe95fff : reserved
  1fe96000-1fffffff : reserved
ff040000-ff0400ff : ff040000.gpio0 gpio0@ff040000
ff070000-ff070fff : ff070000.i2s i2s@ff070000
ff0b0400-ff0b047f : ff0b0400.rng rng@ff0b0000
ff158000-ff15801f : serial
ff180000-ff180fff : ff180000.i2c i2c@ff180000
ff190000-ff190fff : ff190000.i2c i2c@ff190000
ff240000-ff243fff : dmac@ff240000
  ff240000-ff243fff : ff240000.dmac dmac@ff240000
ff250000-ff2500ff : ff250000.gpio1 gpio1@ff250000
ff260000-ff2600ff : ff260000.gpio2 gpio2@ff260000
ff270000-ff2700ff : ff270000.gpio3 gpio3@ff270000
ff280000-ff2800ff : ff280000.tsadc tsadc@ff280000
ff288000-ff2880ff : ff288000.saradc saradc@ff288000
ff290000-ff293fff : ff290000.nvmem nvmem@ff290000
ff2e0000-ff2effff : ff2e0000.phy phy
ff300000-ff33ffff : ff300000.usb usb@ff300000
ff370000-ff373fff : ff370000.dwmmc dwmmc@ff370000
ff380000-ff383fff : ff380000.dwmmc dwmmc@ff380000
ff390000-ff393fff : ff390000.dwmmc dwmmc@ff390000
ff400000-ff403fff : ff400000.gpu
ff440440-ff44047f : ff440440.iommu iommu@ff440440
ff440480-ff4404bf : ff440440.iommu iommu@ff440440
ff442800-ff4428ff : ff442800.iommu iommu@ff442800
ff450000-ff45ffff : ff450000.dsi dsi@ff450000
ff460000-ff4601fb : ff460000.vop regs
ff460a00-ff460dff : ff460000.vop gamma_lut
ff460f00-ff460fff : ff460f00.iommu iommu@ff460f00
ff480000-ff480fff : ff480000.rk_rga rk_rga@ff480000
ff4a8000-ff4a80ff : ff4a8000.iommu iommu@ff4a8000
ff610000-ff6103ff : ff610000.dfi dfi@ff610000
=== FIN SECCIÓN: Información de memoria iomem ===


=== SECCIÓN: Nombre del joystick ===
Comando ejecutado: cat /sys/class/input/event0/device/name || echo 'nombre del joystick no disponible'
Resultado:
play_joystick
=== FIN SECCIÓN: Nombre del joystick ===


=== SECCIÓN: Configuración del joystick en emulationstation ===
Comando ejecutado: cat /etc/emulationstation/es_input.cfg || echo 'configuración no disponible'
Resultado:
<?xml version="1.0"?>
<inputList>
        <inputConfig type="joystick" deviceName="play_joystick" deviceGUID="19000f6a706c61795f6a6f7973746900">
                <input name="a" type="button" id="0" value="1" />
                <input name="b" type="button" id="1" value="1" />
                <input name="down" type="button" id="15" value="1" />
                <input name="hotkeyenable" type="button" id="8" value="1" />
                <input name="left" type="button" id="16" value="1" />
                <input name="leftanalogdown" type="axis" id="1" value="1" />
                <input name="leftanalogleft" type="axis" id="0" value="-1" />
                <input name="leftanalogright" type="axis" id="0" value="1" />
                <input name="leftanalogup" type="axis" id="1" value="-1" />
                <input name="leftshoulder" type="button" id="4" value="1" />
                <input name="leftthumb" type="button" id="11" value="1" />
                <input name="lefttrigger" type="button" id="6" value="1" />
                <input name="right" type="button" id="17" value="1" />
                <input name="rightanalogdown" type="axis" id="3" value="-1" />
                <input name="rightanalogleft" type="axis" id="2" value="1" />
                <input name="rightanalogright" type="axis" id="2" value="-1" />
                <input name="rightanalogup" type="axis" id="3" value="1" />
                <input name="rightshoulder" type="button" id="5" value="1" />
                <input name="rightthumb" type="button" id="12" value="1" />
                <input name="righttrigger" type="button" id="7" value="1" />
                <input name="select" type="button" id="8" value="1" />
                <input name="start" type="button" id="9" value="1" />
                <input name="up" type="button" id="14" value="1" />
                <input name="pageup" type="button" id="4" value="1" />
                <input name="pagedown" type="button" id="5" value="1" />
                <input name="x" type="button" id="2" value="1" />
                <input name="y" type="button" id="3" value="1" />
        </inputConfig>
</inputList>
=== FIN SECCIÓN: Configuración del joystick en emulationstation ===


=== SECCIÓN: Configuración del joystick en PortMaster ===
Comando ejecutado: cat /roms/ports/../tools/PortMaster/gamecontrollerdb.txt | grep -i play_joystick || echo 'Información del joystick en Portmaster no disponible'
Resultado:
19000f6a706c61795f6a6f7973746900,play_joystick,a:b0,b:b1,x:b2,y:b3,dpdown:b15,dpleft:b16,dpright:b17,dpup:b14,back:b8,start:b9,guide:b8,+lefty:+a1,-leftx:-a0,+leftx:+a0,-lefty:-a1,leftshoulder:b6,leftstick:b10,lefttrigger:b5,+righty:-a3,-rightx:+a2,+rightx:-a2,-righty:+a3,rightshoulder:b7,rightstick:b11,righttrigger:b4,platform:Linux,
=== FIN SECCIÓN: Configuración del joystick en PortMaster ===


=== SECCIÓN: Tarjeta de sonido ===
Función ejecutada: get_audio_info
Resultado:
INFORMACIÓN DE SALIDAS DE AUDIO
==========================================
--- ALSA Sound System ---
Tarjetas de sonido:
card 0: rockchiprk817 [rockchip-rk817], device 0: dailink-multicodecs rk817-hifi-0 [dailink-multicodecs rk817-hifi-0]

Dispositivos disponibles:
default:CARD=rockchiprk817
hw:CARD=rockchiprk817,DEV=0
plughw:CARD=rockchiprk817,DEV=0

--- PulseAudio ---
PulseAudio no disponible

--- Información del Sistema ---
Tarjetas en /proc/asound/cards:
 0 [rockchiprk817  ]: rockchip-rk817 - rockchip-rk817
                      rockchip-rk817

--- Dispositivos USB de Audio ---

--- Estado de Volumen ---
Controles simples:
Simple mixer control 'Headphone',0
Simple mixer control 'Speaker',0
Simple mixer control 'Playback',0
Simple mixer control 'Playback Path',0
Simple mixer control 'Capture MIC Path',0

Volumen maestro:

==========================================
=== FIN SECCIÓN: Tarjeta de sonido ===


=== SECCIÓN: Particiones con fdisk ===
Comando ejecutado: fdisk -l
Resultado:
Disk /dev/ram0: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/mmcblk0: 3,66 GiB, 3909091328 bytes, 7634944 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 53540000-0000-420D-8000-7F3E000024A9

Device           Start     End Sectors  Size Type
/dev/mmcblk0p1   16384   24575    8192    4M unknown
/dev/mmcblk0p2   24576   32767    8192    4M unknown
/dev/mmcblk0p3   32768 4227071 4194304    2G unknown
/dev/mmcblk0p4 4227072 5275647 1048576  512M unknown
/dev/mmcblk0p5 5275648 7634910 2359263  1,1G unknown


Disk /dev/mmcblk1: 116,59 GiB, 125174808576 bytes, 244482048 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: EEA9C847-A9BC-41C8-9E02-F9B13CD5346F

Device            Start       End   Sectors   Size Type
/dev/mmcblk1p1    32768   1056767   1024000   500M Microsoft basic data
/dev/mmcblk1p2  1056768  17833983  16777216     8G Linux filesystem
/dev/mmcblk1p3 17833984 244482013 226648030 108,1G Linux filesystem


Disk /dev/sda: 14,45 GiB, 15500574720 bytes, 30274560 sectors
Disk model: TransMemory     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x44794ace

Device     Boot Start      End  Sectors  Size Id Type
/dev/sda1  *     2048 30273535 30271488 14,4G  c W95 FAT32 (LBA)
=== FIN SECCIÓN: Particiones con fdisk ===


=== SECCIÓN: Particiones y espacio en disco ===
Comando ejecutado: df -h
Resultado:
Filesystem      Size  Used Avail Use% Mounted on
udev            159M     0  159M   0% /dev
tmpfs            47M  580K   46M   2% /run
/dev/mmcblk1p2  7,8G  7,3G  533M  94% /
tmpfs           233M     0  233M   0% /dev/shm
tmpfs           5,0M  4,0K  5,0M   1% /run/lock
tmpfs           233M     0  233M   0% /sys/fs/cgroup
/dev/mmcblk1p3  106G  100G  766M 100% /roms
/dev/mmcblk1p1  500M  264M  236M  53% /boot
tmpfs            47M     0   47M   0% /run/user/1002
/dev/sda1        15G   13G  1,6G  90% /mnt/usbdrive
=== FIN SECCIÓN: Particiones y espacio en disco ===


=== SECCIÓN: Particiones montadas ===
Comando ejecutado: mount | grep -E '^/dev/'
Resultado:
/dev/mmcblk1p2 on / type ext4 (rw,noatime)
/dev/mmcblk1p3 on /roms type ext4 (rw,noatime)
/dev/mmcblk1p3 on /opt/system/Tools type ext4 (rw,noatime)
/dev/mmcblk1p1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=936,iocharset=utf8,shortname=mixed,errors=remount-ro)
/dev/sda1 on /mnt/usbdrive type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=936,iocharset=utf8,shortname=mixed,errors=remount-ro)
/dev/mmcblk1p3 on /home/ark/.freedroid_rpg type ext4 (rw,noatime)
=== FIN SECCIÓN: Particiones montadas ===


=== SECCIÓN: Dispositivos de bloque ===
Comando ejecutado: lsblk
Resultado:
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda            8:0    1  14,4G  0 disk 
└─sda1         8:1    1  14,4G  0 part /mnt/usbdrive
mmcblk0      179:0    0   3,7G  0 disk 
├─mmcblk0p1  179:1    0     4M  0 part 
├─mmcblk0p2  179:2    0     4M  0 part 
├─mmcblk0p3  179:3    0     2G  0 part 
├─mmcblk0p4  179:4    0   512M  0 part [SWAP]
└─mmcblk0p5  179:5    0   1,1G  0 part 
mmcblk0boot0 179:32   0     4M  1 disk 
mmcblk0boot1 179:64   0     4M  1 disk 
mmcblk1      179:96   0 116,6G  0 disk 
├─mmcblk1p1  179:97   0   500M  0 part /boot
├─mmcblk1p2  179:98   0     8G  0 part /
└─mmcblk1p3  179:99   0 108,1G  0 part /roms
=== FIN SECCIÓN: Dispositivos de bloque ===


=== SECCIÓN: Permisos de la partición ===
Comando ejecutado: ls -la /roms/ports/../
Resultado:
total 1552
drwx------ 129 ark  ark    4096 ago 29  2025 .
drwxr-xr-x  22 root root   4096 ago 16  2025 ..
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 3do
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 advision
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 alg
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 amiga
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 amigacd32
drwxr-xr-x   5 ark  ark    4096 jul 17  2025 amstradcpc
drwxr-xr-x  18 ark  ark   73728 jul 17 20:17 arcade
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 arduboy
drwxr-xr-x   3 ark  ark    4096 jul 17 20:24 arkos
drwxr-xr-x   3 ark  ark    4096 ago 14  2025 astrocde
drwxr-xr-x   4 ark  ark   36864 ago 18  2025 atari2600
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 atari5200
drwxr-xr-x   4 ark  ark    4096 ago 18  2025 atari7800
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 atari800
drwxr-xr-x   4 ark  ark    4096 jul 17 20:34 atarijaguar
drwxr-xr-x   4 ark  ark   12288 ago 18  2025 atarilynx
drwxr-xr-x   3 ark  ark   20480 ago 18  2025 atarist
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 atarixegs
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 atomiswave
drwxr-xr-x   2 ark  ark    4096 jul 17  2025 backup
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 bgmusic
drwxr-xr-x  26 ark  ark   16384 ago 14  2025 bios
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 c128
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 c16
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 c64
drwx------   3 ark  ark    4096 feb 16  2023 .cache
drwxr-xr-x   3 ark  ark    4096 ago 18  2025 channelf
drwxr-xr-x   3 ark  ark   12288 ago 18  2025 coleco
drwx------   5 ark  ark    4096 feb 16  2023 .config
-rw-r--r--   1 root root 174304 feb 16  2023 configemuelec.txt
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 cps1
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 cps2
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 cps3
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 crvision
drwxr-xr-x   3 ark  ark    4096 ago 14  2025 daphne
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 doom
drwxr-xr-x  70 ark  ark   12288 jul 17 20:32 dos
drwxr-xr-x   3 ark  ark    4096 feb 16  2023 dosbox
drwxr-xr-x   3 ark  ark    4096 ago 15  2025 dreamcast
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 easyrpg
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 famicom
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 fba
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 fbs
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 gameandwatch
drwxr-xr-x   4 ark  ark   28672 ago 18  2025 gamegear
-rw-r--r--   1 ark  ark    1355 jul 17  2025 gamelist.xml
drwxr-xr-x   4 ark  ark   69632 ago 18  2025 gb
drwxr-xr-x   4 ark  ark  118784 jul 17 20:57 gba
drwxr-xr-x   4 ark  ark   69632 ago 18  2025 gbc
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 genesis
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 gx4000
drwxr-xr-x   4 ark  ark   12288 jul 17 20:44 intellivision
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 launchimages
drwx------   3 ark  ark    4096 feb 16  2023 .local
drwx------   2 ark  ark   16384 ago 14  2025 lost+found
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 love2d
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 lowresnx
drwxr-xr-x   3 ark  ark    4096 ago 14  2025 mame
drwxr-xr-x   3 ark  ark    4096 ago 14  2025 mame2003
drwxr-xr-x   4 ark  ark   24576 jul 17  2025 mastersystem
drwxr-xr-x   5 ark  ark  106496 ago 18  2025 megadrive
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 megaduck
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 movies
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 msumd
drwxr-xr-x   4 ark  ark   36864 jul 17 20:02 msx
drwxr-xr-x   3 ark  ark    4096 jul 17  2025 msx2
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 mv
drwxr-xr-x   9 ark  ark   12288 jul 17 20:28 n64
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 n64dd
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 naomi
drwxr-xr-x   8 ark  ark    4096 ago 14  2025 nds
drwxr-xr-x   7 ark  ark    4096 jul 17 20:31 neogeo
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 neogeocd
drwxr-xr-x   6 ark  ark  114688 jul 17 20:07 nes
drwxr-xr-x   3 ark  ark    4096 ago 18  2025 ngp
drwxr-xr-x   4 ark  ark    4096 jul 17 20:46 ngpc
drwxr-xr-x   3 ark  ark    4096 ago 18  2025 odyssey
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 odyssey2
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 onscripter
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 openbor
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pc
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pc98
drwxr-xr-x   4 ark  ark   20480 ago 18  2025 pcengine
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pcenginecd
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pcfx
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pico
drwxr-xr-x   8 ark  ark    4096 ago 18  2025 pico-8
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pokemonmini
drwxr-xr-x  70 ark  ark    4096 jul 17 21:10 ports
drwxr-xr-x   6 ark  ark    4096 ago 15  2025 psp
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 pspminis
drwxr-xr-x   7 ark  ark   16384 ago 28  2025 psx
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 satellaview
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 saturn
drwxrwxr-x  75 ark  ark    4096 jul 17 19:57 scummvm
drwxr-xr-x   5 ark  ark    4096 jul 17 20:10 sega32x
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 segacd
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 sfc
drwxr-xr-x   3 ark  ark    4096 ago 18  2025 sg-1000
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 sgb
drwxr-xr-x   4 ark  ark  118784 jul 17 20:31 snes
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 snes-hacks
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 snesmsu1
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 solarus
drwxrwxr-x   3 ark  ark   12288 ago 18  2025 spectravideo
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 sufami
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 supergrafx
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 supervision
drwxr-xr-x   4 ark  ark    4096 ago 15  2025 themes
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 thomson
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 ti99
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 tic80
drwxrwxrwx   4 ark  ark    4096 jul 17 20:04 tools
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 turbografx
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 turbografxcd
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 uzebox
drwxrwxr-x   3 ark  ark    4096 jul 17 21:08 vectrex
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 vic20
drwxrwxr-x   3 ark  ark    4096 ago 18  2025 videopac
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 virtualboy
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 vmu
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 wasm4
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 wolf
drwxrwxr-x   4 ark  ark    4096 ago 18  2025 wonderswan
drwxrwxr-x   3 ark  ark    4096 ago 18  2025 wonderswancolor
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 x1
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 x68000
drwxr-xr-x   2 ark  ark    4096 ago 14  2025 zx81
drwxr-xr-x   3 ark  ark    4096 jul 17  2025 zxspectrum
=== FIN SECCIÓN: Permisos de la partición ===


=== SECCIÓN: Permisos de salvados retroarch ===
Función ejecutada: list_parent_subdirs_with_saves
Resultado:
Subdirectorios en los directorios de roms:
========================================
» 3do/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» advision/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» alg/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» amiga/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» amigacd32/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» amstradcpc/
  ├── cap32/
  │   └──  Sin archivos de estado y guardado
  ├── crocods/
  │   ├──  .state: La Abadia Del Crimen.state
  ├── media/
  │   └──  Sin archivos de estado y guardado

» arcade/
  ├── advmame/
  │   └──  Sin archivos de estado y guardado
  ├── FB Alpha/
  │   └──  Sin archivos de estado y guardado
  ├── FB Alpha 2012/
  │   └──  Sin archivos de estado y guardado
  ├── FB Alpha 2012 CPS-1/
  │   └──  Sin archivos de estado y guardado
  ├── fbneo/
  │   └──  Sin archivos de estado y guardado
  ├── FinalBurn Neo/
  │   └──  Sin archivos de estado y guardado
  ├── MAME 2000/
  │   └──  Sin archivos de estado y guardado
  ├── MAME 2003 (0.78)/
  │   └──  Sin archivos de estado y guardado
  ├── MAME 2003-Plus/
  │   └──  Sin archivos de estado y guardado
  ├── mame2000/
  │   └──  Sin archivos de estado y guardado
  ├── mame2003/
  │   └──  Sin archivos de estado y guardado
  ├── mame2003-plus/
  │   └──  Sin archivos de estado y guardado
  ├── mame2010/
  │   └──  Sin archivos de estado y guardado
  ├── mame2015/
  │   └──  Sin archivos de estado y guardado
  ├── mame2016/
  │   └──  Sin archivos de estado y guardado
  ├── media/
  │   └──  Sin archivos de estado y guardado

» arduboy/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» arkos/
  ├── open-ath9k-htc-firmware/
  │   └──  Sin archivos de estado y guardado

» astrocde/
  ├── mame/
  │   └──  Sin archivos de estado y guardado

» atari2600/
  ├── media/
  │   └──  Sin archivos de estado y guardado
  ├── Stella 2014/
  │   └──  Sin archivos de estado y guardado

» atari5200/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» atari7800/
  ├── media/
  │   └──  Sin archivos de estado y guardado
  ├── ProSystem/
  │   └──  Sin archivos de estado y guardado

» atari800/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» atarijaguar/
  ├── media/
  │   └──  Sin archivos de estado y guardado
  ├── Virtual Jaguar/
  │   ├──  .srm: Power Drive Rally (World).srm Power Drive Rally (World).cdrom.srm

» atarilynx/
  ├── Handy/
  │   ├──  .state: Chip's Challenge (USA, Europe).state
  ├── media/
  │   └──  Sin archivos de estado y guardado

» atarist/
  ├── media/
  │   └──  Sin archivos de estado y guardado

» atarixegs/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

» atomiswave/
  └──  Sin subdirectorios
     └──  Sin archivos de estado y guardado

=== FIN SECCIÓN: Permisos de salvados retroarch ===


=== SECCIÓN: Entorno de consola ===
Comando ejecutado: echo "Terminal: $TERM"; echo "Usuario: $(whoami)"; echo "Shell: $SHELL"
Resultado:
Terminal: dumb
Usuario: ark
Shell: /bin/bash
=== FIN SECCIÓN: Entorno de consola ===


=== SECCIÓN: Configuración de red ===
Comando ejecutado: ip addr show
Resultado:
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
=== FIN SECCIÓN: Configuración de red ===


=== SECCIÓN: Tabla de ruteo ===
Comando ejecutado: ip route
Resultado:
=== FIN SECCIÓN: Tabla de ruteo ===


=== SECCIÓN: DNS y resolución de nombres ===
Comando ejecutado: cat /etc/resolv.conf
Resultado:
# This file is managed by man:systemd-resolved(8). Do not edit.
#
# This is a dynamic resolv.conf file for connecting local clients to the
# internal DNS stub resolver of systemd-resolved. This file lists all
# configured search domains.
#
# Run "resolvectl status" to see details about the uplink DNS servers
# currently in use.
#
# Third party programs must not access this file directly, but only through the
# symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a different way,
# replace this symlink by a static file or a different symlink.
#
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 127.0.0.53
options edns0
=== FIN SECCIÓN: DNS y resolución de nombres ===


=== SECCIÓN: Puertos abiertos ===
Comando ejecutado: ss -tuln | head -20
Resultado:
Netid   State    Recv-Q   Send-Q     Local Address:Port     Peer Address:Port   
udp     UNCONN   0        0             127.0.0.53:53            0.0.0.0:*      
tcp     LISTEN   0        0             127.0.0.53:53            0.0.0.0:*      
=== FIN SECCIÓN: Puertos abiertos ===


=== SECCIÓN: Resolución del panel ===
Comando ejecutado: cat /sys/class/graphics/fb0/modes
Resultado:
U:640x480p-0
=== FIN SECCIÓN: Resolución del panel ===


=== SECCIÓN: Nombre ===
Comando ejecutado: cat /sys/class/graphics/fb0/name
Resultado:
rockchipdrmfb
=== FIN SECCIÓN: Nombre ===


=== SECCIÓN: Bits por pixel ===
Comando ejecutado: cat /sys/class/graphics/fb0/bits_per_pixel
Resultado:
32
=== FIN SECCIÓN: Bits por pixel ===


=== SECCIÓN: Información del Panel ===
Función ejecutada: get_panel_info
Resultado:
=== INFORMACIÓN DEL PANEL Y DRIVERS ===

 FRAMEBUFFER:
Dispositivos fb:
0 rockchipdrmfb

--- /dev/fb0 ---

 DRM (Direct Rendering Manager):
Tarjetas DRM disponibles:
/sys/class/drm/card0:
card0-DSI-1
dev
device
power
subsystem
uevent

/sys/class/drm/card0-DSI-1:
device
dpms
edid
enabled
modes
power
status
subsystem
uevent

Conectores y estados:
  card0-DSI-1: connected
    Modos: 640x480

 MÓDULOS DE VIDEO:
Módulos cargados:

️  DISPOSITIVOS:

 EDID:
  Archivo EDID: /sys/devices/platform/display-subsystem/drm/card0/card0-DSI-1/edid
    Vacío o no disponible

 CONFIGURACIÓN ArkOS:
Scripts de video en /opt/system/:
/opt/system/Advanced/Backup ArkOS Settings.sh

 VARIABLES DE ENTORNO:

=== FIN SECCIÓN: Información del Panel ===


=== SECCIÓN: Display Embebido ===
Función ejecutada: get_embedded_display_info
Resultado:
=== INFORMACIÓN PARA DISPLAYS EMBEBIDOS ===

 Dispositivos de panel en /sys/class/backlight/:
backlight

 Backlight: backlight
   Brightness: 98/255

 Device Tree:
/proc/device-tree/pinctrl/lcdc
/proc/device-tree/pinctrl/lcdc/lcdc-m0-rgb-pins
/proc/device-tree/pinctrl/lcdc/lcdc-m1-sleep-pins
/proc/device-tree/pinctrl/lcdc/lcdc-m1-rgb-pins
/proc/device-tree/pinctrl/lcdc/lcdc-m0-sleep-pins

 RESOLUCIONES:

 LOGS DEL KERNEL:

=== FIN SECCIÓN: Display Embebido ===


=== SECCIÓN: DRM Devices ===
Comando ejecutado: ls -la /sys/class/drm/ 2>/dev/null; \
     echo ""; \
     echo "Conectores:"; \
     for conn in /sys/class/drm/*/status; do \
         [ -f "$conn" ] && echo "$(dirname "$conn" | xargs basename): $(cat "$conn")"; \
     done
Resultado:
total 0
drwxr-xr-x  2 root root    0 jul 17 21:10 .
drwxr-xr-x 67 root root    0 jul 17 21:10 ..
lrwxrwxrwx  1 root root    0 jul 17 21:10 card0 -> ../../devices/platform/display-subsystem/drm/card0
lrwxrwxrwx  1 root root    0 jul 17 21:10 card0-DSI-1 -> ../../devices/platform/display-subsystem/drm/card0/card0-DSI-1
lrwxrwxrwx  1 root root    0 jul 17 21:10 renderD128 -> ../../devices/platform/display-subsystem/drm/renderD128
-r--r--r--  1 root root 4096 jul 17 21:10 version

Conectores:
card0-DSI-1: connected
=== FIN SECCIÓN: DRM Devices ===


=== SECCIÓN: Kernel Video Modules ===
Comando ejecutado: lsmod | grep -E "drm|fb|panel|display|gpu" | head -15
Resultado:
=== FIN SECCIÓN: Kernel Video Modules ===


=== SECCIÓN: Carga de la batería (en %) ===
Comando ejecutado: cat /sys/class/power_supply/battery/capacity || echo 'Información de batería no disponible'
Resultado:
100
=== FIN SECCIÓN: Carga de la batería (en %) ===


=== SECCIÓN: Vida útil de la batería ===
Comando ejecutado: cat /sys/class/power_supply/battery/health || echo 'estado de la batería no disponible'
Resultado:
Good
=== FIN SECCIÓN: Vida útil de la batería ===


=== SECCIÓN: Estado de la batería ===
Comando ejecutado: cat /sys/class/power_supply/battery/status || echo 'estado no disponible'
Resultado:
Full
=== FIN SECCIÓN: Estado de la batería ===


=== SECCIÓN: Voltaje actual de la batería ===
Comando ejecutado: cat /sys/class/power_supply/battery/voltage_now || echo 'Voltaje actual no disponible'
Resultado:
4155000
=== FIN SECCIÓN: Voltaje actual de la batería ===


=== SECCIÓN: Corriente máxima de carga (en mAh) ===
Comando ejecutado: cat /sys/class/power_supply/current_max || echo 'Corriente no disponible'
Resultado:
cat: /sys/class/power_supply/current_max: No such file or directory
Corriente no disponible
=== FIN SECCIÓN: Corriente máxima de carga (en mAh) ===


=== SECCIÓN: Cargador detectado (1=si, 0=no) ===
Comando ejecutado: cat /sys/class/power_supply/ac/online || echo 'Detección cargador no disponible'
Resultado:
1
=== FIN SECCIÓN: Cargador detectado (1=si, 0=no) ===


=== SECCIÓN: Estado del cargador (Charging/Discharging) ===
Comando ejecutado: cat /sys/class/power_supply/ac/status || echo 'Estado no disponible'
Resultado:
Full
=== FIN SECCIÓN: Estado del cargador (Charging/Discharging) ===


=== SECCIÓN: Voltaje máximo de carga ===
Comando ejecutado: cat /sys/class/power_supply/ac/voltage_max || echo 'Voltaje máximo no disponible'
Resultado:
4200000
=== FIN SECCIÓN: Voltaje máximo de carga ===


=== SECCIÓN: Dispositivo (SOC) ===
Comando ejecutado: cat /sys/class/thermal/thermal_zone0/type || echo 'Dispositivo no disponible'
Resultado:
soc-thermal
=== FIN SECCIÓN: Dispositivo (SOC) ===


=== SECCIÓN: Temperatura (SOC) ===
Comando ejecutado: cat /sys/class/thermal/thermal_zone0/temp || echo 'Temperatura del SOC no disponible'
Resultado:
54166
=== FIN SECCIÓN: Temperatura (SOC) ===


=== SECCIÓN: Dispositivo (GPU) ===
Comando ejecutado: cat /sys/class/thermal/thermal_zone1/type || echo 'Dispositivo no disponible'
Resultado:
gpu-thermal
=== FIN SECCIÓN: Dispositivo (GPU) ===


=== SECCIÓN: Temperatura (GPU) ===
Comando ejecutado: cat /sys/class/thermal/thermal_zone1/temp || echo 'Temperatura de la GPU no disponible'
Resultado:
52500
=== FIN SECCIÓN: Temperatura (GPU) ===


=== SECCIÓN: Procesos en Ejecución ===
Comando ejecutado: ps aux --sort=-%cpu
Resultado:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ark       1146 15.7  0.7   7112  3440 ?        S<   21:10   0:03 /bin/bash /roms/ports/diagnostico.sh
ark        695 14.5 14.9 1041336 71608 ?       Sl   19:54  11:01 /usr/bin/emulationstation/emulationstation
root         1  1.8  1.2 166148  6072 ?        Ss   19:54   1:22 /sbin/init splash
message+   368  1.5  0.6   7236  3116 ?        Ss   19:54   1:11 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root      2340  1.1  0.0      0     0 ?        I    20:57   0:08 [kworker/1:3-events]
root      1100  1.0  0.0      0     0 ?        I    21:10   0:00 [kworker/1:0-events]
root     28482  1.0  0.0      0     0 ?        I    21:09   0:00 [kworker/3:0-events]
root     28810  1.0  0.0      0     0 ?        I    20:56   0:09 [kworker/2:1-events]
root     16807  0.7  0.0      0     0 ?        I    21:04   0:03 [kworker/2:0-events]
root     10651  0.6  0.0      0     0 ?        I    20:42   0:11 [kworker/3:2-events]
root     15506  0.6  0.0      0     0 ?        I    21:04   0:02 [kworker/1:1-events]
root     19326  0.6  0.0      0     0 ?        I    20:45   0:10 [kworker/0:0-events_freezable]
root     26636  0.5  0.0      0     0 ?        I    20:32   0:11 [kworker/0:4-events]
root      2790  0.4  0.0      0     0 ?        I    20:57   0:03 [kworker/3:3-events]
root     23054  0.4  0.0      0     0 ?        I    21:05   0:01 [kworker/0:2-events]
root       367  0.3  0.8  15664  3968 ?        Ss   19:54   0:18 /lib/systemd/systemd-logind
root       447  0.3  0.5   6468  2576 ?        S    19:54   0:14 /bin/bash /usr/local/bin/checknswitchforusbdac.sh
root     23715  0.3  0.0      0     0 ?        I    20:49   0:04 [kworker/1:2-cgroup_destroy]
root     28849  0.3  0.0      0     0 ?        I    20:56   0:03 [kworker/0:1-cgroup_destroy]
root        11  0.2  0.0      0     0 ?        I    19:54   0:13 [rcu_sched]
root     28912  0.2  0.0      0     0 ?        I    21:09   0:00 [kworker/u8:1-events_power_efficient]
root        10  0.1  0.0      0     0 ?        S    19:54   0:05 [ksoftirqd/0]
root        83  0.1  0.0      0     0 ?        S    19:54   0:05 [cfinteractive]
root       108  0.1  0.0      0     0 ?        S    19:54   0:07 [kswapd0]
systemd+   358  0.1  0.8  20500  4124 ?        Ss   19:54   0:05 /lib/systemd/systemd-resolved
root       428  0.1  0.3   6748  1908 ?        S    19:54   0:05 /bin/bash /usr/bin/mpv_sense
root     18317  0.1  0.0      0     0 ?        I    21:04   0:00 [kworker/u8:0-events_unbound]
root     18530  0.1  0.0      0     0 ?        I    20:18   0:04 [kworker/u8:2-events_unbound]
root     24243  0.1  0.0      0     0 ?        I    20:51   0:01 [kworker/u8:3-events_unbound]
root     30325  0.1  0.0      0     0 ?        I<   20:57   0:00 [kworker/u9:0-kbase_pm_poweroff_wait]
root     30545  0.1  0.0      0     0 ?        I    20:57   0:01 [kworker/2:3-events]
root         2  0.0  0.0      0     0 ?        S    19:54   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   19:54   0:00 [rcu_gp]
root         4  0.0  0.0      0     0 ?        I<   19:54   0:00 [rcu_par_gp]
root         8  0.0  0.0      0     0 ?        I<   19:54   0:00 [mm_percpu_wq]
root         9  0.0  0.0      0     0 ?        S    19:54   0:00 [rcu_tasks_rude_]
root        12  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/0]
root        13  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/0]
root        14  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/1]
root        15  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/1]
root        16  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/1]
root        19  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/2]
root        20  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/2]
root        21  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/2]
root        24  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/3]
root        25  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/3]
root        26  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/3]
root        29  0.0  0.0      0     0 ?        S    19:54   0:00 [kdevtmpfs]
root        30  0.0  0.0      0     0 ?        I<   19:54   0:00 [netns]
root        35  0.0  0.0      0     0 ?        S    19:54   0:00 [oom_reaper]
root        36  0.0  0.0      0     0 ?        I<   19:54   0:00 [writeback]
root        77  0.0  0.0      0     0 ?        I<   19:54   0:00 [kblockd]
root        78  0.0  0.0      0     0 ?        S    19:54   0:02 [kconsole]
root        79  0.0  0.0      0     0 ?        I<   19:54   0:00 [tpm_dev_wq]
root        80  0.0  0.0      0     0 ?        I<   19:54   0:00 [edac-poller]
root        81  0.0  0.0      0     0 ?        I<   19:54   0:00 [devfreq_wq]
root        82  0.0  0.0      0     0 ?        S    19:54   0:00 [watchdogd]
root        86  0.0  0.0      0     0 ?        I<   19:54   0:00 [cfg80211]
root        87  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/25-rockchip]
root       109  0.0  0.0      0     0 ?        I<   19:54   0:00 [xfsalloc]
root       110  0.0  0.0      0     0 ?        I<   19:54   0:00 [xfs_mru_cache]
root       112  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/52-rockchip]
root       113  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/53-rockchip]
root       114  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/54-rockchip]
root       115  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/55-rockchip]
root       116  0.0  0.0      0     0 ?        S    19:54   0:00 [queue_work0]
root       117  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/38-ff440000]
root       118  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/35-ff442400]
root       119  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/37-ff442000]
root       120  0.0  0.0      0     0 ?        S    19:54   0:00 [hwrng]
root       123  0.0  0.0      0     0 ?        SN   19:54   0:00 [dmabuf-deferred]
root       124  0.0  0.0      0     0 ?        I<   19:54   0:00 [uas]
root       125  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/56-rk817]
root       126  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-bat-monit]
root       127  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-dc-wq]
root       129  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-usb-wq]
root       134  0.0  0.0      0     0 ?        I<   19:54   0:00 [cryptodev_queue]
root       135  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/82-headset_]
root       136  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/83-ff370000]
root       137  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/84-ff380000]
root       139  0.0  0.0      0     0 ?        I<   19:54   0:00 [ipv6_addrconf]
root       141  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/42-rga]
root       142  0.0  0.0      0     0 ?        I<   19:54   0:00 [mmc_complete]
root       143  0.0  0.0      0     0 ?        S    19:54   0:00 [card0-crtc0]
root       145  0.0  0.0      0     0 ?        I<   19:54   0:00 [gpu_power_off_w]
root       146  0.0  0.0      0     0 ?        I<   19:54   0:00 [free_pages_work]
root       148  0.0  0.0      0     0 ?        S    19:54   0:00 [mali-simple-pow]
root       150  0.0  0.0      0     0 ?        I<   19:54   0:00 [kbase_job_fault]
root       169  0.0  0.0      0     0 ?        I<   19:54   0:00 [mmc_complete]
root       193  0.0  0.0      0     0 ?        I<   19:54   0:03 [kworker/2:2H-kblockd]
root       196  0.0  0.0      0     0 ?        I<   19:54   0:03 [kworker/1:2H-kblockd]
root       213  0.0  0.0      0     0 ?        S    19:54   0:00 [jbd2/mmcblk1p2-]
root       214  0.0  0.0      0     0 ?        I<   19:54   0:00 [ext4-rsv-conver]
root       264  0.0  0.4  17596  2016 ?        Ss   19:54   0:00 /lib/systemd/systemd-udevd
root       344  0.0  0.0      0     0 ?        S    19:54   0:00 [jbd2/mmcblk1p3-]
root       345  0.0  0.0      0     0 ?        I<   19:54   0:00 [ext4-rsv-conver]
systemd+   356  0.0  0.8  89448  4072 ?        Ssl  19:54   0:03 /lib/systemd/systemd-timesyncd
root       363  0.0  1.2  28080  5820 ?        Ss   19:54   0:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
root       364  0.0  1.3  15044  6504 ?        Ss   19:54   0:01 python3 /usr/local/bin/batt_life_warning.py
root       369  0.0  0.5 258908  2644 ?        Ssl  19:54   0:00 /usr/sbin/NetworkManager --no-daemon
root       370  0.0  0.4   6568  2172 ?        Ss   19:54   0:00 /usr/sbin/cron -f
root       373  0.0  0.4   9968  1944 ?        Ss   19:54   0:00 /sbin/wpa_supplicant -u -c/etc/wpa_supplicant/wpa_supplicant.conf -O/run/wpa_supplicant
root       375  0.0  0.5   6748  2740 ?        Ss   19:54   0:00 /bin/bash /usr/bin/mpv_sense
root       427  0.0  0.2   6748  1220 ?        S    19:54   0:00 /bin/bash /usr/bin/mpv_sense
root       429  0.0  0.2   1960  1136 ?        S    19:54   0:00 evtest /dev/input/event0
root       430  0.0  0.0   1960   328 ?        S    19:54   0:00 evtest /dev/input/event1
root       432  0.0  0.0   1960   380 ?        S    19:54   0:00 evtest /dev/input/event2
root       433  0.0  0.0   1960   448 ?        S    19:54   0:00 evtest /dev/input/event4
root       434  0.0  0.0   1960   388 ?        S    19:54   0:00 evtest /dev/input/event5
root       636  0.0  0.4   9532  2204 ttyFIQ0  Ss   19:54   0:00 /bin/login -p --
ark        669  0.0  0.5   6468  2404 ?        Ss   19:54   0:00 /bin/bash /usr/bin/emulationstation/emulationstation.sh
root       708  0.0  0.0      0     0 ?        I<   19:54   0:00 [kbase_event]
root      1037  0.0  0.0      0     0 ?        I<   21:10   0:00 [kworker/1:1H]
root      1075  0.0  0.0      0     0 ?        I<   20:39   0:01 [kworker/3:0H-kblockd]
ark       1080  0.0  0.0   2052   460 ?        S    21:10   0:00 sh -c sudo perfmax ondemand /roms/ports/diagnostico.sh; nice -n -19 /usr/local/bin/AltSDL.sh /roms/ports/diagnostico.sh; sudo perfnorm
ark       1145  0.0  0.2   6468   992 ?        S<   21:10   0:00 /bin/bash /usr/local/bin/AltSDL.sh /roms/ports/diagnostico.sh
root      1168  0.0  0.0      0     0 ?        S    20:39   0:00 [scsi_eh_0]
root      1169  0.0  0.0      0     0 ?        I<   20:39   0:00 [scsi_tmf_0]
root      1170  0.0  0.0      0     0 ?        S    20:39   0:01 [usb-storage]
ark       1277  0.0  0.9  17684  4688 ?        Ss   19:55   0:00 /lib/systemd/systemd --user
ark       1284  0.0  0.0 102640   392 ?        S    19:55   0:00 (sd-pam)
ark       1325  0.0  0.7   7132  3360 ttyFIQ0  S+   19:55   0:01 -bash
root      3991  0.0  0.0   4908   464 ?        S    21:10   0:00 sleep 1
root      4027  0.0  0.7   9524  3772 ?        S<   21:10   0:00 sudo ps aux --sort=-%cpu
root      4032  0.0  0.5   8568  2732 ?        R<   21:10   0:00 ps aux --sort=-%cpu
root     15010  0.0  0.0      0     0 ?        I<   21:02   0:00 [kworker/0:2H]
root     15034  0.0  0.0      0     0 ?        I<   21:02   0:00 [kworker/3:1H]
root     15348  0.0  0.0      0     0 ?        I<   21:03   0:00 [kworker/1:0H]
root     16571  0.0  0.0      0     0 ?        I    21:04   0:00 [kworker/3:1-events]
ark      17229  0.0  0.6   6952  2904 ?        Ss   20:44   0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root     17503  0.0  0.2   2800  1184 ?        Ss   20:44   0:00 /usr/local/bin/ogage
root     18460  0.0  0.0      0     0 ?        I<   21:04   0:00 [kworker/2:1H]
root     18586  0.0  0.0      0     0 ?        I<   21:04   0:00 [kworker/u9:1-kbase_pm_poweroff_wait]
root     28261  0.0  0.0      0     0 ?        I    21:09   0:00 [kworker/2:2-events]
root     28964  0.0  0.0      0     0 ?        I<   20:56   0:00 [kworker/0:0H-mmc_complete]
root     29155  0.0  0.0      0     0 ?        I<   21:09   0:00 [kworker/u9:2-kbase_pm_poweroff_wait]
root     30428  0.0  0.0      0     0 ?        I<   21:10   0:00 [kworker/2:0H]
=== FIN SECCIÓN: Procesos en Ejecución ===


=== SECCIÓN: Uso de Memoria por Procesos ===
Comando ejecutado: ps aux --sort=-%mem
Resultado:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ark        695 14.5 14.9 1041336 71608 ?       Sl   19:54  11:01 /usr/bin/emulationstation/emulationstation
root       364  0.0  1.3  15044  6504 ?        Ss   19:54   0:01 python3 /usr/local/bin/batt_life_warning.py
root         1  1.8  1.2 166148  6072 ?        Ss   19:54   1:22 /sbin/init splash
root       363  0.0  1.2  28080  5820 ?        Ss   19:54   0:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
ark       1277  0.0  0.9  17684  4688 ?        Ss   19:55   0:00 /lib/systemd/systemd --user
systemd+   358  0.1  0.8  20500  4124 ?        Ss   19:54   0:05 /lib/systemd/systemd-resolved
systemd+   356  0.0  0.8  89448  4072 ?        Ssl  19:54   0:03 /lib/systemd/systemd-timesyncd
root       367  0.3  0.8  15664  3968 ?        Ss   19:54   0:18 /lib/systemd/systemd-logind
root      4036  0.0  0.7   9524  3804 ?        S<   21:10   0:00 sudo ps aux --sort=-%mem
ark       1146 15.8  0.7   7112  3440 ?        S<   21:10   0:03 /bin/bash /roms/ports/diagnostico.sh
ark       1325  0.0  0.7   7132  3360 ttyFIQ0  S+   19:55   0:01 -bash
message+   368  1.5  0.6   7236  3116 ?        Ss   19:54   1:11 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
ark      17229  0.0  0.6   6952  2904 ?        Ss   20:44   0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root      4041  0.0  0.5   8568  2764 ?        R<   21:10   0:00 ps aux --sort=-%mem
root       375  0.0  0.5   6748  2740 ?        Ss   19:54   0:00 /bin/bash /usr/bin/mpv_sense
root       369  0.0  0.5 258908  2644 ?        Ssl  19:54   0:00 /usr/sbin/NetworkManager --no-daemon
root       447  0.3  0.5   6468  2576 ?        S    19:54   0:14 /bin/bash /usr/local/bin/checknswitchforusbdac.sh
ark        669  0.0  0.5   6468  2404 ?        Ss   19:54   0:00 /bin/bash /usr/bin/emulationstation/emulationstation.sh
root       636  0.0  0.4   9532  2204 ttyFIQ0  Ss   19:54   0:00 /bin/login -p --
root       370  0.0  0.4   6568  2172 ?        Ss   19:54   0:00 /usr/sbin/cron -f
root       264  0.0  0.4  17596  2016 ?        Ss   19:54   0:00 /lib/systemd/systemd-udevd
root       373  0.0  0.4   9968  1944 ?        Ss   19:54   0:00 /sbin/wpa_supplicant -u -c/etc/wpa_supplicant/wpa_supplicant.conf -O/run/wpa_supplicant
root       428  0.1  0.3   6748  1908 ?        S    19:54   0:05 /bin/bash /usr/bin/mpv_sense
root       427  0.0  0.2   6748  1220 ?        S    19:54   0:00 /bin/bash /usr/bin/mpv_sense
root     17503  0.0  0.2   2800  1184 ?        Ss   20:44   0:00 /usr/local/bin/ogage
root       429  0.0  0.2   1960  1136 ?        S    19:54   0:00 evtest /dev/input/event0
ark       1145  0.0  0.2   6468   992 ?        S<   21:10   0:00 /bin/bash /usr/local/bin/AltSDL.sh /roms/ports/diagnostico.sh
root      3991  0.0  0.0   4908   464 ?        S    21:10   0:00 sleep 1
ark       1080  0.0  0.0   2052   460 ?        S    21:10   0:00 sh -c sudo perfmax ondemand /roms/ports/diagnostico.sh; nice -n -19 /usr/local/bin/AltSDL.sh /roms/ports/diagnostico.sh; sudo perfnorm
root       433  0.0  0.0   1960   448 ?        S    19:54   0:00 evtest /dev/input/event4
ark       1284  0.0  0.0 102640   392 ?        S    19:55   0:00 (sd-pam)
root       434  0.0  0.0   1960   388 ?        S    19:54   0:00 evtest /dev/input/event5
root       432  0.0  0.0   1960   380 ?        S    19:54   0:00 evtest /dev/input/event2
root       430  0.0  0.0   1960   328 ?        S    19:54   0:00 evtest /dev/input/event1
root         2  0.0  0.0      0     0 ?        S    19:54   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   19:54   0:00 [rcu_gp]
root         4  0.0  0.0      0     0 ?        I<   19:54   0:00 [rcu_par_gp]
root         8  0.0  0.0      0     0 ?        I<   19:54   0:00 [mm_percpu_wq]
root         9  0.0  0.0      0     0 ?        S    19:54   0:00 [rcu_tasks_rude_]
root        10  0.1  0.0      0     0 ?        S    19:54   0:05 [ksoftirqd/0]
root        11  0.2  0.0      0     0 ?        I    19:54   0:13 [rcu_sched]
root        12  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/0]
root        13  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/0]
root        14  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/1]
root        15  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/1]
root        16  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/1]
root        19  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/2]
root        20  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/2]
root        21  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/2]
root        24  0.0  0.0      0     0 ?        S    19:54   0:00 [cpuhp/3]
root        25  0.0  0.0      0     0 ?        S    19:54   0:00 [migration/3]
root        26  0.0  0.0      0     0 ?        S    19:54   0:00 [ksoftirqd/3]
root        29  0.0  0.0      0     0 ?        S    19:54   0:00 [kdevtmpfs]
root        30  0.0  0.0      0     0 ?        I<   19:54   0:00 [netns]
root        35  0.0  0.0      0     0 ?        S    19:54   0:00 [oom_reaper]
root        36  0.0  0.0      0     0 ?        I<   19:54   0:00 [writeback]
root        77  0.0  0.0      0     0 ?        I<   19:54   0:00 [kblockd]
root        78  0.0  0.0      0     0 ?        S    19:54   0:02 [kconsole]
root        79  0.0  0.0      0     0 ?        I<   19:54   0:00 [tpm_dev_wq]
root        80  0.0  0.0      0     0 ?        I<   19:54   0:00 [edac-poller]
root        81  0.0  0.0      0     0 ?        I<   19:54   0:00 [devfreq_wq]
root        82  0.0  0.0      0     0 ?        S    19:54   0:00 [watchdogd]
root        83  0.1  0.0      0     0 ?        S    19:54   0:05 [cfinteractive]
root        86  0.0  0.0      0     0 ?        I<   19:54   0:00 [cfg80211]
root        87  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/25-rockchip]
root       108  0.1  0.0      0     0 ?        S    19:54   0:07 [kswapd0]
root       109  0.0  0.0      0     0 ?        I<   19:54   0:00 [xfsalloc]
root       110  0.0  0.0      0     0 ?        I<   19:54   0:00 [xfs_mru_cache]
root       112  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/52-rockchip]
root       113  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/53-rockchip]
root       114  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/54-rockchip]
root       115  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/55-rockchip]
root       116  0.0  0.0      0     0 ?        S    19:54   0:00 [queue_work0]
root       117  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/38-ff440000]
root       118  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/35-ff442400]
root       119  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/37-ff442000]
root       120  0.0  0.0      0     0 ?        S    19:54   0:00 [hwrng]
root       123  0.0  0.0      0     0 ?        SN   19:54   0:00 [dmabuf-deferred]
root       124  0.0  0.0      0     0 ?        I<   19:54   0:00 [uas]
root       125  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/56-rk817]
root       126  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-bat-monit]
root       127  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-dc-wq]
root       129  0.0  0.0      0     0 ?        I<   19:54   0:00 [rk817-usb-wq]
root       134  0.0  0.0      0     0 ?        I<   19:54   0:00 [cryptodev_queue]
root       135  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/82-headset_]
root       136  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/83-ff370000]
root       137  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/84-ff380000]
root       139  0.0  0.0      0     0 ?        I<   19:54   0:00 [ipv6_addrconf]
root       141  0.0  0.0      0     0 ?        S    19:54   0:00 [irq/42-rga]
root       142  0.0  0.0      0     0 ?        I<   19:54   0:00 [mmc_complete]
root       143  0.0  0.0      0     0 ?        S    19:54   0:00 [card0-crtc0]
root       145  0.0  0.0      0     0 ?        I<   19:54   0:00 [gpu_power_off_w]
root       146  0.0  0.0      0     0 ?        I<   19:54   0:00 [free_pages_work]
root       148  0.0  0.0      0     0 ?        S    19:54   0:00 [mali-simple-pow]
root       150  0.0  0.0      0     0 ?        I<   19:54   0:00 [kbase_job_fault]
root       169  0.0  0.0      0     0 ?        I<   19:54   0:00 [mmc_complete]
root       193  0.0  0.0      0     0 ?        I<   19:54   0:03 [kworker/2:2H-kblockd]
root       196  0.0  0.0      0     0 ?        I<   19:54   0:03 [kworker/1:2H-kblockd]
root       213  0.0  0.0      0     0 ?        S    19:54   0:00 [jbd2/mmcblk1p2-]
root       214  0.0  0.0      0     0 ?        I<   19:54   0:00 [ext4-rsv-conver]
root       344  0.0  0.0      0     0 ?        S    19:54   0:00 [jbd2/mmcblk1p3-]
root       345  0.0  0.0      0     0 ?        I<   19:54   0:00 [ext4-rsv-conver]
root       708  0.0  0.0      0     0 ?        I<   19:54   0:00 [kbase_event]
root      1037  0.0  0.0      0     0 ?        I<   21:10   0:00 [kworker/1:1H]
root      1075  0.0  0.0      0     0 ?        I<   20:39   0:01 [kworker/3:0H-kblockd]
root      1100  1.0  0.0      0     0 ?        I    21:10   0:00 [kworker/1:0-events]
root      1168  0.0  0.0      0     0 ?        S    20:39   0:00 [scsi_eh_0]
root      1169  0.0  0.0      0     0 ?        I<   20:39   0:00 [scsi_tmf_0]
root      1170  0.0  0.0      0     0 ?        S    20:39   0:01 [usb-storage]
root      2340  1.1  0.0      0     0 ?        I    20:57   0:08 [kworker/1:3-events]
root      2790  0.4  0.0      0     0 ?        I    20:57   0:03 [kworker/3:3-events]
root     10651  0.6  0.0      0     0 ?        I    20:42   0:11 [kworker/3:2-events]
root     15010  0.0  0.0      0     0 ?        I<   21:02   0:00 [kworker/0:2H]
root     15034  0.0  0.0      0     0 ?        I<   21:02   0:00 [kworker/3:1H]
root     15348  0.0  0.0      0     0 ?        I<   21:03   0:00 [kworker/1:0H]
root     15506  0.6  0.0      0     0 ?        I    21:04   0:02 [kworker/1:1-events]
root     16571  0.0  0.0      0     0 ?        I    21:04   0:00 [kworker/3:1-events]
root     16807  0.7  0.0      0     0 ?        I    21:04   0:03 [kworker/2:0-events]
root     18317  0.1  0.0      0     0 ?        I    21:04   0:00 [kworker/u8:0-events_unbound]
root     18460  0.0  0.0      0     0 ?        I<   21:04   0:00 [kworker/2:1H]
root     18530  0.1  0.0      0     0 ?        I    20:18   0:04 [kworker/u8:2-events_unbound]
root     18586  0.0  0.0      0     0 ?        I<   21:04   0:00 [kworker/u9:1-kbase_pm_poweroff_wait]
root     19326  0.6  0.0      0     0 ?        I    20:45   0:10 [kworker/0:0-events]
root     23054  0.4  0.0      0     0 ?        I    21:05   0:01 [kworker/0:2-events_freezable]
root     23715  0.3  0.0      0     0 ?        I    20:49   0:04 [kworker/1:2-cgroup_destroy]
root     24243  0.1  0.0      0     0 ?        I    20:51   0:01 [kworker/u8:3-events_unbound]
root     26636  0.5  0.0      0     0 ?        I    20:32   0:11 [kworker/0:4-events]
root     28261  0.0  0.0      0     0 ?        I    21:09   0:00 [kworker/2:2-events]
root     28482  1.0  0.0      0     0 ?        I    21:09   0:00 [kworker/3:0-events]
root     28810  1.0  0.0      0     0 ?        I    20:56   0:09 [kworker/2:1-events]
root     28849  0.3  0.0      0     0 ?        I    20:56   0:03 [kworker/0:1-cgroup_destroy]
root     28912  0.2  0.0      0     0 ?        I    21:09   0:00 [kworker/u8:1-events_power_efficient]
root     28964  0.0  0.0      0     0 ?        I<   20:56   0:00 [kworker/0:0H-mmc_complete]
root     29155  0.0  0.0      0     0 ?        I<   21:09   0:00 [kworker/u9:2-kbase_pm_poweroff_wait]
root     30325  0.1  0.0      0     0 ?        I<   20:57   0:00 [kworker/u9:0-kbase_pm_poweroff_wait]
root     30428  0.0  0.0      0     0 ?        I<   21:10   0:00 [kworker/2:0H]
root     30545  0.1  0.0      0     0 ?        I    20:57   0:01 [kworker/2:3-events]
=== FIN SECCIÓN: Uso de Memoria por Procesos ===


=== SECCIÓN: Uptime del Sistema ===
Comando ejecutado: uptime
Resultado:
 21:10:52 up  1:16,  1 user,  load average: 0,98, 0,64, 0,65
=== FIN SECCIÓN: Uptime del Sistema ===


=== SECCIÓN: Fecha y Hora del Sistema ===
Comando ejecutado: date; echo 'Reloj hardware:'; hwclock 2>/dev/null || echo 'No se puede acceder al reloj hardware'
Resultado:
jue jul 17 21:10:53 CEST 2025
Reloj hardware:
No se puede acceder al reloj hardware
=== FIN SECCIÓN: Fecha y Hora del Sistema ===


=== SECCIÓN: Usuarios Loggeados ===
Comando ejecutado: who
Resultado:
ark      ttyFIQ0      2025-07-17 19:55
=== FIN SECCIÓN: Usuarios Loggeados ===


=== SECCIÓN: Historial de Logins ===
Comando ejecutado: last | head -10
Resultado:
ark      ttyFIQ0                       Thu Jul 17 19:55   still logged in
reboot   system boot  5.10.160-gc18be2 Fri Aug  4 13:11   still running
ark      ttyFIQ0                       Thu Jul 17 19:54 - down   (01:59)
reboot   system boot  5.10.160-gc18be2 Fri Aug  4 11:12 - 21:54 (2904+10:42)
ark      ttyFIQ0                       Sat Aug 30 15:37 - down   (00:08)
reboot   system boot  5.10.160-gc18be2 Sat Aug 30 15:37 - 15:46  (00:09)
reboot   system boot  5.10.160-gc18be2 Fri Aug 29 21:22 - 21:33  (00:10)
reboot   system boot  5.10.160-gc18be2 Fri Aug 29 18:17 - 18:19  (00:01)
ark      ttyFIQ0                       Thu Jul 17 19:55 - down   (00:16)
reboot   system boot  5.10.160-gc18be2 Sat Aug  5 09:07 - 20:11 (2903+11:03)
=== FIN SECCIÓN: Historial de Logins ===


=== SECCIÓN: Dispositivos USB ===
Comando ejecutado: lsusb 2>/dev/null || echo 'Comando lsusb no disponible'
Resultado:
Bus 001 Device 002: ID 0930:6544 Toshiba Corp. TransMemory-Mini / Kingston DataTraveler 2.0 Stick
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
=== FIN SECCIÓN: Dispositivos USB ===


=== SECCIÓN: Variables de Entorno ===
Comando ejecutado: printenv | grep -E '(PATH|HOME|USER|LANG|SHELL|TERM)'
Resultado:
LANGUAGE=es_ES:es
LANG=es_ES.UTF-8
TERM=dumb
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
USER=root
HOME=/root
SHELL=/bin/bash
SUDO_USER=ark
=== FIN SECCIÓN: Variables de Entorno ===

================================================================
DIAGNÓSTICO COMPLETADO - jue jul 17 21:10:53 CEST 2025
================================================================

