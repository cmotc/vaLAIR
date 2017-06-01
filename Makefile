include ../config.mk
PREFIX = /
MANPREFIX = $(PREFIX)/share/man
COMMIT_MESSAGE = `date +'%y-%m-%d-%H-%M-%S'`
EMCC_FAST_COMPILER = 0
EMCC_LLVM_TARGET = le32-unknown-nacl

#--pkg gee-0.8 \ Might switch to libgee but probably not.
#-X -Wall -X -Wextra -X -Wformat-security -X -Wstack-protector \
#"/usr/lib/x86_64-linux-gnu"
#--enable-experimental
unix:
	export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-musl" ; \
	valac -gv \
		-o bin/LAIR \
		--pkg-config /usr/bin/pkgconf \
		-X -fstack-protector-all \
		-X --param \
		-X ssp-buffer-size=4 \
		-X -D_FORTIFY_SOURCE=2 \
		-X -ftrapv \
		-X -Wl,-z,relro,-z,now \
		-g \
		--enable-checking \
		--enable-experimental \
		--vapidir="/usr/share/vala/vapi/" \
		--includedir /usr/lib/x86_64-linux-musl \
		--target-glib 2.0 \
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
		--includedir /usr/include/luajit-2.0 \
		-X -lluajit-5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/lists/FloorList.vala \
		src/game/lists/MobilesList.vala \
		src/game/lists/ParticlesList.vala \
		src/game/lists/AutoPoint.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
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
	export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-musl" ; \
	valac -gv \
		-o bin/LAIR \
		--pkg-config /usr/bin/pkgconf \
		-X -fstack-protector-all \
		-X -Wall -X -Wextra -X -Wformat-security -X -Wstack-protector \
		-X --param \
		-X ssp-buffer-size=4 \
		-X -D_FORTIFY_SOURCE=2 \
		-X -ftrapv \
		-X -Wl,-z,relro,-z,now \
		--cc clang \
		--enable-checking \
		--enable-experimental \
		--vapidir="/usr/share/vala/vapi/" \
		--pkg gio-2.0 \
		-X "-I/usr/include/luajit-2.0" \
		-X -lluajit-2.0 \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -O0 \
		-X -g3 \
		-X -llua5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
		src/entity/type.vala \
		src/entity/sprite.vala \
		src/entity/anim.vala \
		src/entity/text.vala \
		src/entity/sound.vala \
		src/entity/stats.vala \
		src/entity/inventory.vala \
		src/entity/move.vala \
		src/entity/entity.vala

unix-static:
	export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-musl" ; \
	valac -gv \
		-o bin/LAIR-static \
		--pkg-config /usr/bin/pkgconf \
		-X -fstack-protector-all \
		-X --param \
		-X ssp-buffer-size=4 \
		-X -D_FORTIFY_SOURCE=2 \
		-X -ftrapv \
		-X -Wl,-z,relro,-z,now \
		-X -static \
		--cc musl-gcc \
		--vapidir="/usr/share/vala/vapi/" \
		--pkg gio-2.0 \
		-X "-I/usr/include/luajit-2.0" \
		-X -lluajit-2.0 \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X -Og \
		-X -g3 \
		-X -llua5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
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
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
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
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
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
	rm -rf ${HOME}/Projects/lair-manifest/lair-msi/bin
	cp -R bin/ ${HOME}/Projects/lair-manifest/lair-msi/bin
	cp README.md LUA.md COPYING.md ${HOME}/Projects/lair-manifest/lair-msi/bin
	rm ${HOME}/Projects/lair-manifest/lair-msi/bin/lair; \
	rm ${HOME}/Projects/lair-manifest/lair-msi/bin/LAIR; \
	cp -R share/lair ${HOME}/Projects/lair-manifest/lair-msi/bin/lair

android:
	export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
	valac -gv \
		-o bin/LAIR-droid \
		--cc "/usr/bin/arm-linux-gnueabihf-gcc" \
		--pkg-config /usr/bin/pkgconf \
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
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
		src/resmanage/files.vala \
		src/resmanage/images.vala \
		src/resmanage/filedb.vala \
		src/resmanage/fonts.vala \
		src/resmanage/sounds.vala \
		src/game/room.vala \
		src/game/floor.vala \
		src/game/tower.vala \
		src/game/game.vala \
		src/entity/dice.vala \
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
		-X -llua5.1 \
		-X -lSDL2 \
		-X -lSDL2_gfx \
		-X -lSDL2_image \
		-X -lSDL2_ttf \
		-X -lSDL2_mixer \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
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
		src/entity/dice.vala \
		src/entity/entity.vala

javascript:
	cd ~ && source ./emsdk_env.sh || echo fail
	valac -gv \
		-o bin/LAIR.html \
		--cc emcc \
		--pkg gio-2.0 \
		--pkg lua \
		--pkg sdl2 \
		--pkg sdl2-gfx \
		--pkg sdl2-image \
		--pkg sdl2-ttf \
		--pkg sdl2-mixer \
		--pkg=tartrazine \
		-X "-s USE_SDL=2" \
		-X "-s USE_SDL_IMAGE=2" \
		-X "-s USE_SDL_NET=2" \
		src/main.vala \
		src/util/net.vala \
		src/util/luaconf.vala \
		src/util/luaglobal.vala \
		src/util/scribe.vala \
		src/util/tagcounter.vala \
		src/util/tag.vala \
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
		src/entity/dice.vala \
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
	luacheck -g ./share/lair/demo/ai.lua \
		./share/lair/demo/player.lua \
		./share/lair/demo/dungeon.lua \
		./share/lair/lua/map/cut_hallways.lua \
		./share/lair/lua/map/basicwall_cares_insert.lua \
		./share/lair/lua/map/common.lua \
		./share/lair/lua/ai/common.lua

sysluacheck:
	diff ./share/lair/demo/ai.lua /usr/share/lair/demo/ai.lua
	diff ./share/lair/demo/player.lua /usr/share/lair/demo/player.lua
	diff ./share/lair/demo/dungeon.lua /usr/share/lair/demo/dungeon.lua
	diff ./share/lair/lua/map/cut_hallways.lua /usr/share/lair/lua/map/cut_hallways.lua
	diff ./share/lair/lua/map/basicwall_cares_insert.lua /usr/share/lair/lua/map/basicwall_cares_insert.lua
	diff ./share/lair/lua/map/common.lua /usr/share/lair/lua/map/common.lua
	diff ./share/lair/lua/ai/common.lua /usr/share/lair/lua/ai/common.lua
	luacheck -g /usr/share/lair/demo/ai.lua \
		/usr/share/lair/demo/player.lua \
		/usr/share/lair/demo/dungeon.lua \
		/usr/share/lair/lua/map/cut_hallways.lua \
		/usr/share/lair/lua/map/basicwall_cares_insert.lua \
		/usr/share/lair/lua/map/common.lua \
		/usr/share/lair/lua/ai/common.lua

debug:
	make
	ulimit -c unlimited
	gdb ./bin/LAIR core

debug-clang:
	make unix-clang
	ulimit -c unlimited
	lldb ./bin/LAIR core

memcheck:
	valgrind --track-origins=yes --leak-check=summary ./bin/LAIR -v 1 -m tiny

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
	echo $(VERSION); sleep 3
	tar --exclude=.git -czvf ../lair_$(VERSION).orig.tar.gz ./

deb-pkg:
	make tarchive
	debuild

deb-upkg:
	make tarchive
	debuild -us -uc

rpm-pkg:
	make
	checkinstall --deldoc=yes --delspec=yes -Ry --pakdir=../

release:
	dch -v $(VERSION) "${COMMIT_MESSAGE}"

release-commit:
	make clean
	make
	git add .
	git commit -am "${COMMIT_MESSAGE}"
	git push

trimmedlogs:
	grep -v process err > err.1
	grep  . err.1 > err.2
	grep Message err > log
	mv err.2 err
	rm err.1

sample:
	make memcheck 1> log 2> err;	\
	make trimmedlogs
	#make memcheck 1> log 2> err;	\
	#make trimmedlogs;		\
	#mv err err.2;			\
	#make memcheck 1> log 2> err;	\
	#make trimmedlogs;		\
	#mv err err.3
