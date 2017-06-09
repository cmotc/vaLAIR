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
                public bool detect_collisions(Entity t){
                        bool r = false;
                        assert(t != null);
                        if(get_block()){
                                if(t.get_block()){
                                        bool TLeftCorner = t.get_hitbox().in_range(get_hitbox().tlc());
                                        bool TRightCorner = t.get_hitbox().in_range(get_hitbox().trc());
                                        bool BLeftCorner = t.get_hitbox().in_range(get_hitbox().blc());
                                        bool BRightCorner = t.get_hitbox().in_range(get_hitbox().brc());
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
                                bool TLeftCorner = get_range_of_sight().in_range(test.get_hitbox().tlc());
                                bool TRightCorner = get_range_of_sight().in_range(test.get_hitbox().trc());
                                bool BLeftCorner = get_range_of_sight().in_range(test.get_hitbox().blc());
                                bool BRightCorner = get_range_of_sight().in_range(test.get_hitbox().brc());
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
