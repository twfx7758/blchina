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

## 参考资料

- [Using Flutter in China](https://flutter.dev/community/china)
- [Building a web application with Flutter](https://flutter.dev/docs/get-started/web)
- [手把手教你用 Flutter 实现 Web 页面编写](https://www.jianshu.com/p/af764c9d0de1)
- [Flutter 原理与美团的实践](https://www.jianshu.com/p/e6cd8584fdbb)
