using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Text : Sprite{
                public Text(int x, int y, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer){
                        base(x, y, surface, renderer);
                }
	}
}