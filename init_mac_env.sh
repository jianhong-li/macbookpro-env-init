#!/bin/bash

SOFT_JDK='jdk-8u202-macosx-x64.dmg'
SOFT_IDEA='ideaIU-2022.2.3.dmg'
SOFT_MAVEN='apache-maven-3.3.3-bin.tar.gz'
# https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.12-bin.tar.gz
SOFT_ANT='apache-ant-1.10.12-bin.tar.gz'

# pause the program to wait enter anything
# @see https://www.cyberciti.biz/tips/linux-unix-pause-command.html
function pause(){
    # -r: https://github.com/koalaman/shellcheck/wiki/SC2162
   read -rp "$*"
}

# check jdk md5
function md5sum_of_jdk() {
    md5sum "./${SOFT_JDK}" 2>/dev/null | awk '{print $1}'
}

# check idea md5
function md5sum_of_idea() {
    md5sum "./$SOFT_IDEA" 2>/dev/null | awk '{print $1}'
}

# check maven md5
function md5sum_of_maven() {
    md5sum "./${SOFT_MAVEN}" 2>/dev/null | awk '{print $1}'
}


# check ant md5
function md5sum_of_ant() {
    md5sum "./${SOFT_ANT}" 2>/dev/null | awk '{print $1}'
}

# 0)  check shell and change to bash

if [[ '/bin/bash' != `echo "$SHELL"` ]]; then
    pause '当前的SHELL环境非bash.将会默认切换到bash. press enter to continue .....'
    chsh -s /bin/bash
fi

# 0)  安装 brew 环境

echo 'begin to install brew......'

brew_bin=$(which brew)
if [ -z "$brew_bin" ]; then
    # 脚本会在执行前暂停，并说明它将做什么。
    # 官方文档: https://brew.sh/index_zh-cn
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "you has install brew in: [${brew_bin}] , continue to install other soft ....."
fi

echo 'begin to check whether wget has installed......'
wget_bin=$(which wget)
if [ -z "${wget_bin}" ]; then
  echo 'ready to install ======================> wget <================================='
    brew install wget
    if [ $? -ne 0 ]; then
        echo 'install wget failed.....exit'
        exit 1;
    fi
    echo 'end   to install ======================> wget <================================='
else
    echo 'wget has installed, continue........'
fi

echo 'begin to check whether wget has installed......'
if [[ -z `which md5sum` ]]; then
    echo 'ready to install ======================> md5sum <================================='
    brew install md5sha1sum
    echo 'end   to install ======================> md5sum <================================='
else
    echo 'ok. skip install md5sha1sum'
fi

# -------------------------------------------------------------------------------------------------
# brew 相关基础命令安装:
# *) iterm2(a terminator emulator)
# *) git   (a distributed code repository )
# *) jq    (a commandline JSON processor )
# *) nginx (a server proxy soft )
# *) sed   (Gnu Sed)
# *) grep  (Gnu grep)
# *) mysql (a opensource database)
# -------------------------------------------------------------------------------------------------

echo 'begin to install/check iTerm2 .......'
if [ ! -d  /Applications/iTerm.app ];then
    echo 'check iTerm do not exist. begin to install iTerm with homebrew .....'
    brew install --cask iterm2
    if [ $? -ne 0 ]; then
        echo 'install iTerm failed.....exit'
        exit 1;
    fi
    echo 'install success .... the iterm exist in these dir:'
    mdfind 'kMDItemCFBundleIdentifier == com.googlecode.iterm2'
fi



echo 'begin to config shell env for iterm2 .......'
if [[ ! -d ~/solarized ]]; then
    git clone https://github.com/altercation/solarized.git  ~/solarized
    if [ $? -ne 0 ]; then
        echo 'download solarized failed.....exit'
        exit 1;
    fi

    # config the vim
    mkdir -p ~/.vim/colors
    cp ~/solarized/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
    cat > ~/.vimrc << EOF
syntax on
set background=dark
colorscheme solarized
EOF
    # config iterm2
    open "${HOME}/solarized/iterm2-colors-solarized/Solarized Dark.itermcolors"
else
    echo 'solarized existed. do not config again.....'
fi

# -------------------------------------------------------------------------------------------------
# git install
# -------------------------------------------------------------------------------------------------

if [[ -z "$(which git)" ]]; then
    echo 'check git do not exist. begin to install git with homebrew .....'
    brew install git
    if [ $? -ne 0 ]; then
        echo 'install git failed.....exit'
        exit 1;
    fi
fi
# -------------------------------------------------------------------------------------------------
# jq install
# -------------------------------------------------------------------------------------------------
if [[ -z "$(which jq)" ]]; then
    echo 'check jq do not exist. begin to install jq with homebrew .....'
    brew install jq
    if [ $? -ne 0 ]; then
        echo 'install jq failed.....exit'
        exit 1;
    fi
fi
# -------------------------------------------------------------------------------------------------
# nginx install
# -------------------------------------------------------------------------------------------------
echo 'begin to check whether mysql has installed......'
if [[ -z "$(which nginx)" ]]; then
    echo 'check nginx do not exist. begin to install nginx with homebrew .....'
    brew install nginx
    if [ $? -ne 0 ]; then
        echo 'install nginx failed.....exit'
        exit 1;
    fi
fi
# -------------------------------------------------------------------------------------------------
# grep and gun-sed install
# -------------------------------------------------------------------------------------------------
brew install grep
brew install gnu-sed

# -------------------------------------------------------------------------------------------------
# mysql install
# -------------------------------------------------------------------------------------------------
echo 'begin to check whether mysql has installed......'
if [[ -z "$(which mysql)" ]]; then
    echo 'check mysql@5.7 do not exist. begin to install mysql@5.7 with homebrew .....'
    brew install mysql@5.7
    if [ $? -ne 0 ]; then
        echo 'install mysql failed.....exit'
        exit 1;
    fi
else
    echo 'mysql@5.7 has installed. skip installation this time......'
fi

# -------------------------------------------------------------------------------------------------
# bash shell env init
# this will just init once. if detect the flag. it will skip config it again.
# -------------------------------------------------------------------------------------------------
# 1)  初始化全局通用的一些优化配置，用于所有用户都会用到的基础配置
echo 'begin to init bash_profile......'

if [[ ! -f ~/.bash_profile ]];then
    echo '[.bash_profile] do not exist, create it: ~/.bash_profile'
    touch ~/.bash_profile
fi

grep -q "^# key_word_for_bash_profile" ~/.bash_profile 2>/dev/null
# shellcheck disable=SC2181
if [[  $? -eq 0 ]];then
    echo ".bash_profile 文件已经初始化，如有更新请手工处理"
else
    # read default config from template file: .bash_profile_global.sh
    echo "" >>  ~/.bash_profile
    cat .bash_profile_global.sh >>  ~/.bash_profile
fi


# 2) 安装 JDK
#
# we use huawei jdk mirror.
# website: https://mirrors.huaweicloud.com/java/jdk/
# this file's MD5 is: 9eb027c06c5da727229a29b3be79bf50

echo 'begin to install JDK8-202'

if [ -f ./jdk-8u202-macosx-x64.dmg ] && [ '9eb027c06c5da727229a29b3be79bf50' == "$(md5sum_of_jdk)" ]; then
    echo 'jdk-8u202-macosx-x64.dmg is ready now. just use it.....'
else
    rm -rf ./jdk-8u202-macosx-x64.dmg
    wget https://repo.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-macosx-x64.dmg
    if [[ $? -ne 0 ]]; then
            echo "Download JDK Failed , exit ......"
            exit 1;
    fi
fi

open ./jdk-8u202-macosx-x64.dmg
pause 'waiting for install jdk yourself. if your installation finish. please input "enter" to continue'
echo 'ok,we will begin to install maven.......'

# 3) 安装 Maven
#
# 软件下载地址: https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.3/apache-maven-3.3.3-bin.tar.gz
# 软件md5: 794b3b7961200c542a7292682d21ba36
# todo: 华为有更快的镜像,不过没有3.3.3版本. 有3.3.9版本.有时间的话可以切换为此镜像,提升安装速度. apache的下载速度是真的慢.
# 镜像地址: https://repo.huaweicloud.com/apache/maven/maven-3/3.3.9/binaries/
echo 'begin to check whether maven has installed......'
if [ -f ./apache-maven-3.3.3-bin.tar.gz ] && [ '794b3b7961200c542a7292682d21ba36' == "$(md5sum_of_maven)" ]; then
    echo 'apache-maven-3.3.3-bin.tar.gz is ready now. just use it.....'
else
    rm -rf ./apache-maven-3.3.3-bin.tar.gz
    wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.3/apache-maven-3.3.3-bin.tar.gz
    if [[ $? -ne 0 ]]; then
        echo "Download Maven Failed , exit ......"
        exit 1;
    fi
fi

if [ -d '/usr/local/q/apache-maven-3.3.3' ]; then
    echo 'maven has installed in directory: /usr/local/q/apache-maven-3.3.3 , skip install this time.....'
else
    # 确认安装地址
    echo 'apache maven:3.3.3 will install in directory: /usr/local/q , this maybe need your sudo password......'
    sudo mkdir -p /usr/local/q
    sudo tar -C /usr/local/q -xzvf ./apache-maven-3.3.3-bin.tar.gz
fi


# 4) 安装 Ant
#
# 软件下载地址： https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.12-bin.tar.gz

echo 'begin to check whether ant has installed......'
if [ -f ./apache-ant-1.10.12-bin.tar.gz ] && [ '5a9995cce0d8170bbf8007f2788ffbe4' == "$(md5sum_of_ant)" ]; then
    echo 'apache-ant-1.10.12-bin.tar.gz is ready now. just use it.....'
else
    rm -rf ./apache-ant-1.10.12-bin.tar.gz
    wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.12-bin.tar.gz
    if [[ $? -ne 0 ]]; then
        echo "Download Ant Failed , exit ......"
        exit 1;
    fi
fi

if [ -d '/usr/local/q/apache-ant-1.10.12' ]; then
    echo 'maven has installed in directory: /usr/local/q/apache-ant-1.10.12 , skip install this time.....'
else
    # 确认安装地址
    echo 'apache ant::1.10.12 will install in directory: /usr/local/q , this maybe need your sudo password......'
    sudo mkdir -p /usr/local/q
    sudo tar -C /usr/local/q -xzvf ./apache-ant-1.10.12-bin.tar.gz
fi

# -------------------------------------------------------------------------------------------------
# install thrift compiler: 0.9.3
# this will just init once. if detect the flag. it will skip config it again.
# -------------------------------------------------------------------------------------------------
# 1)  初始化全局通用的一些优化配置，用于所有用户都会用到的基础配置
echo 'begin to install thrift@0.9......'
if [ -f '/usr/local/opt/thrift@0.9/bin/thrift' ];then
    echo 'thrift compiler has installed. skip installation this time'
else
    brew install thrift@0.9
    if [ $? -ne 0 ]; then
            echo 'install thrift failed.....exit'
            exit 1;
    fi
    echo 'success to install thrift@0.9.3 .............'
fi

# 4) 安装 Intellij Idea
#
# 软件下载地址: https://download-cdn.jetbrains.com/idea/ideaIU-2022.2.3.dmg (如果文件下载链接失效,请自行替换)
# MD5: 103b1a7bfefeb3288d448612ab60356f
echo 'begin to check whether ideaIU has installed......'
if [ -f ./ideaIU-2022.2.3.dmg ] && [ '103b1a7bfefeb3288d448612ab60356f' == "$(md5sum_of_idea)" ]; then
    echo 'ideaIU-2022.2.3.dmg is ready now. just use it.....'
else
    rm -rf ./ideaIU-2022.2.3.dmg
    wget https://download-cdn.jetbrains.com/idea/ideaIU-2022.2.3.dmg
    if [[ $? -ne 0 ]]; then
            echo "Download Idea Failed , exit ......"
            exit 1;
    fi
fi

open ./ideaIU-2022.2.3.dmg
pause 'waiting for install idea yourself. if your installation finish. please input "enter" to continue'
echo 'ok,we will begin to install xxx.......'