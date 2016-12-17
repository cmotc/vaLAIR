using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Text : Sprite{
                public Text(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer){
                        base(corner, surface, renderer);
                }
                public Text.Blocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, surface, renderer);
                }
                public Text.Parameter(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, surface, renderer, tag);
                }
                public Text.ParameterBlocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, surface, renderer, tag);
                }
                public Text.ParameterList(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, surface, renderer, tags);
                }
                public Text.ParameterListBlocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, surface, renderer, tags);
                }
	}
}
