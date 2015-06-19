class 'NetworkEventsClient'

function NetworkEventsClient:__init()
  Events:Subscribe("NE:Send", self, self.SendHandler)
end

function NetworkEventsClient.SendHandler(self,data)
  -- @todo check if there are registered event handlers in this module
  Network:Send(data.name, data.data)
end

function NetworkEventsClient.Send(self,name,data)
  -- @todo check if there are registered event handlers
  -- send to other modules, server-side
  Events:Fire("NE:Send", {name=name, data=data})
end

function NetworkEventsClient.Subscribe(self, eventName)
  -- inform server modules that we'll be listening for this event
  Network:Send("NE:Subscribe", eventName)
end


NetworkEvents=NetworkEventsClient()
