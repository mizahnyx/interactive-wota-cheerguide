#!/usr/bin/env python3

import bpy

bpy.ops.wm.open_mainfile(filepath='art/wota-girl/wota-girl.blend')
bpy.context.scene.urho_exportsettings.outputPath = 'game/bin/Data'
bpy.context.scene.urho_exportsettings.derigify = False
bpy.ops.urho.export()
