#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#------------------------------------------------------------------------
#  Script de NiPeGun para instalar el escritorio mate-desktop en Termux
#------------------------------------------------------------------------

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
echo "  Configurando XServer..."
echo ""
export DISPLAY=localhost:0

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

