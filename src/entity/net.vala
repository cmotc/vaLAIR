using SDL;
using SDLMixer;
using SDLTTF;

namespace LAIR{
	class Net : Voice{
                public Net(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, surface, music, font, renderer);
                }
                public Net.Blocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, surface, music, font, renderer);
                }
                public Net.Parameter(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, surface, music, font, renderer, tag);
                }
                public Net.ParameterBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, surface, music, font, renderer, tag);
                }
                public Net.ParameterList(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, surface, music, font, renderer, tags);
                }
                public Net.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, surface, music, font, renderer, tags);
                }
	}
}
