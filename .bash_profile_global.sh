# key_word_for_bash_profile

# 命令行提示符定制
# Note:
# 颜色标注推荐规范: 
#   1) 本地/Dev - 绿色 [1;32m green [0m
#   2) 测试机   - 蓝色
#   3) 线上机器 - 红色
#   4) 跳板机   - 黄色
# 修改下 bash 的提示符的颜色.以便区分普通字符与提示符
PS1='\[\e[32m\][\u@\h \w]\$\[\e[m\]'

alias ls='ls -G'
alias ll='ls -G -lash'

# git 相关加强命令
alias ckmaster='git fetch && git log HEAD..origin/master --oneline'

# ant 相关配置
ANT_HOME=/usr/local/q/apache-ant-1.10.12
PATH=${ANT_HOME}/bin:$PATH

# Maven相关配置
M3_HOME=/usr/local/q/apache-maven-3.3.3
M2_HOME=/usr/local/q/apache-maven-3.3.3
GRADLE_HOME=/usr/local/q/gradle-4.4.1
PATH=$M3_HOME/bin:$M2_HOME/bin:$GRADLE_HOME/bin:$PATH
export M2_HOME
export M3_HOME
export PATH

# 额外的 用户自定义想着的定义写到: .bashrc 中(以符合纯Linux环境用户的习惯)
#
# Note: 
# 最近在学习unix，学到bash的时候发现它总是不读取~/.bashrc。
# 因为Mac OS X上的bash是通过login的方式运行的，而man bash中写着，通过login方式登录的bash不会读取~/.bashrc。
# 解决方法：把下面的代码 添加到 ~/.bash_profile中。
# source ~/.bashrc
# http://blog.csdn.net/liu510817387/article/details/8126719
if [ "${BASH-no}" != "no" ]; then
    [ -r ~/.bashrc ] && . ~/.bashrc
fi
# 设置 JDK 7
export JAVA_7_HOME=`/usr/libexec/java_home -v 1.7`
# 设置 JDK 8
export JAVA_8_HOME=`/usr/libexec/java_home -v 1.8`

#默认JDK 8
export JAVA_HOME=$JAVA_8_HOME

#alias命令动态切换JDK版本
alias jdk6="export JAVA_HOME=$JAVA_6_HOME"
alias jdk7="export JAVA_HOME=$JAVA_7_HOME"
alias jdk8="export JAVA_HOME=$JAVA_8_HOME"



export PATH="/usr/local/opt/thrift@0.9/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
