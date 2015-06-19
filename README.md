# jc2mp-NetworkEvents

[JC2MP](http://wiki.jc-mp.com/Main_Page) provides a ways to perform server-client communication (i.e. using [Network](http://wiki.jc-mp.com/Lua/Shared/Network) class), and cross-module communication (i.e. using [Events](http://wiki.jc-mp.com/Lua/Shared/Events)).

Unfortunately, neither Networks can be used beetween modules, nor Events between server and client sides.

This class implements a bridge between those two classes, allowing cross-module and server-client communication.

Additionaly, NetworkEvents keeps track which submodules handle which events to not flood clients with unnecessary data.

## Installation

Drop `client/NetworkEventsClient.lua` and `server/NetworkEvents.lua` to every module that needs to take part in communication. Both classes will be available as `NetworkEvents` instance on both sides.

## Usage
### Broadcasts event from server to all clients designated module(s)
Server-side:
```
NetworkEvents:Broadcast("EventName", data)
```

Client-side: register handler as usual, and mark it as allowed to receive events from other modules:
```
NetworkEvents:Subscribe("EventName")
Network:Subscribe("EventName", function(args)
 print("...")
end)
````

Data flow: server -> event to other modules => Network:event to designated client-side handler(s)

### Send event from server to specified clients designated module(s)
Server-side:
```
NetworkEvents:Send(player, "EventName", "data")
```

Client-side: same as above

Data flow: server -> event to other modules => Network::event to designated client-side handler(s)

### Send event from client to designated modules on server:

TBD - WIP

Client-side:
```
NetworkEvents:Send("EventName", data)
```

Server-side:
```
NetworkEvents:Subscribe("EventName") -- register current module as willing to accept events from other modules
Network:Subscribe("EventName", function(....
```

Data flow: client -> event to other modules => Network::event to designated server-side handler(s)

