using SDL;
using Lua;

namespace LAIR{
	class Room : LuaConf{
		private bool visited = false;
                private Video.Rect Border = Video.Rect(){ x = 0, y = 0, w = 0, h = 0 };
		private List<Entity> Particles = new List<Entity>();
		private List<Entity> Mobs = new List<Entity>();
                private Entity Player = null;
                private static FileDB GameMaster = null;
                public Room(Video.Rect position, Video.Rect floordims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        set_dimensions(position.x, position.y, position.w, position.h);
                        set_floor_dimensions(floordims);
                        set_name("room ("+stringify_hitbox()+"): ");
                        print_withname("generating room\n");
                        GameMaster = DM;
                        lua_push_dimensions(get_hitbox());
                        //generate_structure(2, renderer);
                        generate_floor(2, renderer);
                        generate_particles(2, renderer);
                        generate_mobiles(2, renderer);
		}
                public Room.WithPlayer(Video.Rect position, Video.Rect floordims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        set_dimensions(position.x, position.y, position.w, position.h);
                        set_floor_dimensions(floordims);
                        set_name("room ("+stringify_hitbox()+"): ");
                        print_withname("generating room with player\n");
                        GameMaster = DM;
                        lua_push_dimensions(get_hitbox());
                        //generate_structure(2, renderer);
                        generate_floor(2, renderer);
                        generate_particles(2, renderer);
                        generate_mobiles(2, renderer);
                        generate_player(renderer);
		}
                private void set_dimensions(int x, int y, uint w, uint h){
                        Border.x = x;
                        Border.y = y;
                        Border.w = w;
                        Border.h = h;
                }
                private void set_floor_dimensions(Video.Rect floordims){
                        lua_push_uint_to_table("floor_w", "w", floordims.w );
                        lua_push_uint_to_table("floor_h", "h", floordims.h );
                        lua_push_uint_to_table("floor_coarse_w", "w", (floordims.w / 32) );
                        lua_push_uint_to_table("floor_coarse_h", "h", (floordims.h / 32) );
                }
                private int get_x(){     return (int) Border.x;}
                private int get_offset_x(int x){
                        int r = (x * 32) + get_x();
                        return r;
                }
                private int get_y(){     return (int) Border.y;}
                private int get_offset_y(int y) {
                        int r = (y * 32) + get_y();
                        return r;
                }
                /*public Video.Point GetCorner(){
                        Video.Point r = Video.Point(){x=get_x(), y=get_y()};
                        return r;
                }*/
                public uint get_w(){     return Border.w;}
                public uint get_h(){     return Border.h;}
                private void generate_player(Video.Renderer? renderer){
                        if(!has_player()){
                                Player = new Entity.Player(Video.Point(){x = 128, y = 128}, GameMaster.body_by_tone("med"), GameMaster.basic_sounds(), GameMaster.get_rand_font(), renderer);
                        }
                }
                private void GeneratorPushXYToLua(Video.Point current, Video.Point simplecurrent){
                        lua_push_coords(current, simplecurrent);
                        particle_count();
                        particle_count_bytag();
                        mobile_count();
                        mobile_count_bytag();
                }
                private int particle_count(){
                        lua_push_uint_to_table("""generator_particle_count""", """c""", Particles.length());
                        return (int) Particles.length();
                }
                //private CallbackFunc particle_count_delegate = (CallbackFunc) particle_count;
                private int mobile_count(){
                        lua_push_uint_to_table("""generator_mobile_count""", """c""", Mobs.length());
                        return (int) Mobs.length();
                }
                //Todo: Instead of doing it this way, pass a new entity to this
                //function and have it do the appending, so we can skip the
                //first for loop here and just add tags for new entities.
                //Requires caching the tag count, but arguably should be doing
                //that anyway. Not important right now. Thiw way works.
                private void particle_count_bytag(){
                        List<TagCounter> tagcount = new List<TagCounter>();
                        foreach(Entity particle in Particles){
                                foreach(string tag in particle.get_tags()){
                                        bool has = false;
                                        foreach(TagCounter count in tagcount){
                                                if(count.check_name(tag)){
                                                        count.increment_count();
                                                        has = true;
                                                        break;
                                                }
                                        }
                                        if(!has){
                                                tagcount.append(new TagCounter(tag));
                                        }
                                }
                        }
                        foreach(TagCounter count in tagcount){
                                lua_push_uint_to_table(count.get_name(), "c", count.get_count());
                        }
                }
                private void mobile_count_bytag(){
                        List<TagCounter> tagcount = new List<TagCounter>();
                        foreach(Entity mob in Mobs){
                                foreach(string tag in mob.get_tags()){
                                        bool has = false;
                                        foreach(TagCounter count in tagcount){
                                                if(count.check_name(tag)){
                                                        count.increment_count();
                                                        has = true;
                                                        break;
                                                }
                                        }
                                        if(!has){
                                                tagcount.append(new TagCounter(tag));
                                        }
                                }
                        }
                        foreach(TagCounter count in tagcount){
                                lua_push_uint_to_table(count.get_name(), "c", count.get_count());
                        }
                }
                private void generate_floor_tile(Video.Point coords, Video.Renderer* renderer){
                        Particles.append(new Entity.Floor(coords, GameMaster.image_by_name("floor"), GameMaster.no_sound(), GameMaster.get_rand_font(), renderer));
                }
                private void decide_block_tile(Video.Point coords, Video.Renderer* renderer){
                        lua_do_function("""map_cares_insert()""");
                        List<string> cares = get_lua_last_return();
                        print_withname("\n %s \n", cares.nth_data(0));
                        if(cares != null){
                                if(cares.nth_data(0) == "true"){
                                        print_withname("Will it blend?\n");
                                        lua_do_function("""map_image_decide()""");
                                        List<string> imgTags = get_lua_last_return();
                                        lua_do_function("""map_sound_decide()""");
                                        List<string> sndTags = get_lua_last_return();
                                        lua_do_function("""map_fonts_decide()""");
                                        List<string> fntTags = get_lua_last_return();
                                        inject_particle(coords, imgTags, sndTags, fntTags, renderer);
                                }
                        }
                }
                private void decide_mobile_tile(Video.Point coords, Video.Renderer* renderer){
                        lua_do_function("""mob_cares_insert()""");
                        List<string> cares = get_lua_last_return();
                        print_withname("\n %s \n", cares.nth_data(0));
                        if(cares != null){
                                if(cares.nth_data(0) == "true"){
                                        print_withname("Will it blend?\n");
                                        lua_do_function("""mob_image_decide()""");
                                        List<string> imgTags = get_lua_last_return();
                                        lua_do_function("""mob_sound_decide()""");
                                        List<string> sndTags = get_lua_last_return();
                                        lua_do_function("""mob_fonts_decide()""");
                                        List<string> fntTags = get_lua_last_return();
                                        inject_mobile(coords, imgTags, sndTags, fntTags, renderer);
                                }
                        }
                }
                //Only coarse generation of the dungeon structure is done in the native code, most of the logic will be handed to scripts eventually.
                /*private void generate_structure(int CR, Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        Video.Point simplecoords = Video.Point(){x=xx, y=yy};
                                        Video.Point coords = Video.Point(){x=get_offset_x(xx), y=get_offset_y(yy)};
                                        GeneratorPushXYToLua(coords, simplecoords);
                                        generate_floor_tile(coords, renderer);
                                        decide_block_tile(coords, renderer);
                                        decide_mobile_tile(coords, renderer);
                                }
                        }
                }*/
                private void generate_floor(int CR, Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        Video.Point simplecoords = Video.Point(){x=xx, y=yy};
                                        Video.Point coords = Video.Point(){x=get_offset_x(xx), y=get_offset_y(yy)};
                                        GeneratorPushXYToLua(coords, simplecoords);
                                        generate_floor_tile(coords, renderer);
                                }
                        }
                }
                private void generate_particles(int CR, Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        Video.Point simplecoords = Video.Point(){x=xx, y=yy};
                                        Video.Point coords = Video.Point(){x=get_offset_x(xx), y=get_offset_y(yy)};
                                        GeneratorPushXYToLua(coords, simplecoords);
                                        decide_block_tile(coords, renderer);
                                }
                        }
                }
                private void generate_mobiles(int CR, Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        Video.Point simplecoords = Video.Point(){x=xx, y=yy};
                                        Video.Point coords = Video.Point(){x=get_offset_x(xx), y=get_offset_y(yy)};
                                        GeneratorPushXYToLua(coords, simplecoords);
                                        decide_mobile_tile(coords, renderer);
                                }
                        }
                }
                public bool has_player(){
			bool tmp = false;
			if (Player != null){
				tmp = true;
                                visited = true;
			}
			return tmp;
		}
                public Entity get_player(){
			Entity tmp = null;
			if (Player != null){
				tmp = Player;
			}
			return tmp;
		}
                public int take_turns(){
                        int tmp = 1;
                        if (has_player()){
                                tmp = Player.run();
                                if (tmp > 1){
                                        print_withname("    Player took a turn : %s \n", tmp.to_string());
                                }
                        }else{
                                foreach(Entity mob in Mobs){
					mob.run();
				}
                        }
                        return tmp;
                }
                public bool detect_collisions(){
                        bool t = false;
                        foreach(var particle in Particles){
                                if(has_player()){
                                        t = Player.detect_collisions(particle) ? true : t ;
                                        foreach(var mob in Mobs){
                                                t = mob.detect_collisions(Player) ? true : t;
                                                t = Player.detect_collisions(mob) ? true : t;
                                        }
                                }else{
                                        foreach(var mob in Mobs){
                                                particle.detect_collisions(mob);
                                        }
                                }
                        }
                        return t;
                }
                private Video.Rect get_hitbox(){
                        return Border;
                }
                private string stringify_hitbox(){
                        string HBSUM = "x:";
                        HBSUM += Border.x.to_string();
                        HBSUM += "y:";
                        HBSUM += Border.y.to_string();
                        HBSUM += "w:";
                        HBSUM += Border.w.to_string();
                        HBSUM += "h:";
                        HBSUM += Border.h.to_string();
                        return HBSUM;
                }
                private bool point_in_room(Video.Point point, Video.Rect hitbox){
                        bool t = false;
                        int xx = (int) (hitbox.x + hitbox.w);
                        int yy = (int) (hitbox.y + hitbox.h);
                        if ( point.x > hitbox.x ){
                                if ( point.x <  xx ){
                                        if( point.y > hitbox.y ){
                                                if( point.y < yy ){
                                                        t = true;
                                                }
                                        }
                                }
                        }
                        return t;
                }
                public bool detect_transitions(Entity t){
                        bool r = false;
                        if(t!=null){
                                Video.Point tlc = Video.Point(){ x = t.get_hitbox().x,
                                        y=t.get_hitbox().y };
                                bool TLeftCorner = point_in_room(tlc, get_hitbox());
                                Video.Point trc = Video.Point(){ x = (int)(t.get_hitbox().x + t.get_hitbox().w),
                                        y = t.get_hitbox().y };
                                bool TRightCorner = point_in_room(trc, get_hitbox());
                                Video.Point blc = Video.Point(){ x = t.get_hitbox().x,
                                        y = (int)(t.get_hitbox().y + t.get_hitbox().h) };
                                bool BLeftCorner = point_in_room(blc, get_hitbox());
                                Video.Point brc = Video.Point(){ x = (int)(t.get_hitbox().x + t.get_hitbox().w),
                                        y = (int)(t.get_hitbox().y + t.get_hitbox().h) };
                                bool BRightCorner = point_in_room( brc, get_hitbox());

                                //TLeftCorner = get_hitbox().contains(tlc);
                                //TRightCorner = get_hitbox().contains(trc);
                                //BLeftCorner = get_hitbox().contains(blc);
                                //BRightCorner = get_hitbox().contains( brc);
                                if (TLeftCorner){
                                        r = true;
                                }
                                if (TRightCorner){
                                        r = true;
                                }
                                if (BLeftCorner){
                                        r = true;
                                }
                                if (BRightCorner){
                                        r = true;
                                }
                        }
                        return r;
                }
                public void render_copy(Video.Renderer renderer, Video.Point player_pos){
			if (visited){
                                //print_withname("Drawing Room at: %s\n", HitBoxToString());
				foreach(Entity particle in Particles){
					particle.render(renderer, player_pos);
				}
			}
                        if (has_player()){
				Player.render(renderer, player_pos);
				if (visited = false){
					visited = true;
				}
				foreach(Entity mob in Mobs){
					mob.render(renderer, player_pos);
				}
			}
		}
		public bool enter_room(Entity player){
			if (player != null){
                                print_withname("    Player Entering Room. \n");
				Player = player;
                                visited = true;
			}else{
                                Player = null;
                                visited = false;
                        }
			return visited;
		}
		public Entity leave_room(bool doleave){
                        Entity tmp = null;
                        if (doleave){
                                if (Player != null){
                                        tmp = Player;
                                        Player = null;
                                }
                        }
			return tmp;
		}
                //lua interfaces for dungeon generation start here, already loose naming conventions deliberately changed...
                private void inject_particle(Video.Point coords, List<string> imgTags, List<string> sndTags, List<string> fntTags, Video.Renderer* renderer){
                        if ( coords.x < get_x() + get_w() ){ if ( coords.x >= get_x() ){
                                if ( coords.y < get_y() + get_h() ){ if ( coords.y >= get_y() ){
                                        Particles.append(new Entity.Wall(coords, GameMaster.image_by_name(imgTags.nth_data(0)), GameMaster.no_sound(), GameMaster.get_rand_font(), renderer, imgTags));
                                        lua_do_function("record_cell(\"" + imgTags.nth_data(0) + "\")");
                                }}
                        }}
                }
                private void inject_mobile(Video.Point coords, List<string> imgTags, List<string> sndTags, List<string> fntTags, Video.Renderer* renderer){
                        if ( coords.x < get_x() + get_w() ){ if ( coords.x >= get_x() ){
                                if ( coords.y < get_y() + get_h() ){ if ( coords.y >= get_y() ){
                                        Mobs.append(new Entity.Mobile(coords, "", GameMaster.body_by_tone(imgTags.nth_data(0)), GameMaster.basic_sounds(), GameMaster.get_rand_font(), renderer, imgTags));
                                        lua_do_function("record_mobile(\"" + imgTags.nth_data(0) + "\")");
                                }}
                        }}
                }
	}
}
