# Envoy Filter

## libevent监听网络事件

- accept
- connect
- read
- write
- 以上都由eventloop进行callback触发

## Listener Filter

    ```yaml config
    listeners:
    - address:
        socket_address:
        address: 0.0.0.0
        port_value: 8888
      listener_filters:
        - name: envoy.filters.listener.proxy_protocol
        - name: envoy.filters.listener.original_src
        typed_config:
            "@type": type.googleapis.com/envoy.config.filter.listener.original_src.v2alpha1.OriginalSrc
            mark: 123
    ```

- envoy.filters.listener.http_inspector
- envoy.filters.listener.original_dst
- envoy.filters.listener.original_src
- envoy.filters.listener.proxy_protocol
- envoy.filters.listener.tls_inspector

## Network Filter

## Http Filter

## Other Filter

## 参考资料

- [小鸟笔记](https://www.lijiaocn.com/soft/envoy/listener-filter.html)
