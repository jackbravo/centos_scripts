#!/bin/bash

#install make and git
yum install -y make git ncurses ncurses-devel ctags
cd /home/user
wget https://gist.github.com/jackbravo/7163461/raw/7278d317e82ce55bbe676bf8f891a30af524b9b6/.vimrc
wget https://gist.github.com/jackbravo/7163635/raw/81d353fe42397d907edb9b6a532a8345552fba73/.tmux.conf
chown user:user .vimrc
chown user:user .tmux.conf
cd
wget https://gist.github.com/jackbravo/7163461/raw/7278d317e82ce55bbe676bf8f891a30af524b9b6/.vimrc
cd ~/build

git clone git://github.com/jonas/tig.git
cd tig
make prefix=/usr/local
make install prefix=/usr/local

#install tmux
cd
mkdir build
cd build
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xzvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure && make
make install
cd ~/build
git clone git://git.code.sf.net/p/tmux/tmux-code tmux
cd tmux
sh autogen.sh
./configure && make
make install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/lib"
echo export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\"/usr/local/lib\" >> /etc/bashrc

#install fish
cd ~/build
wget http://fishshell.com/files/2.0.0/linux/CentOS_CentOS-6/x86_64/fish-2.0.0-201305151006.1.x86_64.rpm
rpm -ivh fish-2.0.0-201305151006.1.x86_64.rpm
chsh -s /usr/bin/fish
chsh -s /usr/bin/fish user

#install htop
cd ~/build
wget http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/htop-1.0.2-1.el6.rf.x86_64.rpm
rpm -ivh htop-1.0.2-1.el6.rf.x86_64.rpm

mkdir -p ~/.config/fish
mkdir -p /home/user/.config/fish
echo "set PATH \$HOME/bin \$PATH" >> ~/.config/fish/config.fish
echo "set PATH \$HOME/bin \$PATH" >> /home/user/.config/fish/config.fish
echo "alias vi vim" >> ~/.config/fish/config.fish
echo "alias vi vim" >> /home/user/.config/fish/config.fish
echo "set -gx LD_LIBRARY_PATH /usr/local/lib" >> ~/.config/fish/config.fish
echo "set -gx LD_LIBRARY_PATH /usr/local/lib" >> /home/user/.config/fish/config.fish
chown -R user:user /home/user/.config
