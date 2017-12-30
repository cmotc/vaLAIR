#include ../config.mk
export PREFIX = /usr
export MANPREFIX = $(PREFIX)/share/man/
export BINDIR = $(PREFIX)/bin/
export DEMO = $(PREFIX)/share/lair/demo/
export SETTINGS = /etc/lair/
export LUAMAP = $(PREFIX)/share/lair/lua/map/
export LUAMOB = $(PREFIX)/share/lair/lua/ai/
export DOCS = $(PREFIX)/share/doc/lair/

COMMIT_MESSAGE ?= `date +'%y-%m-%d-%H-%M-%S'`
VERSION ?= 0.9

#EMCC_FAST_COMPILER = 0
#EMCC_LLVM_TARGET = le32-unknown-nacl
#VALAFLAGS:=$(foreach w,$(CPPFLAGS) $(CFLAGS) $(LDFLAGS),-X $(w))
#--pkg gee-0.8 \ Might switch to libgee but probably not.
#-X -Wall -X -Wextra -X -Wformat-security -X -Wstack-protector \
#"/usr/lib/x86_64-linux-gnu"
#--enable-experimental
C_COMPILER ?= gcc
STATIC_C_COMPILER ?= musl-gcc

define VALA_OPTIONS
	--disable-assert \
	--enable-checking \
	--enable-experimental \
	--thread \
	--enable-gobject-tracing
endef

define C_OPTIONS
	--includedir /usr/include/luajit-2.0 \
	-X -fstack-protector-all \
	-X --param \
	-X ssp-buffer-size=4 \
	-X -D_FORTIFY_SOURCE=2 \
	-X -ftrapv \
	-X -Wl,-z,relro,-z,now \
	-X -Bstatic \
	-X -Og \
	-X -g3 \
	-X -lluajit-5.1 \
	-X -lSDL2 \
	-X -lSDL2_image \
	-X -lSDL2_ttf \
	-X -lSDL2_mixer
endef

define VALAIR_LIST
	src/main.vala \
	src/util/autotimer.vala \
	src/util/autorect.vala \
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
	src/game/lists/RoomsList.vala \
	src/game/lists/FloorList.vala \
	src/game/lists/MobilesList.vala \
	src/game/lists/ParticlesList.vala \
	src/game/lists/AutoPoint.vala \
	src/game/frame.vala \
	src/game/room.vala \
	src/game/level.vala \
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
endef

define VALA_PKG_OPTIONS
	--pkg-config /usr/bin/pkgconf \
	--vapidir="/usr/local/share/vala-0.40/vapi/" \
	--pkg gio-2.0 \
	--pkg lua \
	--pkg sdl2 \
	--pkg sdl2-image \
	--pkg sdl2-ttf \
	--pkg sdl2-mixer \
	--target-glib 2.0 \
	--pkg=tartrazine
endef
#--pkg sdl2-gfx \
#export LD_LIBRARY_PATH = /usr/local/lib

unix:
	valac -gv \
		-o bin/LAIR \
		--cc $(C_COMPILER) \
		$(VALA_OPTIONS) \
		$(VALA_PKG_OPTIONS) \
		-g \
		$(C_OPTIONS) \
		$(VALAIR_LIST)

unix-opt:
	valac -gv \
		-o bin/LAIR \
		--cc $(C_COMPILER) \
		$(VALA_OPTIONS) \
		$(VALA_PKG_OPTIONS) \
		--vapidir /usr/share/vala-0.36/vapi \
		-X -O3 \
		-X -fstack-protector-all \
		-X --param \
		-X ssp-buffer-size=4 \
		-X -D_FORTIFY_SOURCE=2 \
		-X -ftrapv \
		-X -Wl,-z,relro,-z,now \
		-X -Bstatic \
		-X -fPIE \
		$(C_OPTIONS) \
		$(VALAIR_LIST)

docker:
	docker build -f Dockerfile/Dockerfile -t valair .

alpine:
	docker build -f Dockerfile/Dockerfile.alpine -t valair-alpine .

docker-run:
	docker run -ti --rm \
		-e DISPLAY=$(DISPLAY) \
		--device /dev/snd \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(HOME)/.Xauthority:/home/lair/.Xauthority \
		valair

docker-alpine-run:
	docker run -ti \
		--name alpine-lair \
		-e DISPLAY=$(DISPLAY) \
		--device /dev/snd \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(HOME)/.Xauthority:/home/lair/.Xauthority \
		valair-alpine

docker-ls:
	docker run -ti --rm \
		-e DISPLAY=${DISPLAY} \
		--device /dev/snd \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY \
		valair ls /usr/local/bin/

unix-static:
	valac -gv \
		-o bin/LAIR-static \
		--cc $(C_COMPILER) \
		$(VALA_OPTIONS) \
		$(VALA_PKG_OPTIONS) \
		-g \
		$(C_OPTIONS) \
		-X -l:libluajit-5.1.a \
		-X -l:libSDL2.a \
		-X -l:libSDL2_image.a \
		-X -l:libSDL2_ttf.a \
		-X -l:libSDL2_mixer.a \
		-X -l:libFLAC.a \
		-X -l:libogg.a \
		$(VALAIR_LIST)

unix-alpine:
	valac -gv \
		-o bin/LAIR \
		$(VALA_OPTIONS) \
		$(VALA_PKG_OPTIONS) \
		-g \
		$(C_OPTIONS) \
		$(VALAIR_LIST)

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
		$(VALAIR_LIST)

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
		$(VALAIR_LIST)

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
	export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig ; \
	valac -gv \
		-o bin/LAIR-droid \
		--cc "/usr/arm-linux-androideabi/bin/arm-linux-androideabi-gcc" \
		--pkg-config /usr/bin/pkgconf \
		-X -fstack-protector-all \
		-X --param \
		-X ssp-buffer-size=4 \
		-X -D_FORTIFY_SOURCE=2 \
		-X -ftrapv \
		-X -Wl,-z,relro,-z,now \
		-X -Bstatic \
		-g \
		--disable-assert \
		--enable-checking \
		--enable-experimental \
		--enable-gobject-tracing \
		--vapidir="/usr/share/vala/vapi/" \
		--includedir /usr/include/x86_64-linux-musl \
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
		$(VALAIR_LIST)

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
		$(VALAIR_LIST)

javascript:
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
		$(VALAIR_LIST)

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
	rm -f *log* \
		*err* \
		bin/*log \
		bin/*err

debclean:
	rm -f ../*.deb ../*.changes ../*.buildinfo ../*.build ../*.changes ../*.dsc ../*.tar.xz
	rm -rf doc-pak description-pak || sudo rm -rf doc-pak description-pak

clean:
	rm -f bin/LAIR*
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
	make 2>build.err 1>build.log
	ulimit -c unlimited
	gdb ./bin/LAIR core

debug-clang:
	make unix-clang 2>build.err 1>build.log
	ulimit -c unlimited
	lldb ./bin/LAIR-clang core

memcheck:
	ulimit -c unlimited; \
	valgrind --track-origins=yes --leak-check=summary --trace-children=yes ./bin/LAIR -v 1 -m oneroom 2>mem.err 1>mem.log

dirs:
	cp *.md docs
	mkdir -p $(BINDIR) \
		$(SETTINGS) \
		$(DEMO) \
		$(LUAMAP) \
		$(LUAMOB) \
		$(DOCS)

install: dirs
	install -D -m 755 bin/LAIR $(BINDIR)LAIR
	install -D -m 755 bin/lair $(BINDIR)lair
	install -D  etc/lair/lairrc $(SETTINGS)
	install -D -m 755 share/lair/lua/map/common.lua $(LUAMAP)
	install -D -m 755 share/lair/lua/map/basicwall_cares_insert.lua $(LUAMAP)
	install -D -m 755 share/lair/lua/map/cut_hallways.lua $(LUAMAP)
	install -D -m 755 share/lair/lua/ai/common.lua $(LUAMOB)
	install -D -m 755 share/lair/demo/ai.lua $(DEMO)
	install -D -m 755 share/lair/demo/dungeon.lua $(DEMO)
	install -D -m 755 share/lair/demo/player.lua $(DEMO)
	install -D  docs/COPYING.md $(DOCS)
	install -D  docs/LUA.md $(DOCS)
	install -D  docs/LUA_MOB.md $(DOCS)
	install -D  docs/README.md $(DOCS)

tarchive:
	make check
	make unix
	echo $(VERSION); sleep 3
	tar --exclude=.git -czvf ../lair_$(VERSION).orig.tar.gz ./

deb-pkg: tarchive
	debuild

deb-upkg: tarchive
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

