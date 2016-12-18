using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Inventory : Stats{
                public Inventory(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                //public Inventory(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, surface, music, font, renderer);
                }
                public Inventory.Blocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                //public Inventory.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, surface, music, font, renderer);
                }
                public Inventory.Parameter(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                //public Inventory.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, surface, music, font, renderer, tag);
                }
                public Inventory.ParameterBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                //public Inventory.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, surface, music, font, renderer, tag);
                }
                public Inventory.ParameterList(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                //public Inventory.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, surface, music, font, renderer, tags);
                }
                public Inventory.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                //public Inventory.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, surface, music, font, renderer, tags);
                }
	}
}
