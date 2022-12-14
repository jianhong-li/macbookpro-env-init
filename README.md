# macbookpro-env-init

> 如何优雅的使用MacBookPro

你有没有遇到过当拿到一个新电脑的要初始化很多环境,有没有觉得很繁琐有没有. 特别是很多事情要重复地做很多遍. 有没有一种可能把我的电脑的环境按要求自动初始化一遍? 这个脚本就是为了提高初始化电脑开发环境的. 只要运行此脚本就可能自动安装好 Java开发相关所需要的所有软件. 并配置好相关路径. 其不是美滋滋. 

#### 介绍

一个服务端工程师的macbookpro开发环境初始化脚本，主要包含如下内容：
1. shell环境配置。
2. brew 环境安装
3. JDK 安装
4. Maven安装.
5. Idea安装.

> 0） 下载此代码库时，如果是新的Mac系统会没有git。 但是mac系统会自动下载 Command Develepment Tools，然后就会有git了。 <br>
> 1） 目前还没有集成安装item2的下载。（日期：2022-11-26）（已完成. 目前使用homebrew进行安装. 安装的版本会比较旧. 如果有更新的需求可以安装后自行在软件内部更新）<br>
> 2） 此脚本推荐使用的是 bash ， 如果 使用的是zsh。那可能有些命令不支持。 <br>


#### 安装教程

1.  下载代码：

```bash
# 下载代码
git clone git@github.com:jianhong-li/macbookpro-env-init.git
# 进入到代码目录 & 执行代码即可 （执行过程有的步骤需要输入sudo密码，即你的管理员密码）
cd macbookpro-env-init && sh ./init_mac_env.sh
```

#### 使用说明

> 0） 下载此代码库时，如果是新的Mac系统会没有git。 但是mac系统会自动下载 Command Develepment Tools，然后就会有git了。 <br>
> 1） 目前还没有集成安装item2的下载。（日期：2022-11-26）（todo: 后面加进来）<br>
> 2） 此脚本推荐使用的是 bash ， 如果 使用的是zsh。那可能有些命令不支持。 <br>
> 3)  shell 相关的颜色配置, 参考了[在 Mac OS X 终端里使用 Solarized 配色方案](https://www.vpsee.com/2013/09/use-the-solarized-color-theme-on-mac-os-x-terminal/),这是我一开始使用mac时就使用的教程,至今已有8年有余.在此表示感谢.
> 4)  Solarized 配色方案仓库为: https://github.com/altercation/solarized , 这是我最喜欢的配色. 感谢作者. (虽然我也想在ubuntu下用上它.似乎他在ubuntu下的方案并不完美.我正在找相应的方案.)

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
