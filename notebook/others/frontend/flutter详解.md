# flutter

## 常用命令

- flutter get
- flutter doctor
- flutter run -d chrome
- flutter build web

## 打包

- 问题

  - flutter build apk 安装release 运行闪退
    - 解决：flutter build apk --no-shrink
    - 原因：flutter build apk默认会开启R8压缩，flutter run --release没有，所以出错

  - AndroidX问题
    - 解决：build.gradle->targetSdkVersion 28->compileSdkVersion 28

  - android打包

    ```android
    maven { url 'https://maven.aliyun.com/repository/google' }
    maven { url 'https://maven.aliyun.com/repository/jcenter' }
    maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    ```

- ios打包

  ```ios
  1、flutter build ios --release
  2、再到xcode里打包，生成ipa
  ```

## 第三方包

- 2d动画

  - flare
    - 用途：主要是设计矢量动画图形库，更偏向于App和Web使用。
  - nima
    - 用途：主要是光栅图形制作二维角色的动画，可以添加贴图和栅格操作，常用于游戏，可以创建非常炫酷的人物。

- 游戏引擎

  - flame
    - 用途：轻量级2d游戏引擎

## 参考资料

- [Using Flutter in China](https://flutter.dev/community/china)
- [Building a web application with Flutter](https://flutter.dev/docs/get-started/web)
- [手把手教你用 Flutter 实现 Web 页面编写](https://www.jianshu.com/p/af764c9d0de1)
- [Flutter 原理与美团的实践](https://www.jianshu.com/p/e6cd8584fdbb)
- [flare nima](https://rive.app)
