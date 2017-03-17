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

build/game.x11: build/urho3d.x11
	cd game && \
	./cmake_generic.sh ${CURDIR}/build/game.x11 \
	-DURHO3D_SAMPLES=0 -DURHO3D_C++11=1 \
	-DURHO3D_HOME=${CURDIR}/build/urho3d.x11
	$(MAKE) -C build/game.x11
