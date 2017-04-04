-- Static 3D scene example.
-- This sample demonstrates:
--     - Creating a 3D scene with static content
--     - Displaying the scene using the Renderer subsystem
--     - Handling keyboard and mouse input to move a freelook camera

require "LuaScripts/Utilities/Sample"
json = require "json"

browserQueue_ = nil
instructionText_ = nil
ejeCamara_ = nil
roll = 0.0

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

function LoadWotaGirl(nodeName, materialFile, lightstickMaterialFile, lightstickLightMaterialFile)
   local node = scene_:CreateChild(nodeName, materialFile, lightMaterialFile)
   node.position = Vector3(0.0, 0.0, 0.0)
   local object = node:CreateComponent("AnimatedModel")
   object.model = cache:GetResource("Model", "Models/Woman.mdl")
   -- local standAnimation = cache:GetResource("Animation", "Models/Stand.ani")
   -- local state = object:AddAnimationState(standAnimation)
   -- state.weight = 1.0
   -- state.looped = true
   object:SetMaterial(1, cache:GetResource("Material", lightstickLightMaterialFile))
   object:SetMaterial(2, cache:GetResource("Material", "Materials/Hair.xml"))
   object:SetMaterial(3, cache:GetResource("Material", materialFile))
   object:SetMaterial(4, cache:GetResource("Material", lightstickMaterialFile))
   return node, object
end

function CreateScene()
   scene_ = Scene()

   local file = cache:GetFile("Main.xml")
   scene_:LoadXML(file)
   file:delete()

   cameraNode = scene_:GetChild("Camera", true)
   cameraNode:CreateComponent("Camera")

   ejeCamara_ = scene_:GetChild("Eje.Camara", true)

   LoadWotaGirl("WotaGirl", "Materials/Wota.Maimi.xml", "Materials/Lightstick.Maimi.xml", "Materials/LightstickLight.Maimi.xml")
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
   
   -- experimentalNode = scene_:CreateChild("Experimental")
   -- browserQueue_ = experimentalNode:CreateComponent("BrowserQueue")
end

function CreateInstructions()
   -- Construct new Text object, set string to display and font to use
   instructionText_ = ui.root:CreateChild("Text")
   instructionText_:SetText("Use WASD keys and mouse to move")
   instructionText_:SetFont(cache:GetResource("Font", "Fonts/Anonymous Pro.ttf"), 15)

   -- Position the text relative to the screen center
   instructionText_.horizontalAlignment = HA_CENTER
   instructionText_.verticalAlignment = VA_CENTER
   instructionText_:SetPosition(0, ui.root.height / 4)
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
   -- pitch = pitch + MOUSE_SENSITIVITY * mouseMove.y
   -- pitch = Clamp(pitch, -90.0, 90.0)

   -- Construct new orientation for the camera scene node from yaw and pitch. Roll is fixed to zero
   ejeCamara_.rotation = Quaternion(0.0, 0.0, roll)

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
end

function HandleUpdate(eventType, eventData)
   -- Check for BrowserQueue events
   if browserQueue_ ~= nil then
      if browserQueue_:Count() > 0 then
         instructionText_:SetText(browserQueue_:Receive())
      end
   end
   
   -- Take the frame time step, which is stored as a float
   local timeStep = eventData["TimeStep"]:GetFloat()

   -- Move the camera, scale movement with time step
   MoveCamera(timeStep)
end
