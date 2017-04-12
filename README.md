# OpenFire

OpenFire is a real time collaboration server built upon
XMPP protocol. This is a Java software under Apache License.


## Ports exposed

| Port | Description                                                                                                                                                                                                                                                                                                                                                             |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 5222 | The standard port for clients to connect to the server. On this port plain-text connections are established, which, depending on configurable security settings, can (or must) be upgraded to encrypted connections.                                                                                                                                                    |
| 5223 | The port used for clients to connect to the server using the old SSL/TLS method. Connections established on this port are established using a pre-encrypted connection. This type of connectivity is commonly referred to as the "old-style" or "legacy" method of establishing encrypted connections. Configuration details can be modified in the security settings.  |
| 7070 | The port used for unsecured HTTP client connections.                                                                                                                                                                                                                                                                                                                    |
| 7443 | The port used for secured HTTP client connections.                                                                                                                                                                                                                                                                                                                      |
| 5269 | The port used for remote servers to connect to this server. Connections established on this port are established using a pre-encrypted connection. This type of connectivity is commonly referred to as the "old-style" or "legacy" method of establishing encrypted connections. Configuration details can be modified in the security settings.                       |
| 5275 | The port used for external components to connect to the server. On this port plain-text connections are established, which, depending on configurable security settings, can (or must) be upgraded to encrypted connections.                                                                                                                                            |
| 5276 | The port used for external components to the server using the old SSL/TLS method. Connections established on this port are established using a pre-encrypted connection. This type of connectivity is commonly referred to as the "old-style" or "legacy" method of establishing encrypted connections. Configuration details can be modified in the security settings. |
| 5262 | The port used for connection managers to connect to the server. On this port plain-text connections are established, which, depending on configurable security settings, can (or must) be upgraded to encrypted connections.                                                                                                                                            |
| 5263 | The port used for connection managers to the server using the old SSL/TLS method. Connections established on this port are established using a pre-encrypted connection. This type of connectivity is commonly referred to as the "old-style" or "legacy" method of establishing encrypted connections. Configuration details can be modified in the security settings. |
| 9090 | The port used for unsecured Admin Console access.                                                                                                                                                                                                                                                                                                                       |
| 9091 | The port used for secured Admin Console access.                                                                                                                                                                                                                                                                                                                         |
| 7777 | The port used for the proxy service that allows file transfers to occur between two entities on the XMPP network.                                                                                                                                                                                                                                                       |
| 5229 | Service that allows Flash clients connect to other hostnames and ports.                                                                                                                                                                                                                                                                                                 |


## How to use

Please, read OpenFire documentation to figure out ports
you need to publish to make your container useful.

The example below publish ports to let us use the web
administration interface (9090), bosh connections (7070),
and the standard port used by xmpp clients (5222).


```
docker run -p 9090:9090 -p 7070:7070 -p 5222:5222 montefuscolo/openfire
```

