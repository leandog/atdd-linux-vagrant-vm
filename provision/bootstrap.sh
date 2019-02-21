#!/usr/bin/env bash

source ~/.bash_profile

echo -e "\n**** Installing Jetbrains RubyMine IDE ****\n"

RUBYMINE_DOWNLOAD_LINK=https://download.jetbrains.com/ruby/RubyMine-2018.3.4.tar.gz
RUBYMINE_DOWNLOAD_FILENAME=${RUBYMINE_DOWNLOAD_LINK##*/}

if [[ ! -f ~/$RUBYMINE_DOWNLOAD_FILENAME ]]; then
  echo -e "\n**** Downloading RubyMine ****\n"
  echo -e "\n**** Downloading RubyMine ****\n" > /dev/null 2>&1
  curl -Lo ~/$RUBYMINE_DOWNLOAD_FILENAME $RUBYMINE_DOWNLOAD_LINK > /dev/null 2>&1

  if [[ ! -f ~/$RUBYMINE_DOWNLOAD_FILENAME ]]; then
    echo -e "\nERROR: unable to download RubyMine \n"
    echo -e "\nERROR: unable to download RubyMine \n" > /dev/null 2>&1
    exit 0
  fi
else
  echo -e "\n**** Already have RubyMine ****\n"
  echo -e "\n**** Already have RubyMine ****\n" > /dev/null 2>&1
fi

echo -e "\n**** Install RubyMine ****\n"
sudo mkdir -p /opt/RubyMine
sudo tar -zxvf ~/$RUBYMINE_DOWNLOAD_FILENAME --strip-components 1 -C /opt/RubyMine > /dev/null 2>&1
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

sudo apt-get -y remove unity-lens-shopping > /dev/null 2>&1

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
rvm install ruby-2.3 > /dev/null 2>&1
rvm use ruby-2.3 --default > /dev/null 2>&1
rvm gemset use global > /dev/null 2>&1
gem install bundler > /dev/null 2>&1
gem install neo-git-pair > /dev/null 2>&1

echo -e "\n**** Configure default NodeJS for Vagrant User ****\n"
nvm install 6.8.1 > /dev/null 2>&1
nvm use 6.8.1 > /dev/null 2>&1
nvm alias default 6.8.1 > /dev/null 2>&1
npm install -g npm > /dev/null 2>&1

echo -e "\n**** Downloading & setting up Web Test Automation Projects ****\n"
cd ~/Projects/
git clone https://github.com/leandog/puppies.git > /dev/null 2>&1
git clone https://github.com/leandog/atdd-with-puppies.git > /dev/null 2>&1

echo -e "\n**** Installing Ruby Gems for Web Project ****\n"
cd ~/Projects/puppies > /dev/null 2>&1
bundle install > /dev/null 2>&1

echo -e "\n**** Installing Ruby Gems for Test Automation Project ****\n"
cd ~/Projects/atdd-with-puppies > /dev/null 2>&1
bundle install > /dev/null 2>&1

echo -e "\n**** Finished installation & setup! ****\n"

