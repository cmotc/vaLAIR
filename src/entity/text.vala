using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Text : Sprite{
                private unowned SDLTTF.Font* Font;
                private List<Video.Texture> Text = new List<Video.Texture>();
                //private;
                public Text(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer){
                        base(corner, Surfaces, renderer);
                        Font = font;
                }
                public Text.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, renderer);
                        Font = font;
                }
                public Text.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, renderer, tag);
                        Font = font;
                }
                public Text.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, renderer, tag);
                        Font = font;
                }
                public Text.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, renderer, tags);
                        Font = font;
                }
                public Text.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, renderer, tags);
                        Font = font;
                }
                public void RenderText(Video.Renderer* renderer){
                        int c = 0;
                        foreach(var texture in Text.copy()){
                                renderer->copyex(texture, GetSource(), GetTextPosition(), 0.0, null, Video.RendererFlip.VERTICAL);
                                c++;
                        }

		}
	}
}
