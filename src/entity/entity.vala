using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                List<string> nearby_interests = new List<string>();
                private int period = -0;
                public Entity(AutoPoint corner, string ai_script, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Entity.Floor(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string new_name="floor"){
                        base.Floor(corner, Surfaces, music, font, renderer);
                        set_name(new_name);
                        if(get_name()=="floor"){
                                set_name("floor");
                        }
                        set_type("floor");
                }
                public Entity.Wall(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags, string new_name="particle"){
                        base.Wall(corner, Surfaces, music, font, renderer, tags);
                        set_name(new_name);
                        if(get_name()=="particle"){
                                set_name("particle");
                        }
                        set_type("particle");
                        set_type("blocked");
                }
                public Entity.Mobile(AutoPoint corner, string ai_script, string ai_func, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags, string new_name="mobile"){
                        base.Mobile(corner, ai_script, ai_func, Surfaces, music, font, renderer, tags);
                        set_name(new_name);
                        if(get_name()=="mobile"){
                                set_name("mobile");
                        }
                        set_type("mobile");
                        set_type("blocked");
                }
                public Entity.Player(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string new_name="player"){
                        base.Player(corner, Surfaces, music, font, renderer);
                        set_name(new_name);
                        if(get_name()=="player"){
                                set_name("player");
                        }
                        set_type("player");
                }
                private bool in_range(AutoPoint point, Video.Rect hitbox){
                        bool t = false;
                        int xx = (int) (hitbox.x + hitbox.w);
                        int yy = (int) (hitbox.y + hitbox.h);
                        if ( point.x() > hitbox.x ){
                                if ( point.x() <  xx ){
                                        if( point.y() > hitbox.y ){
                                                if( point.y() < yy ){
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
                                        AutoPoint tlc = new AutoPoint(get_hitbox().x,
                                                get_hitbox().y );
                                        bool TLeftCorner = in_range(tlc, t.get_hitbox());
                                        AutoPoint trc = new AutoPoint((int)(get_hitbox().x + get_hitbox().w),
                                                get_hitbox().y );
                                        bool TRightCorner = in_range(trc, t.get_hitbox());
                                        AutoPoint blc = new AutoPoint(get_hitbox().x,
                                                (int)(get_hitbox().y + get_hitbox().h) );
                                        bool BLeftCorner = in_range(blc, t.get_hitbox());
                                        AutoPoint brc = new AutoPoint((int)(get_hitbox().x + get_hitbox().w),
                                                (int)(get_hitbox().y + get_hitbox().h) );
                                        bool BRightCorner = in_range( brc, t.get_hitbox());
                                        r = bounce(TLeftCorner, TRightCorner,
                                        BLeftCorner, BRightCorner, t.get_hitbox());
                                        //do_actions(t);
                                }
                        }
                        return r;
                }
                public bool detect_nearby_entities(Entity test){
                        bool r = false;
                        if(test.get_block()){
                                AutoPoint tlc = new AutoPoint( test.get_hitbox().x,
                                        test.get_hitbox().y );
                                bool TLeftCorner = in_range(tlc, get_range_of_sight());

                                AutoPoint trc = new AutoPoint( (int)(test.get_hitbox().x + test.get_hitbox().w),
                                        test.get_hitbox().y );
                                bool TRightCorner = in_range(trc, get_range_of_sight());

                                AutoPoint blc = new AutoPoint( test.get_hitbox().x,
                                        (int)(test.get_hitbox().y + test.get_hitbox().h) );
                                bool BLeftCorner = in_range(blc, get_range_of_sight());

                                AutoPoint brc = new AutoPoint( (int)(test.get_hitbox().x + test.get_hitbox().w),
                                        (int)(test.get_hitbox().y + test.get_hitbox().h) );
                                bool BRightCorner = in_range( brc, get_range_of_sight());

                                if ( TLeftCorner ){ if(TRightCorner){ if(BLeftCorner){ if(BRightCorner){
                                        if(nearby_interests.length() < Memory()){
                                                nearby_interests.append(test.stringify_entity_details());
                                                message("is observing %s", test.stringify_entity_details());
                                                r = true;
                                        }
                                }}}}
                        }
                        if(r){
                                push_interests();
                        }
                        return r;
                }
                public void push_interests(){
                        //if(validate_memory_somehow){
                        if(nearby_interests != null){
                                lua_push_strings_to_table("vision", nearby_interests.copy());
                                lua_push_uint_to_table("vision_length", "l", (int)nearby_interests.length());
                                if( period < nearby_interests.length() ){
                                        period++;
                                }else{
                                        period = 0;
                                }
                                lua_push_string_to_table("self", stringify_entity_details());
                                lua_push_uint_to_table("self_speed", "speed", Speed());
                                //lua_push_uint_to_table("self_turn", "p", period);
                        }
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
                                        if(inj.length() <= Memory()){
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
                public void render(Video.Renderer renderer, AutoPoint player_pos){
                        render_copy(renderer, player_pos);
                        render_text(renderer, player_pos);
                }
	}
}
