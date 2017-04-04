.PHONY: clean

clean:
	rm -rf build

build/urho3d.x11:
	cd ${CURDIR}/submodule/Urho3D && \
	./cmake_generic.sh ${CURDIR}/build/urho3d.x11 \
	-DURHO3D_SAMPLES=0 -DURHO3D_C++11=1
	$(MAKE) -C build/urho3d.x11

build/urho3d.emscripten:
	cd ${CURDIR}/submodule/Urho3D && \
	./cmake_emscripten.sh ${CURDIR}/build/urho3d.emscripten \
	-DURHO3D_SAMPLES=0 -DURHO3D_C++11=1
	$(MAKE) -C build/urho3d.emscripten

build/game.emscripten: build/urho3d.emscripten
	cd game && \
	./cmake_emscripten.sh ${CURDIR}/build/game.emscripten \
	-DURHO3D_SAMPLES=0 -DURHO3D_C++11=1 \
	-DURHO3D_HOME=${CURDIR}/build/urho3d.emscripten
	$(MAKE) -C build/game.emscripten

build/game.x11: build/urho3d.x11 build/game.data
	cd game && \
	./cmake_generic.sh ${CURDIR}/build/game.x11 \
	-DURHO3D_SAMPLES=0 -DURHO3D_C++11=1 \
	-DURHO3D_HOME=${CURDIR}/build/urho3d.x11
	$(MAKE) -C build/game.x11

build/game.data:
	blender -b -P export-scripts/export_assets.py
	./build/urho3d.x11/bin/tool/AssetImporter scene \
	  art/scene/scene.blend \
	  game/bin/Data/Main.xml
	cat game/bin/Data/Materials/Woman.xml \
	  | sed -e s#wota-girl.body.maimi.png#wota-girl.body.maimi.png# > \
	  game/bin/Data/Materials/Wota.Maimi.xml 
	cat game/bin/Data/Materials/Woman.xml \
	  | sed -e s#wota-girl.body.maimi.png#wota-girl.body.nacky.png# > \
	  game/bin/Data/Materials/Wota.Nacky.xml 
	cat game/bin/Data/Materials/Woman.xml \
	  | sed -e s#wota-girl.body.maimi.png#wota-girl.body.airi.png# > \
	  game/bin/Data/Materials/Wota.Airi.xml 
	cat game/bin/Data/Materials/Woman.xml \
	  | sed -e s#wota-girl.body.maimi.png#wota-girl.body.chisato.png# > \
	  game/bin/Data/Materials/Wota.Chisato.xml 
	cat game/bin/Data/Materials/Woman.xml \
	  | sed -e s#wota-girl.body.maimi.png#wota-girl.body.maimai.png# > \
	  game/bin/Data/Materials/Wota.MaiMai.xml
	cat game/bin/Data/Materials/Lightstick.xml \
	  | sed -e s#Lightstick.png#lightstick.maimi.png# > \
	  game/bin/Data/Materials/Lightstick.Maimi.xml 
	cat game/bin/Data/Materials/Lightstick.xml \
	  | sed -e s#Lightstick.png#lightstick.nacky.png# > \
	  game/bin/Data/Materials/Lightstick.Nacky.xml 
	cat game/bin/Data/Materials/Lightstick.xml \
	  | sed -e s#Lightstick.png#lightstick.airi.png# > \
	  game/bin/Data/Materials/Lightstick.Airi.xml 
	cat game/bin/Data/Materials/Lightstick.xml \
	  | sed -e s#Lightstick.png#lightstick.chisato.png# > \
	  game/bin/Data/Materials/Lightstick.Chisato.xml 
	cat game/bin/Data/Materials/Lightstick.xml \
	  | sed -e s#Lightstick.png#lightstick.maimai.png# > \
	  game/bin/Data/Materials/Lightstick.MaiMai.xml
	cp art/wota-girl/*.png game/bin/Data/Textures
	cat game/bin/Data/Materials/Lightstick.Maimi.xml \
	  | sed -e s#Diff.xml#DiffEmissive.xml# > \
	  game/bin/Data/Materials/LightstickLight.Maimi.xml 
	cat game/bin/Data/Materials/Lightstick.Nacky.xml \
	  | sed -e s#Diff.xml#DiffEmissive.xml# > \
	  game/bin/Data/Materials/LightstickLight.Nacky.xml 
	cat game/bin/Data/Materials/Lightstick.Airi.xml \
	  | sed -e s#Diff.xml#DiffEmissive.xml# > \
	  game/bin/Data/Materials/LightstickLight.Airi.xml 
	cat game/bin/Data/Materials/Lightstick.Chisato.xml \
	  | sed -e s#Diff.xml#DiffEmissive.xml# > \
	  game/bin/Data/Materials/LightstickLight.Chisato.xml 
	cat game/bin/Data/Materials/Lightstick.MaiMai.xml \
	  | sed -e s#Diff.xml#DiffEmissive.xml# > \
	  game/bin/Data/Materials/LightstickLight.MaiMai.xml 


