clear
echo
echo "[[[   - Verification systeme -   ]]]"
echo
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m'
cpucount=$((lscpu | egrep 'Processeur\(s\)|CPU\(s\)' | awk -F: '{print $2}' | head -n 1) | sed 's/^[ \t]*//;s/[ \t]*$//')
if [[ $cpucount -gt 1 ]]; then
   echo "Votre machine a le nombre minimal de CPU requis"
else
   echo "Installtation stoppée : Votre machine ne dispose pas de 2 CPU !"
   exit 1;
fi
echo
echo "[[[   - Version de votre OS -   ]]]"
echo
echo "1 - Ubuntu 22.04"
echo "2 - Alma Linux 8/9 (Version minimale)"
echo
read -p "Qu'elle est votre version ?" -n 1 -r osversion
echo
echo
echo "[[[   - Préparation et récupération des scripts -   ]]]"
echo
if [[ $osversion = 1 ]]; then
  script_dir="Ubuntu_22_04"
  sudo apt-get update
  sudo apt-get install -y git gparted
else
  script_dir="AlmaLinux_9"
  dnf update -y
  sudo dnf install git parted -y
fi
echo
echo "[[[   - Récupération de Git -   ]]]"
echo
cd $HOME
git clone https://github.com/firstruner/scripts_devops.git
cd scripts_devops
export script_dir
export osversion
export cpucount
export RED
export GREEN
export YELLOW
export BLUE
export MAGENTA
export CYAN
export WHITE
export NC
bash install.sh
