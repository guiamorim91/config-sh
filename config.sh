#!/usr/bin/env bash

# Config
black() { echo "$(tput setaf 0)$*$(tput setaf 7)"; }
red() { echo "$(tput setaf 1)$*$(tput setaf 7)"; }
green() { echo "$(tput setaf 2)$*$(tput setaf 7)"; }
yellow() { echo "$(tput setaf 3)$*$(tput setaf 7)"; }
blue() { echo "$(tput setaf 4)$*$(tput setaf 7)"; }
magenta() { echo "$(tput setaf 5)$*$(tput setaf 7)"; }
cyan() { echo "$(tput setaf 6)$*$(tput setaf 7)"; }
white() { echo "$(tput setaf 7)$*$(tput setaf 7)"; }

# Atualização do sistema.
blue "Iniciando configuração do ambiente";
sudo apt-get update;
clear;

# Varios
blue "Instalação de programas uteis.";
sudo apt-get -y install curl git subversion npm nodejs nodejs-legacy python-software-properties autoconf;
clear;

# Google Chrome
blue "Instalação do Google Chrome";
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
sudo dpkg -i google-chrome-stable_current_amd64.deb;
sudo rm google-chrome-stable_current_amd64.deb;
clear;

# Java
blue "Instalação do Java Oracle";
sudo add-apt-repository ppa:webupd8team/java -y;
sudo apt-get update;
sudo apt-get -y install oracle-java8-installer;
clear;

# Zend Server
blue "Instalação do Zend Server";
echo "deb http://repos.zend.com/zend-server/8.5/deb_apache2.4 server non-free" | sudo tee -a /etc/apt/sources.list;
wget http://repos.zend.com/zend.key -O- | sudo apt-key add -;
sudo apt-get update;
sudo apt-get -y install zend-server-php-5.6;

# Configuração da variavel de ambiente.
blue "Configuração da variavel de ambiente.";
sudo echo 'export PATH=$PATH:/usr/local/zend/bin' >> $HOME/.bashrc;

# Configurando pasta PHP como Sudo
blue "Adicionando PHP para ser executado como sudo.";
sudo sed -i '11s/\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin/\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin:\/usr\/local\/zend\/bin/' /etc/sudoers;

# Composer
blue "Instalação do Composer.";
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer;
clear;

# Sublime Text
blue "Instalação do sublime text";
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3;
sudo apt-get update; 
sudo apt-get install sublime-text-installer;
clear;

# Instant Client Oracle
blue "Instalação do Oracle Instant Client";
cd files/;
sudo unzip instantclient-basic-linux.x64-11.2.0.4.0.zip -d /opt;
sudo unzip instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /opt;
cd /opt/instantclient_11_2;
sudo ln -s libclntsh.so.11.1 libclntsh.so;
sudo ln -s libocci.so.11.1 libocci.so;
red "Digite o seguinte texto quando solicitado: instantclient,/opt/instantclient_11_2";
sudo pecl install oci8-2.0.12;
echo "extension=oci8.so" | sudo tee -a /usr/local/zend/etc/php.ini;
sudo service apache2 restart;
clear;

# Phpstorm
blue "Instalação do PHPStorm.";
sudo mkdir ~/phpstorm;
cd ~/phpstorm;
sudo rm -rf *.tar.gz ;
clear;
sudo wget https://download.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz;
sudo tar -zxvf PhpStorm-2017.2.4.tar.gz;
sudo chmod -Rv 777 ~/phpstorm;
clear;

cd /var/www;

# Gerador de Vhost
git clone https://github.com/guiamorim91/vhautlinux.git;

# Dicionario JetBrains Pt_br.
git clone https://github.com/guiamorim91/IntelliJ.Portuguese.Brazil.Dictionary.git;