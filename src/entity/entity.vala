using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                public Entity(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Entity.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Entity.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.Player(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base.Parameter(corner, Surfaces, music, font, renderer, "player");
                }
                /*private void DoActions(Entity t){
                }*/
                private bool in_range(Video.Point point, Video.Rect hitbox){
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
                public bool detect_collisions(Entity t){
                        bool r = false;
                        assert(t != null);
                        if(get_block()){
                                if(t.get_block()){
                                        Video.Point tlc = Video.Point(){ x = get_hitbox().x,
                                                y=get_hitbox().y };
                                        bool TLeftCorner = in_range(tlc, t.get_hitbox());

                                        Video.Point trc = Video.Point(){ x = (int)(get_hitbox().x + get_hitbox().w),
                                                y = get_hitbox().y };
                                        bool TRightCorner = in_range(trc, t.get_hitbox());

                                        Video.Point blc = Video.Point(){ x = get_hitbox().x,
                                                y = (int)(get_hitbox().y + get_hitbox().h) };
                                        bool BLeftCorner = in_range(blc, t.get_hitbox());

                                        Video.Point brc = Video.Point(){ x = (int)(get_hitbox().x + get_hitbox().w),
                                                y = (int)(get_hitbox().y + get_hitbox().h) };
                                        bool BRightCorner = in_range( brc, t.get_hitbox());

                                        bounce(TLeftCorner, TRightCorner,
                                        BLeftCorner, BRightCorner, t.get_hitbox());
                                        //DoActions(t);
                                        r = true;
                                }
                        }
                        return r;
                }
                public void render(Video.Renderer renderer, Video.Point player_pos){
                        render_copy(renderer, player_pos);
                        render_text(renderer, player_pos);
                }
	}
}
