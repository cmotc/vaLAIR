using SDL;
using SDLMixer;
using SDLTTF;

namespace LAIR{
	class Net : Voice{
                public Net(int x, int y, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(x, y, surface, music, font, renderer);
                }
	}
}