# flowable

## docker部署

```deployment
nohup docker run -p 8080:8080 flowable/all-in-one &
```

## 项目build

```build
./mvnw clean package -DskipTests -Pdeploy -Dmaven.javadoc.skip=true -Dgpg.skip
./mvnw clean install -DskipTests -Pdeploy -Dmaven.javadoc.skip=true -Dgpg.skip
```

## 管理地址

- [flowable-idm](http://192.168.186.23:8080/flowable-idm)
- [flowable-modeler](http://192.168.186.23:8080/flowable-modeler)
- [flowable-task](http://192.168.186.23:8080/flowable-task)
- [flowable-admin](http://192.168.186.23:8080/flowable-admin)
- [flowable-rest](http://192.168.186.23:8080/flowable-rest/docs)

## 参考资料

- [Flowable框架](https://www.jianshu.com/p/63bf76bda4ec)
- [Flowable-Modeler集成](https://blog.csdn.net/houyj1986/article/details/86027301)
- [基于Groovy的规则脚本引擎实战](https://juejin.im/post/6844903682639659015?utm_source=gold_browser_extension)
