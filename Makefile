unix:
	valac -gv \
		-o bin/LAIR \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -Og \
		-X -g3 \
		-X -ggdb \
		-X -llua5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
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
		src/entity/stats.vala \
		src/entity/inventory.vala \
		src/entity/move.vala \
		src/entity/entity.vala

android:
	valac -gv \
		-o bin/LAIR \
		--disable-warnings \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -llua5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/scribe.vala \
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
		src/entity/stats.vala \
		src/entity/inventory.vala \
		src/entity/move.vala \
		src/entity/entity.vala

unlog:
	rm *log;
	rm *err
	rm bin/*log
	rm bin/*err

clean:
	rm bin/LAIR
	make unlog

check:
	luacheck share/lair/demo/dungeon.lua
	luacheck share/lair/demo/player.lua
	luacheck share/lair/demo/ai.lua

install:
	cp bin/LAIR /usr/bin/
	mkdir -p /usr/share/lair/demo/
	mkdir -p /usr/share/lair/lua/
	cp share/lair/lua/common.lua /usr/share/lair/lua/
	cp share/lair/demo/dungeon.lua /usr/share/lair/demo/
	cp share/lair/demo/player.lua /usr/share/lair/demo/
	cp share/lair/demo/ai.lua /usr/share/lair/demo/
	chmod -R a+r /usr/share/lair

