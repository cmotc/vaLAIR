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
                private void DoActions(Entity t){
                }
                private bool InRange(Video.Point point, Video.Rect hitbox){
                        bool t = false;
                        int xx = (int) (hitbox.x + hitbox.w);
                        int yy = (int) (hitbox.y + hitbox.h);
                        if ( point.x > hitbox.x ){
                                if ( point.x <  xx ){
                                        if( point.y > hitbox.y ){
                                                if( point.y < yy ){
                                                        stdout.printf("\n\n Does this Number AXC:%s", point.x.to_string());
                                                        stdout.printf(" come after this Number AX1:%s, and that number", hitbox.x.to_string());
                                                        stdout.printf(" come before this Number AX2:%s\n", xx.to_string());
                                                        stdout.printf(" Does this Number AYC:%s", point.y.to_string());
                                                        stdout.printf(" come after this Number BY1:%s, and that number", hitbox.y.to_string());
                                                        stdout.printf(" come before this Number BY2:%s\n\n", yy.to_string());
                                                        t = true;
                                                }
                                        }
                                }
                        }
                        return t;
                }
                public bool DetectCollision(Entity t){
                        int test = 0;
                        bool r = false;
                        assert(t != null);
                        if(GetBlock()){
                                if(t.GetBlock()){
                                        Video.Point tlc = Video.Point(){ x = GetHitBox().x,
                                                y=GetHitBox().y };
                                        bool TLeftCorner = InRange(tlc, t.GetHitBox());

                                        Video.Point trc = Video.Point(){ x = (int)(GetHitBox().x + GetHitBox().w),
                                                y = GetHitBox().y };
                                        bool TRightCorner = InRange(trc, t.GetHitBox());

                                        Video.Point blc = Video.Point(){ x = GetHitBox().x,
                                                y = (int)(GetHitBox().y + GetHitBox().h) };
                                        bool BLeftCorner = InRange(blc, t.GetHitBox());

                                        Video.Point brc = Video.Point(){ x = (int)(GetHitBox().x + GetHitBox().w),
                                                y = (int)(GetHitBox().y + GetHitBox().h) };
                                        bool BRightCorner = InRange( brc, t.GetHitBox());

                                        Bounce(TLeftCorner, TRightCorner,
                                        BLeftCorner, BRightCorner, t.GetHitBox());
                                        //DoActions(t);
                                        r = true;
                                }
                        }
                        return r;
                }
	}
}
