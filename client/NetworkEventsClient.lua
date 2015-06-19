---------------
-- ## NetworkEvents, cross-module, server<>client communication for JC2MP
--
-- Client class.
--
-- [Github Page](https://github.com/lpiob/jc2mp-NetworkEvents)
--
-- @author Lukasz Biegaj
-- @copyright 2015

class 'NetworkEventsClient'

function NetworkEventsClient:__init()
  Events:Subscribe("NE:Send", self, self.SendHandler)
end

function NetworkEventsClient.SendHandler(self,data)
  -- @todo check if there are registered event handlers in this module
  Network:Send(data.name, data.data)
end

--- Network:Send replacement, that allows the message to be delivered to
-- other module(s). Works by transmitting this as event to all modules 
-- with NetworkEvents script which then retransmit them to server modules
function NetworkEventsClient.Send(self,name,data)
  Events:Fire("NE:Send", {name=name, data=data})
end

function NetworkEventsClient.Subscribe(self, eventName)
  -- inform server modules that we'll be listening for this event
  Network:Send("NE:Subscribe", eventName)
end


NetworkEvents=NetworkEventsClient()
