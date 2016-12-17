#! /bin/bash
rm -rf build.err build.log
valac -gv \
        --disable-warnings \
	-o bin/LAIR --vapidir="src/vapi" \
	--pkg gio-2.0 \
	--pkg sdl2 \
	--pkg sdl2-gfx \
	--pkg sdl2-image \
	--pkg sdl2-ttf \
	--pkg sdl2-mixer \
        -X "-FPIC -pie" \
	-X -lSDL2 \
	-X -lSDL2_gfx \
	-X -lSDL2_image \
	-X -lSDL2_ttf \
	-X -lSDL2_mixer \
	src/main.vala \
	src/resmanage/files.vala \
	src/resmanage/images.vala \
	src/resmanage/filedb.vala \
	src/resmanage/fonts.vala \
	src/resmanage/sounds.vala \
	src/game/room.vala \
	src/game/floor.vala \
	src/game/tower.vala \
	src/game/game.vala \
	src/entity/type.vala \
	src/entity/sprite.vala \
	src/entity/anim.vala \
	src/entity/text.vala \
	src/entity/sound.vala \
	src/entity/net.vala \
	src/entity/stats.vala \
	src/entity/inventory.vala \
	src/entity/move.vala \
	src/entity/entity.vala \
	> >(tee -a "build.log") 2> >(tee -a "build.err" >&2)
