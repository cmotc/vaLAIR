using SDL;
using SDLMixer;

namespace LAIR{
	class Voice : Text{
                public Voice(int x, int y, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(x, y, surface, font, renderer);
                }
	}
}