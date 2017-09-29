#!/usr/bin/env bash
# Atualização do sistema.
sudo apt-get update && sudo apt-get upgrade;
clear;

# Varios
sudo apt-get -y install curl git subversion npm nodejs nodejs-legacy python-software-properties autoconf;
clear;

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
sudo dpkg -i google-chrome-stable_current_amd64.deb;
sudo rm google-chrome-stable_current_amd64.deb;
clear;

# Java
sudo add-apt-repository ppa:webupd8team/java -y;
sudo apt-get update;
sudo apt-get -y install oracle-java8-installer;
clear;

# Zend Server
echo "deb http://repos.zend.com/zend-server/8.5/deb_apache2.4 server non-free" | sudo tee -a /etc/apt/sources.list;
wget http://repos.zend.com/zend.key -O- | sudo apt-key add -;
sudo apt-get update;
sudo apt-get -y install zend-server-php-5.6;

# Configuração da variavel de ambiente.
sudo echo 'export PATH=$PATH:/usr/local/zend/bin' >> $HOME/.bashrc;

# Configurando pasta PHP como Sudo
sudo sed -i '11s/\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin/\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin:\/snap\/bin:\/usr\/local\/zend\/bin/' /etc/sudoers;

# Composer
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer;
clear;

# Sublime Text
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3;
sudo apt-get update; 
sudo apt-get install sublime-text-installer;
clear;

cd /var/www;

# Gerador de Vhost
git clone https://github.com/guiamorim91/vhautlinux.git;

# Dicionario JetBrains Pt_br.
git clone https://github.com/guiamorim91/IntelliJ.Portuguese.Brazil.Dictionary.git;

# Instant Client Oracle
cd files/;
sudo unzip instantclient-basic-linux.x64-11.2.0.4.0.zip -d /opt;
sudo unzip instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /opt;
cd /opt/instantclient_11_2;
sudo ln -s libclntsh.so.11.1 libclntsh.so;
sudo ln -s libocci.so.11.1 libocci.so;
echo "$(tput setaf 1)Digite o seguinte texto quando solicitado: $(tput setab 7)instantclient,/opt/instantclient_11_2/";
sudo pecl install oci8-2.0.12;
echo "extension=oci8.so" | sudo tee -a /usr/local/zend/etc/php.ini;
sudo service apache2 restart;
clear;

# Phpstorm
sudo mkdir ~/phpstorm;
cd ~/phpstorm;
sudo rm -rf *.tar.gz ;
clear;
sudo wget https://download.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz;
sudo tar -zxvf PhpStorm-2017.2.4.tar.gz;
sudo chmod -Rv 777 ~/phpstorm;
clear;