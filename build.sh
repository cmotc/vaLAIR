#! /bin/bash
rm -rf build.err build.log
valac -gv --save-temps \
	-o bin/LAIR --vapidir="src/vapi" \
	--pkg gio-2.0 \
	--pkg sdl2 \
	--pkg sdl2-gfx \
	--pkg sdl2-image \
	--pkg sdl2-ttf \
	--pkg sdl2-mixer \
	-X -lSDL2 \
	-X -lSDL2_gfx \
	-X -lSDL2_image \
	-X -lSDL2_ttf \
	-X -lSDL2_mixer \
	src/main.vala \
	src/resmanage/files.vala \
	src/resmanage/images.vala \
	src/resmanage/filedb.vala \
	> >(tee -a "build.log") 2> >(tee -a "build.err" >&2)
	
	#
	#src/resmanage/fonts.vala \
	#src/resmanage/sounds.vala \
	#src/entity/*.vala src/game/*.vala \