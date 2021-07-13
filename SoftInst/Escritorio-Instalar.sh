#!/bin/bash

echo ""
echo "  Activando el repositorio X11..."
echo ""
pkg update
pkg install -y x11-repo

echo ""
echo "  Instalando el servidor VNC..."
echo ""
pkg update
pkg install -y tigervnc
export DISPLAY=":1"

echo ""
echo "  Instalando mate-desktop"
echo ""
pkg install -y mate-*
pkg install -y marco
echo "#!/data/data/com.termux/files/usr/bin/sh"  > ~/.vnc/xstartup
echo "mate-session &"                           >> ~/.vnc/xstartup

echo ""
echo "  Creando una contraseña de conexión..."
echo ""
vncserver -localhost

