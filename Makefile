PREFIX = /
MANPREFIX = $(PREFIX)/share/man
VERSION = '9.1'
COMMIT_MESSAGE = `date +'%y-%m-%d-%H-%M-%S'`
EMCC_FAST_COMPILER = 0
EMCC_LLVM_TARGET = le32-unknown-nacl

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
		-X -llua5.2 \
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
				#--thread \

unix-clang:
	valac -gv \
		-o bin/LAIR \
		--cc clang \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -O0 \
		-X -g3 \
		-X -llua5.2 \
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

win64:
	export PATH=$PATH:/usr/lib/mxe/usr/bin
	export PKG_CONFIG_PATH_x86_64_w64_mingw32_shared=/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/lib/pkgconfig/
	#export PKG_CONFIG_PATH_x86_64_w64_mingw32_static=/usr/lib/mxe/usr/x86_64-w64-mingw32.static/lib/pkgconfig/
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH_x86_64_w64_mingw32_shared
	#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH_x86_64_w64_mingw32_static
	valac -gv \
		-o bin/LAIR-w64.exe \
		--cc "/usr/lib/mxe/usr/bin/x86_64-w64-mingw32.shared-gcc" \
		--pkg-config="/usr/lib/mxe/usr/bin/x86_64-w64-mingw32.shared-pkg-config" \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-windows \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -Og \
		-X -g3 \
		-X "-I /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/" \
		-X "-B /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/lib/" \
		-X -ggdb \
		-X -llua \
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

win32:
	export PATH=$PATH:/usr/lib/mxe/usr/bin
	export PKG_CONFIG_PATH_i686_w64_mingw32_shared=/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/pkgconfig/
	#export PKG_CONFIG_PATH_i686_w64_mingw32_static=/usr/lib/mxe/usr/i686-w64-mingw32.static/lib/pkgconfig/
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH_i686_w64_mingw32_shared
	#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH_i686_w64_mingw32_static
	valac -gv \
		-o bin/LAIR-w32.exe \
		--cc "/usr/lib/mxe/usr/bin/i686-w64-mingw32.shared-gcc" \
		--pkg-config="/usr/lib/mxe/usr/bin/i686-w64-mingw32.shared-pkg-config" \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-windows \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -Og \
		-X -g3 \
		-X "-I /usr/lib/mxe/usr/i686-w64-mingw32.shared/include/" \
		-X "-B /usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/" \
		-X -ggdb \
		-X -llua \
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

windows:
	make win64
	make win32
	rm -rf ${HOME}/Projects/lair-msi/bin
	cp -R bin/ ${HOME}/Projects/lair-msi/bin
	cp README.md LUA.md COPYING.md ${HOME}/Projects/lair-msi/bin
	rm ${HOME}/Projects/lair-msi/bin/lair
	rm ${HOME}/Projects/lair-msi/bin/LAIR
	cp -R share/lair ${HOME}/Projects/lair-msi/bin/lair

android:
	export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
	valac -gv \
		-o bin/LAIR-droid \
		--cc "/usr/bin/arm-linux-gnueabihf-gcc" \
		--pkg-config="/usr/bin/arm-linux-gnueabihf-pkg-config" \
		--disable-warnings \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-android \
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
		-X "-I /usr/include/arm-linux-gnueabihf/" \
		-X "-B /usr/lib/arm-linux-gnueabihf/pkgconfig" \
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

bitcode:
	valac -gv \
		-o bin/LAIR.11 \
		--cc clang \
		-X "-emit-llvm -S" \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -llua5.2 \
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

js:
	rm ./bin/LAIR.js
	emscripten.py --suppressUsageWarning ./bin/LAIR.11 -o ./bin/LAIR.js

webjs:
	make bitcode
	make js

all:
	make unix
	make windows
	make webjs
	make android


unlog:
	rm -f *log \
		*err* \
		bin/*log \
		bin/*err

debclean:
	rm -f ../*.deb ../*.changes ../*.buildinfo ../*.build ../*.changes ../*.dsc
	rm -rf doc-pak description-pak || sudo rm -rf doc-pak description-pak

clean:
	rm -f bin/LAIR
	rm -f bin/LAIR*.exe
	make debclean
	make unlog

check:
	luacheck -g share/lair/demo/dungeon.lua \
		share/lair/demo/player.lua \
		share/lair/demo/ai.lua \
		share/lair/lua/map/common.lua \
		share/lair/lua/map/basicwall_cares_insert.lua \
		share/lair/lua/map/cut_hallways.lua \
		share/lair/lua/ai/common.lua

debug:
	make
	gdb ./bin/LAIR

debug-clang:
	make unix-clang
	lldb ./bin/LAIR

memcheck:
	valgrind --track-origins=yes --leak-check=summary ./bin/LAIR -v 9

install:
	mkdir -p $(DESTDIR)$(PREFIX)/usr/bin/
	cp bin/LAIR $(DESTDIR)$(PREFIX)/usr/bin/
	cp bin/lair $(DESTDIR)$(PREFIX)/usr/bin/
	mkdir -p $(DESTDIR)$(PREFIX)/etc/
	cp etc/lair/lairrc $(DESTDIR)$(PREFIX)/etc/
	mkdir -p $(DESTDIR)$(PREFIX)/usr/share/lair/demo/ \
		$(DESTDIR)$(PREFIX)/usr/share/lair/lua/map/ \
		$(DESTDIR)$(PREFIX)/usr/share/lair/lua/ai/
	cp share/lair/lua/map/common.lua \
		$(DESTDIR)$(PREFIX)/usr/share/lair/lua/map/
	cp share/lair/lua/ai/common.lua \
		$(DESTDIR)$(PREFIX)/usr/share/lair/lua/ai/
	cp share/lair/lua/map/cut_hallways.lua \
		share/lair/lua/map/basicwall_cares_insert.lua \
		$(DESTDIR)$(PREFIX)/usr/share/lair/lua/map
	cp share/lair/demo/dungeon.lua \
		share/lair/demo/player.lua \
		share/lair/demo/ai.lua \
		$(DESTDIR)$(PREFIX)/usr/share/lair/demo/
	chmod -R a+r $(DESTDIR)$(PREFIX)/usr/share/lair
	mkdir -p $(DESTDIR)$(PREFIX)/usr/share/doc/lair
	cp COPYING.md  LUA.md  LUA_MOB.md  README.md $(DESTDIR)$(PREFIX)/usr/share/doc/lair
	#chown -R /var/cache/lair/map/

tarchive:
	make check
	make unix
	tar --exclude=.git -czvf ../lair_$(VERSION).orig.tar.gz ./

deb-pkg:
	make tarchive
	debuild

rpm-pkg:
	make
	checkinstall --deldoc=yes --delspec=yes -Ry --pakdir=../

release-commit:
	make clean
	make
	git add .
	git commit -am "${COMMIT_MESSAGE}"
	git push
	dpkg-source --commit ./ "${COMMIT_MESSAGE}"
	git add .
	git commit -am "${COMMIT_MESSAGE}"
	git push

trimmedlogs:
	grep -v assertion err > trimmederr
	grep . trimmederr > err
	rm trimmederr
	tail -n 1000 log > log

sample:
	make memcheck 1> log 2> err;	\
	make trimmedlogs;		\
	mv err err.1;			\
	make memcheck 1> log 2> err;	\
	make trimmedlogs;		\
	mv err err.2;			\
	make memcheck 1> log 2> err;	\
	make trimmedlogs;		\
	mv err err.3
