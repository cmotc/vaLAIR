using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                public Entity(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Entity.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Entity.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.Player(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base.Parameter(corner, Surfaces, music, font, renderer, "player");
                }
                public bool DetectCollision(Entity t){
                        bool r = false;
                        int[2] bottomRightA = { (int) GetX()+GetWidth(), (int) GetY()+GetHeight() };
                        int[2] bottomRightB = { (int) t.GetX()+t.GetWidth(), (int) t.GetY()+t.GetHeight() };
                        int x = 0; int y = 1;
                        bool boxOnly = ((bottomRightB[x] < GetX()) || (bottomRightA[x] < t.GetX())) ? false: true;
                        boxOnly = ((bottomRightB[y] < GetY()) || (bottomRightA[y] < t.GetY())) ? boxOnly: true;
                        if (boxOnly){
                                int[2] xse = {
                                (GetX() > t.GetX()) ? GetX() : t.GetX() ,
                                (bottomRightA[x] > bottomRightB[x]) ? bottomRightA[x] : bottomRightB[x]
                                };
                                int[2] yse = {
                                (GetY() > t.GetY()) ? GetY() : t.GetY() ,
                                (bottomRightA[y] > bottomRightB[y]) ? bottomRightA[y] : bottomRightB[y]
                                };
                                for ( int Y = yse[0]; Y < yse[1]; y++){
                                        for ( int X = xse[0]; X < xse[1]; x++){
                                        }
                                }

                        }
                        return r;
                }
	}
}
