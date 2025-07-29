#
#  Deb creator
#
#  Author Rybochkin Aleksei
#  July 2025
#
#  
#
#
#
#  



###  1 - Создать пакет DEBIAN и прочее  ---------------
function debcreate() {
echo " Создание пакетов DEBIAN..."

##############
mkdir -p package/DEBIAN  # Создание манифеста
cd package/DEBIAN
touch control
echo "Source:" >> control
echo "Section:" >> control
echo "Priority:" >> control
echo "Maintainer:" >> control
echo "Build-Depends:" >> control
echo "Standards-Version:" >> control
echo "Homepage:" >> control
echo "Package:" >> control
echo "Architecture:" >> control
echo "Provides:" >> control
echo "Description:" >> control

###################

touch changelog

#############

touch rules
echo "#!/usr/bin/make -f" >> rules
echo "" >> rules
echo "" >> rules
echo "" >> rules
echo "" >> rules
echo "" >> rules


###################

touch compat
echo "12" >> compat


###################
touch postinst
echo "#!/bin/sh" >> postinst
echo "set -e" >> postinst

###################
touch postrm
echo "#!/bin/sh -e" >> postrm

###################
touch preinst
echo "" >> preinst

###################
touch prerm
echo "#!/bin/sh -e" >> prerm


echo " 1 exit "
}




###   2 - Собрать пакет в текущем каталоге  
function debinst() { 
echo " Собрать пакет в текущем каталоге "

debuild -us -uc -b

echo " 2 Exit ..."
exit 0
}

###   3 - Установить нужные пакеты для сборки  
function installpak() { 
echo " Установить нужные пакеты для сборки  "

apt-get update
apt-get install dpkg-dev devscripts equivs wget lintian
apt-get check

mk-build-deps --install

# echo yes | mk-build-deps -ri ## для установки без вопросов

echo " 3 Exit ..."
exit 0
}




### - 4 ВЫХОД ИЗ СКРИПТА
function fnexit() { 
echo " ВЫХОД ИЗ СКРИПТА "
echo " 4 Exit ..."
exit 0
}


### - 6 - Просмотреть зависимости  
function needed() { 
echo " Введите название файла для проверки зависимости "

read need

objdump -p ./$need | grep NEEDED


echo " 6 Exit ..."
exit 0
}


function mainn() {
echo " 1 - Создать пакет DEBIAN и прочее  "
echo " 2 - Собрать пакет в текущем каталоге  "
echo " 3 - Установить нужные пакеты для сборки  "
echo " 4 - Exit  "
echo " 5 - Главное меню  "
echo " 6 - Просмотреть зависимости  "


echo " Введите значение ... "
main
}

function main() {

read number

case $number in

1) debcreate
;;
2) debinst
;;
3) installpak
;;
4) fnexit
;;
5) mainn
;;
6) needed
;;

*) mainn
;;
esac
}



#! /bin/bash
### - 0 ГЛАВНОЕ МЕНЮ ------------------
echo " "
echo " Deb Creator by Rybochkin Aleksei "
echo "  Выберите действие...  "
mainn
