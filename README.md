# jc2mp-NetworkEvents

[JC2MP](http://wiki.jc-mp.com/Main_Page) provides a ways to perform server-client communication (i.e. using [Network](http://wiki.jc-mp.com/Lua/Shared/Network) class), and cross-module communication (i.e. using [Events](http://wiki.jc-mp.com/Lua/Shared/Events)).

Unfortunately, neither Networks can be used beetween modules, nor Events between server and client sides.

This class implements a bridge between those two classes, allowing cross-module and server-client communication.

Additionaly, NetworkEvents keeps track which submodules handle which events to not flood clients with unnecessary data.

Installation
-----------

Drop `client/NetworkEventsClient.lua` and `server/NetworkEvents.lua` to every module that needs to take part in communication. Both classes will be available as `NetworkEvents` instance on both sides.

Usage
-----------

Client-side: registering sample handler and allowing it to receive communication from other modules:
```
NetworkEvents:Subscribe("SampleHandler")
Network:Subscribe("SampleHandler", function(args)
 print("...")
end)
````

Server-side: sending broadcast event to every player and every module that handles this event:
```
NetworkEvents:Broadcast("SampleHandler", "w0t")
```



