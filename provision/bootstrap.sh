#!/usr/bin/env bash

source ~/.bash_profile

LOG_PATH_AND_NAME="/vagrant/provision-results.log"

echo "Starting Log -----------\n" > $LOG_PATH_AND_NAME

echo -e "\n**** Installing Jetbrains RubyMine IDE ****\n"

RUBYMINE_DOWNLOAD_LINK=https://download.jetbrains.com/ruby/RubyMine-2019.1.tar.gz
RUBYMINE_DOWNLOAD_FILENAME=${RUBYMINE_DOWNLOAD_LINK##*/}

if [[ ! -f ~/$RUBYMINE_DOWNLOAD_FILENAME ]]; then
  echo -e "\n**** Downloading RubyMine ****\n"
  echo -e "\n**** Downloading RubyMine ****\n" >> $LOG_PATH_AND_NAME 2>&1
  curl -Lo ~/$RUBYMINE_DOWNLOAD_FILENAME $RUBYMINE_DOWNLOAD_LINK >> $LOG_PATH_AND_NAME 2>&1

  if [[ ! -f ~/$RUBYMINE_DOWNLOAD_FILENAME ]]; then
    echo -e "\nERROR: unable to download RubyMine \n"
    echo -e "\nERROR: unable to download RubyMine \n" >> $LOG_PATH_AND_NAME 2>&1
    exit 0
  fi
else
  echo -e "\n**** Already have RubyMine ****\n"
  echo -e "\n**** Already have RubyMine ****\n" >> $LOG_PATH_AND_NAME 2>&1
fi

echo -e "\n**** Install RubyMine ****\n"
sudo mkdir -p /opt/RubyMine
sudo tar -zxvf ~/$RUBYMINE_DOWNLOAD_FILENAME --strip-components 1 -C /opt/RubyMine >> $LOG_PATH_AND_NAME 2>&1
sudo chown -R root:root /opt/RubyMine
rm ~/$RUBYMINE_DOWNLOAD_FILENAME

sudo tee /usr/share/applications/jetbrains-rubymine.desktop &>/dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=RubyMine
Icon=/opt/RubyMine/bin/RMlogo.svg
Exec="/opt/RubyMine/bin/rubymine.sh" %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-rubymine
EOF

sudo apt-get -y remove unity-lens-shopping >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Adjusting taskbar default shortcuts ****\n"

sudo tee /etc/xdg/autostart/set-gnome-settings.sh.desktop &>/dev/null <<EOF
[Desktop Entry]
Type=Application
Exec=/vagrant/provision/set-gnome-settings.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Apply Gnome Settings
Comment=Apply Gnome Settings at next restart
EOF

sudo service lightdm restart

echo -e "\n**** Do not install Ruby documentation with gems, most current docs are always online. ****\n"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

echo -e "\n**** Configure default Ruby for Vagrant user ****\n"
rvm install ruby-2.3 >> $LOG_PATH_AND_NAME 2>&1
rvm use ruby-2.3 --default >> $LOG_PATH_AND_NAME 2>&1
rvm gemset use global >> $LOG_PATH_AND_NAME 2>&1
gem install bundler >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Configure default NodeJS for Vagrant User ****\n"
nvm install 6.8.1 >> $LOG_PATH_AND_NAME 2>&1
nvm use 6.8.1 >> $LOG_PATH_AND_NAME 2>&1
nvm alias default 6.8.1 >> $LOG_PATH_AND_NAME 2>&1
npm install -g npm >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Downloading & setting up Web Test Automation Projects ****\n"
cd ~/Projects/
git clone https://github.com/leandog/puppies.git >> $LOG_PATH_AND_NAME 2>&1
git clone https://github.com/leandog/atdd-with-puppies.git >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Installing Ruby Gems for Web Project ****\n"
cd ~/Projects/puppies >> $LOG_PATH_AND_NAME 2>&1
bundle install >> $LOG_PATH_AND_NAME 2>&1
rake db:setup >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Installing Ruby Gems for Test Automation Project ****\n"
cd ~/Projects/atdd-with-puppies >> $LOG_PATH_AND_NAME 2>&1
bundle install >> $LOG_PATH_AND_NAME 2>&1

echo -e "\n**** Finished installation & setup! ****\n"

