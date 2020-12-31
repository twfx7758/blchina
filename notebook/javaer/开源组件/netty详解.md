# Netty

## netty 知识点汇总

- bytebuf 详解

  - 操作细节

    - readindex
    - writeindex
    - flush

  - 分配区域
    - 堆外内存
    - 堆内内存
  - 内存管理
    - 池化管理
      - Arena
      - Page
    - 非池化管理

- Channel 详解

  - SocketChannel
  - ServerSocketChannel

- EventLoop 与 EventLoopGroup 详解

  - 线程模型

- ChannelPipeline 与 ChannelHandler 详解

  ![avatar](./img/netty/ChannelHandler.jpg)

- Future 与 Promise 详解

- Bootstrap 与 ServerBootstrap 详解

- 参考资料
  - [自顶向下深入分析 Netty](https://www.jianshu.com/p/92c5092c5d3f)
  - [Netty 源码分析系列](https://segmentfault.com/a/1190000007282628)
  - [Related articles](https://netty.io/wiki/related-articles.html)
