using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                public Entity(Video.Point corner, int b, List<Video.Surface*> imgStack, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, imgStack.nth_data(0) , music, font, renderer);
                }
                public Entity.Single(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, surface, music, font, renderer);
                }
                public Entity.Blocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, surface, music, font, renderer);
                }
                public Entity.Parameter(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, surface, music, font, renderer, tag);
                }
                public Entity.ParameterBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, surface, music, font, renderer, tag);
                }
                public Entity.ParameterList(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, surface, music, font, renderer, tags);
                }
                public Entity.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, surface, music, font, renderer, tags);
                }
                public Entity.Player(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base.Parameter(corner, surface, music, font, renderer, "player");
                }
	}
}
