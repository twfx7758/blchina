# Envoy 源码研究

## win10 下开发 envoy

### 配置流程

- win10 启动 wsl 子系统
- windows store 下载安装 ubuntu 最新版

  - 第一次启动初始化工作：设置用户名、密码，成功登入后可以设置 root 密码，root 默认是没有密码的直接 sudo su 即可进入 root 用户，然后通过 sudo passwd root 设置 root 密码
  - 在 cmd 或者 power shell 做常规设置（管理员权限运行）

    - 设置 bash、wsl 启动的默认 linux 系统：wslconfig /setdefault [Linux_System_name(我这里是 Ubuntu)]
    - 程序所在目录：C:\Users\twfx7\AppData\Local\Microsoft\WindowsApps\ubuntu1804.exe
    - 还有一些 wslconfig 的命令比如：
      - 卸载：wslconfig /unregister [Linux_System_name(我这里是 Ubuntu)
      - 查看已经安装的系统列表：wslconfig /list
    - 设置 bash、wsl 默认登入的用户（这个还有配合默认系统系统，我这边安装的 ubuntu1804 所以命令开头是 ubuntu1804）:ubuntu1804 config --default-user root

  - apt update && apt upgrade 更新系统
  - 下载 gcc/g++ 4.8

    - apt install gcc-4.8
    - apt install g++-4.8
    - 再做一下软链接

      ```软链接
      cd /usr/bin
      ln -s gcc-4.8 gcc
      ln -s g++-4.8 g++
      ln -s gcc-4.8 cc
      ln -s g++-4.8 c++
      ```

  - 升级 CMake

    ```升级CMake
    sudo apt-get install build-essential
    wget http://www.cmake.org/files/v3.4/cmake-3.4.1.tar.gz
    tar xf cmake-3.4.1.tar.gz
    cd cmake-3.4.1
    ./configure
    make
    ```

## C++编译知识

- 原文件—cmakelist —cmake —makefile —make —生成可执行文件
- #include引用红线解决方案
  - 命令：gcc -v -E -x c++ - 查出include列表
  - 然后放入：c_cpp_properties.json文件的includePath内，例如：

    ```includePath
    "includePath": [
                  "${workspaceFolder}/**",
                  "/usr/include/c++/7",
                  "/usr/include/x86_64-linux-gnu/c++/7",
                  "/usr/include/c++/7/backward",
                  "/usr/lib/gcc/x86_64-linux-gnu/7/include",
                  "/usr/local/include",
                  "/usr/lib/gcc/x86_64-linux-gnu/7/include-fixed",
                  "/usr/include/x86_64-linux-gnu",
                  "/usr/include"
              ],
    ```

## 源码分析

- 修改 git 的代理

  - 打开本地代理 shadowsocks
  - 设置
    - 方案 1:
      - git config --global http.proxy socks5://127.0.0.1:1080
      - git config --global https.proxy socks5://127.0.0.1:1080
  - 取消
    - git config --global --unset http.proxy
    - git config --global --unset https.proxy

- bazellist 安装

  - wget -e "http_proxy=socks5://127.0.0.1:1080" http://www.subversion.org.cn/svnbook/1.4/ -O /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v0.0.8/bazelisk-linux-amd64
  - chmod +x /usr/local/bin/bazel

- 命令行解析库-tclap

- envoy 启动命令

  - bazel clean --expunge

  - bazel build //source/exe:envoy-static

  - 生成的静态文件路径
    - //bazel-out/k8-fastbuild/source/exe/envoy-static

- libevent

- fd buf

  - 文件描述符 缓存区

- std::function<Layer\*()>

  - 代表一个可调用对象，接收 0 个参数，返回 Layer\*

- int(\*)(int, int)

  - 函数指针

- int \*add(int a, int b)

  - 指针函数

### 常用类及类库

- MainCommon 类

  - envoy 程序的入口

    - 初始化 MainCommonBase 及 OptionsImpl 对象

- options_impl 类
  - spdlog
    - [spdlog 介绍](https://visualgmq.github.io/2019/08/09/%E5%8D%81%E5%88%86%E5%A5%BD%E7%94%A8%E7%9A%84spdlog%E6%97%A5%E5%BF%97%E5%BA%93/)
  - tclap
    - c++的命令行解析库
    - [tclap 解析](http://tclap.sourceforge.net/)

### 功能模块

- Dispatcher
  - libevent
- ThreadLocal
- Listener
  - ActiveListener
    - ConnectionHandler
- filter
- grpc
- event

## 参考资料

- [Istio Pilot 与 Envoy 的交互机制解读](https://blog.gmem.cc/interaction-between-istio-pilot-and-envoy)
- [深入解读 Service Mesh 的数据面 Envoy](https://sq.163yun.com/blog/article/213361303062011904?utm_source=tuicool&utm_medium=referral)
- [Envoy 学习笔记-齐全](https://blog.gmem.cc/envoy-study-note)
- [小鸟笔记](https://www.lijiaocn.com/soft/envoy/)
- [win10 使用 WSL 编译 Linux C++项目](https://cloud.tencent.com/developer/article/1360467)
- [Building Envoy with Bazel](https://github.com/envoyproxy/envoy/blob/master/bazel/README.md#installing-bazelisk-as-bazel)
- [Ubuntu14.04 默认 cmake 升级为 3.x](http://www.mamicode.com/info-detail-2197817.html)
- [如何在 Ubuntu 18.04 上安装 GCC 编译器](https://www.linuxidc.com/Linux/2019-06/159059.htm)
- [Building Envoy with Bazel](https://github.com/envoyproxy/envoy/blob/master/bazel/README.md#quick-start-bazel-build-for-developers)
- [Envoy 源码分析之 Dispatcher](https://blog.csdn.net/zhangyifei216/article/details/83651131)
- [Effective Modern C++解读](https://blog.csdn.net/zhangyifei216/article/category/9266963/2)
- [【Envoy 源码解析（一）】Envoy 启动](https://blog.csdn.net/surlymo/article/details/82191875)
- [Envoy 中的 xDS REST 和 gRPC 协议详解](https://juejin.im/post/5baedb6f5188255c38536f58)
- [WebAssembly在Istio中做Header Filter的示例](https://developer.aliyun.com/article/752771)
