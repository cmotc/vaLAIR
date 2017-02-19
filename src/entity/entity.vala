using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                List<string> nearby_interests = new List<string>();
                public Entity(Video.Point corner, string ai_script, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Entity.Floor(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string new_name="floor"){
                        base.Floor(corner, Surfaces, music, font, renderer);
                        set_name(new_name);
                        if(get_name()=="floor"){
                                set_name("floor");
                        }
                        set_type("floor");
                }
                public Entity.Wall(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags, string new_name="particle"){
                        base.Wall(corner, Surfaces, music, font, renderer, tags);
                        set_name(new_name);
                        if(get_name()=="particle"){
                                set_name("particle");
                        }
                        set_type("particle");
                }
                public Entity.Mobile(Video.Point corner, string ai_script, string ai_func, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags, string new_name="mobile"){
                        base.Mobile(corner, ai_script, ai_func, Surfaces, music, font, renderer, tags);
                        set_name(new_name);
                        if(get_name()=="mobile"){
                                set_name("mobile");
                        }
                        set_type("mobile");
                }
                public Entity.Player(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string new_name="player"){
                        base.Player(corner, Surfaces, music, font, renderer);
                        set_name(new_name);
                        if(get_name()=="player"){
                                set_name("player");
                        }
                        set_type("player");
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
                                                        /*stdout.printf("\n\n Does this Number AXC:%s", point.x.to_string());
                                                        stdout.printf(" come after this Number AX1:%s, and that number", hitbox.x.to_string());
                                                        stdout.printf(" come before this Number AX2:%s\n", xx.to_string());
                                                        stdout.printf(" Does this Number AYC:%s", point.y.to_string());
                                                        stdout.printf(" come after this Number BY1:%s, and that number", hitbox.y.to_string());
                                                        stdout.printf(" come before this Number BY2:%s\n\n", yy.to_string());*/
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
                                                y = get_hitbox().y };
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

                                        r = bounce(TLeftCorner, TRightCorner,
                                        BLeftCorner, BRightCorner, t.get_hitbox());
                                        //DoActions(t);
                                }
                        }
                        return r;
                }
                public bool detect_nearby_entities(Entity test){
                        bool r = false;
                        if(test.get_block()){
                                Video.Point tlc = Video.Point(){ x = test.get_hitbox().x,
                                        y = test.get_hitbox().y };
                                bool TLeftCorner = in_range(tlc, get_range_of_sight());

                                Video.Point trc = Video.Point(){ x = (int)(test.get_hitbox().x + test.get_hitbox().w),
                                        y = test.get_hitbox().y };
                                bool TRightCorner = in_range(trc, get_range_of_sight());

                                Video.Point blc = Video.Point(){ x = test.get_hitbox().x,
                                        y = (int)(test.get_hitbox().y + test.get_hitbox().h) };
                                bool BLeftCorner = in_range(blc, get_range_of_sight());

                                Video.Point brc = Video.Point(){ x = (int)(test.get_hitbox().x + test.get_hitbox().w),
                                        y = (int)(test.get_hitbox().y + test.get_hitbox().h) };
                                bool BRightCorner = in_range( brc, get_range_of_sight());

                                if ( TLeftCorner ){ if(TRightCorner){ if(BLeftCorner){ if(BRightCorner){
                                        nearby_interests.append(test.stringify_entity_details());
                                        print_withname("is observing %s \n", test.stringify_entity_details());
                                        r = true;
                                }}}}
                        }
                        return r;
                }
                public void push_interests(){
                        lua_push_strings_to_table("vision", nearby_interests.copy());
                        lua_push_uint_to_table("vision_length", "l", nearby_interests.length());
                }
                public bool dedupe_and_shrink_nearby_entities(){
                        List<string> inj = new List<string>();
                        bool r = false;
                        if(nearby_interests.length() > Memory()){
                                foreach(string tmp in inj.copy()){
                                        foreach(string tmp2 in nearby_interests.copy()){
                                                if( tmp != tmp2 ){
                                                        inj.append(tmp);
                                                }
                                                if(inj.length() == Memory()){
                                                        break;
                                                }
                                        }
                                        if(inj.length() == Memory()){
                                                break;
                                        }
                                }
                                nearby_interests = inj.copy();
                                r = true;
                        }
                        return r;
                }
                //
                public string stringify_entity_details(){
                        string details = get_category() + stringify_coordinates() + stringify_skills() + stringify_tags();
                        return details;
                }
                public void render(Video.Renderer renderer, Video.Point player_pos){
                        render_copy(renderer, player_pos);
                        render_text(renderer, player_pos);
                }
	}
}
