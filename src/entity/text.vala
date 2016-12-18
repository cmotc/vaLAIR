using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Text : Sprite{
                //public Text(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer){
                public Text(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer){
                        base(corner, Surfaces, renderer);
                }
                //public Text.Blocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer){
                public Text.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, renderer);
                }
                //public Text.Parameter(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                public Text.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, renderer, tag);
                }
                //public Text.ParameterBlocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                public Text.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, renderer, tag);
                }
                //public Text.ParameterList(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                public Text.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, renderer, tags);
                }
                //public Text.ParameterListBlocked(Video.Point corner, Video.Surface* surface, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                public Text.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, renderer, tags);
                }
	}
}
