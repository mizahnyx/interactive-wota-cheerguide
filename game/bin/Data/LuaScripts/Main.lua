-- Static 3D scene example.
-- This sample demonstrates:
--     - Creating a 3D scene with static content
--     - Displaying the scene using the Renderer subsystem
--     - Handling keyboard and mouse input to move a freelook camera

require "LuaScripts/Utilities/Sample"
json = require "LuaScripts/json"

browserQueue_ = nil
ejeCamara_ = nil
instructionText_ = nil
roll = 0.0

textTime_ = 0.0
textDuration_ = 0.0

wotaGirlsData_ = {}
wotaGirlsData_["maimi"] = {
   Vector3(1.0, 0.0, 0.0);
   "Materials/Wota.Maimi.xml";
   "Materials/Lightstick.Maimi.xml";
   "Materials/LightstickLight.Maimi.xml"
}
wotaGirlsData_["nacky"] = {
   Vector3(-1.0, 0.0, 0.0);
   "Materials/Wota.Nacky.xml";
   "Materials/Lightstick.Nacky.xml";
   "Materials/LightstickLight.Nacky.xml"
}
wotaGirlsData_["airi"] = {
   Vector3(0.0, 0.0, 0.0);
   "Materials/Wota.Airi.xml";
   "Materials/Lightstick.Airi.xml";
   "Materials/LightstickLight.Airi.xml"
}
wotaGirlsData_["chisato"] = {
   Vector3(2.0, 0.0, 0.0);
   "Materials/Wota.Chisato.xml";
   "Materials/Lightstick.Chisato.xml";
   "Materials/LightstickLight.Chisato.xml"
}
wotaGirlsData_["maimai"] = {
   Vector3(-2.0, 0.0, 0.0);
   "Materials/Wota.MaiMai.xml";
   "Materials/Lightstick.MaiMai.xml";
   "Materials/LightstickLight.MaiMai.xml"
}

function Start()
   -- Execute the common startup for samples
   SampleStart()

   -- Create the scene content
   CreateScene()

   -- Create the UI content
   CreateInstructions()

   -- Setup the viewport for displaying the scene
   SetupViewport()

   -- Set the mouse mode to use in the sample
   SampleInitMouseMode(MM_RELATIVE)

   -- Hook up to the frame update events
   SubscribeToEvents()
end

function LoadWotaGirls()
   index = 1
   for i,v in next, wotaGirlsData_ do
      local node = scene_:CreateChild("WotaGirl."..i)
      node.position = v[1]
      local object = node:CreateComponent("AnimatedModel")
      object.model = cache:GetResource("Model", "Models/Woman.mdl")
      object.castShadows = true

      object:SetMaterial(0, cache:GetResource("Material", v[3]))
      object:SetMaterial(1, cache:GetResource("Material", v[4]))
      object:SetMaterial(2, cache:GetResource("Material", "Materials/Hair.xml"))
      object:SetMaterial(3, cache:GetResource("Material", v[2]))
      node:CreateComponent("AnimationController")
      local wotaGirl = node:CreateScriptObject("WotaGirl")
      wotaGirl.index = index
      index = index*2
   end
end

function CreateScene()
   scene_ = Scene()

   local file = cache:GetFile("Main.xml")
   scene_:LoadXML(file)
   file:delete()

   cameraNode = scene_:GetChild("Camera", true)
   cameraNode:CreateComponent("Camera")

   ejeCamara_ = scene_:GetChild("Eje.Camara", true)

   LoadWotaGirls()
   

   -- local wotaNode = nil
   -- local wotaObject = nil
   -- wotaNode, wotaObject =
   --    LoadWotaGirl("WotaGirl",
   --                 "Materials/Wota.Maimi.xml",
   --                 "Materials/Lightstick.Maimi.xml",
   --                 "Materials/LightstickLight.Maimi.xml")
   -- local standAnimation = cache:GetResource("Animation", "Models/Stand.ani")
   -- local state = wotaObject:AddAnimationState(standAnimation)
   -- state.weight = 1.0
   -- state.looped = true
   -- cameraNode:LookAt(Vector3(0.0, 0.0, 1.0))
      -- Create a child scene node (at world origin) and a StaticModel component into it. Set the StaticModel to show a simple
      -- plane mesh with a "stone" material. Note that naming the scene nodes is optional. Scale the scene node larger
      -- (100 x 100 world units)
   -- local wotaGirlNode = scene_:CreateChild("WotaGirl")
   -- wotaGirlNode.position = Vector3(0.0, 0.0, 0.0)
   -- local wotaGirlObject = wotaGirlNode:CreateComponent("AnimatedModel")
   -- wotaGirlObject.model = cache:GetResource("Model", "Models/Woman.mdl")
   -- local standAnimation = cache:GetResource("Animation", "Models/Stand.ani")
   -- local state = wotaGirlObject:AddAnimationState(standAnimation)
   -- state.weight = 1.0
   -- state.looped = true
   -- wotaGirlObject:SetMaterial(1, cache:GetResource("Material", "Materials/Lightstick Light.xml"))
   -- wotaGirlObject:SetMaterial(2, cache:GetResource("Material", "Materials/Hair.xml"))
   -- wotaGirlObject:SetMaterial(3, cache:GetResource("Material", "Materials/Woman.xml"))
   -- wotaGirlObject:SetMaterial(4, cache:GetResource("Material", "Materials/Lightstick.xml"))

   -- Create a directional light to the world so that we can see something. The light scene node's orientation controls the
   -- light direction we will use the SetDirection() function which calculates the orientation from a forward direction vector.
   -- The light will use default settings (white light, no shadows)
   -- local lightNode = scene_:CreateChild("DirectionalLight")
   -- lightNode.direction = Vector3(0.6, -1.0, 0.8) -- The direction vector does not need to be normalized
   -- local light = lightNode:CreateComponent("Light")
   -- light.lightType = LIGHT_DIRECTIONAL

   -- Create a scene node for the camera, which we will move around
   -- The camera will use default settings (1000 far clip distance, 45 degrees FOV, set aspect ratio automatically)
   -- cameraNode = scene_:CreateChild("Camera")
   -- local camera = cameraNode:CreateComponent("Camera")

   -- Set an initial position for the camera scene node above the plane
   -- cameraNode.position = Vector3(0.0, 0.75, -5.0)
   -- cameraNode:LookAt(Vector3(0.0, 0.0, 0.0))
   
   local browserQueueNode = scene_:CreateChild("Experimental")
   local browserQueue = browserQueueNode:CreateComponent("BrowserQueue")
   browserQueueNode:CreateScriptObject("BrowserQueue")
   -- Señalizar al navegador que el motor de juegos ha cargado
   browserQueue:Send("cargado")
end

function CreateInstructions()
   -- Construct new Text object, set string to display and font to use
   instructionText_ = ui.root:CreateChild("Text")
   instructionText_:SetFont(cache:GetResource("Font", "Fonts/Anonymous Pro.ttf"), 15)

   -- Position the text relative to the screen center
   instructionText_.horizontalAlignment = HA_CENTER
   instructionText_.verticalAlignment = VA_TOP
   instructionText_:SetPosition(0, 0)
   instructionText_:SetSize(ui.root.width, ui.root.height)
end

function SetupViewport()
   -- Set up a viewport to the Renderer subsystem so that the 3D scene can be seen. We need to define the scene and the camera
   -- at minimum. Additionally we could configure the viewport screen size and the rendering path (eg. forward / deferred) to
   -- use, but now we just use full screen and default render path configured in the engine command line options
   local viewport = Viewport:new(scene_, cameraNode:GetComponent("Camera"))
   renderer:SetViewport(0, viewport)
end

function MoveCamera(timeStep)
   -- Do not move if the UI has a focused element (the console)
   if ui.focusElement ~= nil then
      return
   end

   -- Movement speed as world units per second
   local MOVE_SPEED = 20.0
   -- Mouse sensitivity as degrees per pixel
   local MOUSE_SENSITIVITY = 0.1

   -- Use this frame's mouse motion to adjust camera node yaw and pitch. Clamp the pitch between -90 and 90 degrees
   local mouseMove = input.mouseMove
   roll = roll + MOUSE_SENSITIVITY * mouseMove.x
   pitch = pitch + MOUSE_SENSITIVITY * mouseMove.y
   pitch = Clamp(pitch, -30.0, 30.0)
   -- pitch = Clamp(pitch, -90.0, 90.0)

   -- Construct new orientation for the camera scene node from yaw and pitch. Roll is fixed to zero
   ejeCamara_.rotation = Quaternion(pitch, 0.0, roll)

   -- Read WASD keys and move the camera scene node to the corresponding direction if they are pressed
   -- Use the Translate() function (default local space) to move relative to the node's orientation.
   -- if input:GetKeyDown(KEY_W) then
   --    cameraNode:Translate(Vector3(0.0, 0.0, 1.0) * MOVE_SPEED * timeStep)
   -- end
   -- if input:GetKeyDown(KEY_S) then
   --    cameraNode:Translate(Vector3(0.0, 0.0, -1.0) * MOVE_SPEED * timeStep)
   -- end
   if input:GetKeyDown(KEY_A) then
      ejeCamara_:Roll(-1.0 * MOVE_SPEED * timeStep)
   end
   if input:GetKeyDown(KEY_D) then
      ejeCamara_:Roll(1.0 * MOVE_SPEED * timeStep)
   end
end

function SubscribeToEvents()
   -- Subscribe HandleUpdate() function for processing update events
   SubscribeToEvent("Update", "HandleUpdate")
   SubscribeToEvent("Text", "HandleText")
   SubscribeToEvent("Audio", "HandleAudio")
end

function HandleUpdate(eventType, eventData)
   -- Take the frame time step, which is stored as a float
   local timeStep = eventData["TimeStep"]:GetFloat()

   -- Move the camera, scale movement with time step
   MoveCamera(timeStep)
   
   UpdateText(timeStep)
end

function UpdateText(timeStep)
   if textTime_ < textDuration_ then
      textTime_ = textTime_ + timeStep
   else
      if instructionText_ ~= nil then
         instructionText_:SetText("")
      end
   end
end

function HandleText(eventType, eventData)
   if eventData["Who"] ~= nil then
      local who = eventData["Who"]:GetString()
      if who == "Maimi" then
         instructionText_.color = Color(1.0, 0.0, 0.0)
      elseif who == "Nacky" then
         instructionText_.color = Color(0.16, 0.16, 1.0)
      elseif who == "Airi" then
         instructionText_.color = Color(1.0, 0.16, 0.5)
      elseif who == "Chisato" then
         instructionText_.color = Color(0.0, 0.67, 0.0)
      elseif who == "MaiMai" then
         instructionText_.color = Color(1.0, 0.8, 0.0)
      end
   else
      instructionText_.color = Color(1.0, 1.0, 1.0)
   end
   instructionText_.text = eventData["Text"]:GetString()
   textTime_ = 0.0
   textDuration_ = eventData["Duration"]:GetFloat()
end

function HandleAudio(eventType, eventData)
   local soundFile = "Audio/"..eventData["Audio"]:GetString()..".ogg"
   local sound = cache:GetResource("Sound", soundFile)
   local soundSource = scene_:CreateComponent("SoundSource")
   soundSource.soundType = SOUND_EFFECT
   soundSource:SetAutoRemoveMode(REMOVE_COMPONENT)
   soundSource:Play(sound)
end

WotaGirl = ScriptObject()

function WotaGirl:Start()
   local animationController = self.node:GetComponent("AnimationController", true)
   animationController:PlayExclusive("Models/Stand.ani", 0, true)

   self.time = 0.0
   self.stopTime = 0.0
   self.playing = false
   
   self:SubscribeToEvent("Furi", "WotaGirl:HandleFuri")
   self:SubscribeToEvent(self.node, "AnimationTrigger", "WotaGirl:HandleAnimationTrigger")
end

function WotaGirl:HandleFuri(eventType, eventData)
   local animationController = self.node:GetComponent("AnimationController", true)
   local animation = "Models/"..eventData["Furi"]:GetString()..".ani"
   local animationData = cache:GetResource("Animation", animation)
      
   animationController:PlayExclusive(animation, 0, true, 0.25)
   animationController:SetSpeed(animation,
      animationData:GetLength() / eventData["Duration"]:GetFloat())
      
   self.time = 0.0
   self.stopTime = eventData["Duration"]:GetFloat()*eventData["Times"]:GetFloat()
   self.playing = true
end

function WotaGirl:FixedUpdate(timeStep)
   local animationController = self.node:GetComponent("AnimationController", true)
   
   if self.playing then
      self.time = self.time + timeStep
      if self.time >= self.stopTime then
         self.time = 0.0
         self.stopTime = 0.0
         self.playing = false
         animationController:PlayExclusive("Models/Stand.ani", 0, true, 0.25)
      end
   end
end

function WotaGirl:HandleAnimationTrigger(eventType, eventData)
   local animationController = self.node:GetComponent("AnimationController", true)
   if eventData["type"] == "counter" then
      print("counter: "..tostring(self.counter))
      
      self.counter = self.counter + 1
      if self.counter >= self.times then
         self.counter = 0
         animationController:PlayExclusive("Models/Stand.ani", 0, true, 0.5)
      end
   end
end

BrowserQueue = ScriptObject()

function BrowserQueue:Start()
   self.time = 0.0
   self.COMMAND = {
      PAUSE = 1,
      PLAY = 2,
      SCRIPT = 3
   }
   self.debugEnabled = true
   self.playing = false
   self.eventScript = {}
end

function BrowserQueue:ProcessCommand(command)
   if command[1] == self.COMMAND.PAUSE then
      self.playing = false
   elseif command[1] == self.COMMAND.PLAY then
      self.playing = true
   elseif command[1] == self.COMMAND.SCRIPT then
      self.playing = false
      self.time = 0.0
      self.eventScript = {}
      
      for i,v in ipairs(command[2]) do
         local timeStamp = v[1]
         local eventType = v[2]
         local eventData = v[3]
         local vm = VariantMap()
         for i2,v2 in next, eventData do
            if i2 == "Color" then
               vm[i2] = Color(i2[1], i2[2], i2[3])
            else
               vm[i2] = v2
            end
         end
         local item = {
            time = timeStamp;
            eventType = eventType;
            eventData = vm;
            flag = false
         }
         table.insert(self.eventScript, item)
      end
   end
end

function BrowserQueue:FixedUpdate(timeStep)
   -- local timestamp = Time:GetElapsedTime()
   -- if not self.pause then
   --    self.elapsed = self.elapsed + (timestamp - self.timestamp)
   --    local eventData = VariantMap()
   --    eventData["Text"] = tostring(self.elapsed)
   --    self.node:SendEvent("SetInstructionText", eventData)
   -- end
   
   local browserQueue = self.node:GetComponent("BrowserQueue", true)
   
   if browserQueue ~= nil then
      if browserQueue:Count() > 0 then
         local commandString = tostring(browserQueue:Receive())
         if self.debugEnabled then	
            print(commandString)
         end
         local command = json.parse(commandString)
         self:ProcessCommand(command)
      end
   end

   if self.playing then
      self.time = self.time + timeStep
   end

   for i,v in ipairs(self.eventScript) do
      if self.time > v.time and v.flag == false then
         self.node:SendEvent(v.eventType, v.eventData)
         v.flag = true 
      end
   end

   -- self.timestamp = timestamp
end
