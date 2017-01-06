using SDL;
using SDLMixer;
using SDLTTF;

namespace LAIR{
	class Net : Voice{
                public Net(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, Labels, renderer);
                }
                public Net.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, Labels, renderer);
                }
                public Net.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, Labels, renderer, tag);
                }
                public Net.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, Labels, renderer, tag);
                }
                public Net.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, Labels, renderer, tags);
                }
                public Net.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, Labels, renderer, tags);
                }
	}
}
