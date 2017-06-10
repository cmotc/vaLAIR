using SDL;
using Lua;

namespace LAIR{
	class Room : LuaConf{
		private bool visited = false;
                private AutoRect Border = new AutoRect(0,0,0,0);
                private FloorList Floor = null;
                private ParticlesList Particles = null;
                private MobilesList Mobiles = null;
                private Entity Player = null;
                private static FileDB GameMaster = null;
                public Room(AutoRect position, AutoRect floor_dims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        Border = new AutoRect(position.x(), position.y(), position.w(), position.h());
                        lua_push_dimensions_generator_phase(get_hitrect(), floor_dims);
                        //set_floor_dimensions(floor_dims);
                        set_name("room("+stringify_hitrect()+"): ");
                        message("generating room%s", get_name());
                        GameMaster = DM;
                        Floor = new FloorList(get_hitrect());
                        Particles = new ParticlesList(get_hitrect());
                        Mobiles = new MobilesList(get_hitrect());
                        generate_floor(renderer);
                        message("loading scripts: %s, %s, %s",scripts[0],scripts[1],scripts[2]);
                        generate_particles(renderer);
                        generate_mobiles(scripts[2], renderer);
		}
                public Room.WithPlayer(AutoRect position, AutoRect floor_dims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        Border = new AutoRect(position.x(), position.y(), position.w(), position.h());
                        lua_push_dimensions_generator_phase(get_hitrect(), floor_dims);
                        //set_floor_dimensions(floor_dims);
                        set_name("room ("+stringify_hitrect()+"): ");
                        message("generating room with player");
                        GameMaster = DM;
                        Floor = new FloorList(get_hitrect());
                        Particles = new ParticlesList(get_hitrect());
                        Mobiles = new MobilesList(get_hitrect());
                        generate_floor(renderer);
                        generate_particles(renderer);
                        message("loading scripts: %s, %s, %s",scripts[0],scripts[1],scripts[2]);
                        generate_mobiles(scripts[2], renderer);
                        generate_player(scripts[1], renderer);
		}
                private void set_floor_dimensions(AutoRect floordims){
                        lua_push_uint_to_table("floor_w", "w", (int)floordims.w() );
                        lua_push_uint_to_table("floor_h", "h", (int)floordims.h() );
                        lua_push_uint_to_table("floor_coarse_w", "w", (int)(floordims.w() / 32) );
                        lua_push_uint_to_table("floor_coarse_h", "h", (int)(floordims.h() / 32) );
                }
                private int get_x(){     return (int) Border.x();}
                private int get_offset_x(int x){
                        int r = (x * 32) + get_x();
                        return r;
                }
                private int get_y(){     return (int) Border.y();}
                private int get_offset_y(int y) {
                        int r = (y * 32) + get_y();
                        return r;
                }
                public uint get_w(){     return Border.w();}
                public uint get_h(){     return Border.h();}
                private void generate_player(string playerScript, Video.Renderer? renderer){
                        if(!has_player()){
                                Player = new Entity.Player(new AutoPoint(128,128), GameMaster.body_by_tone("med"), GameMaster.basic_sounds(), GameMaster.get_rand_font(), renderer);
                        }
                }
                private List<AutoPoint> generator_push_xy_to_lua(int xx, int yy){
                        List<AutoPoint> coords = new List<AutoPoint>();
                        coords.append(new AutoPoint(xx, yy));
                        coords.append(new AutoPoint(get_offset_x(xx), get_offset_y(yy)));
                        message("Coordinates pushed to lua table: %s", coords.length().to_string());
                        if(coords.length() == 2){
                                lua_push_coords(coords.nth_data(0), coords.nth_data(1));
                                particle_count();
                                particle_count_bytag();
                                mobile_count();
                                mobile_count_bytag();
                        }
                        return coords;
                }
                private int particle_count(){
                        lua_push_uint_to_table("""generator_particle_count""", """c""", (int)Particles.length());
                        return (int) Particles.length();
                }
                //private CallbackFunc particle_count_delegate = (CallbackFunc) particle_count;
                private int mobile_count(){
                        lua_push_uint_to_table("""generator_mobile_count""", """c""", (int)Mobiles.length());
                        return (int) Mobiles.length();
                }
                //Todo: Instead of doing it this way, pass a new entity to this
                //function and have it do the appending, so we can skip the
                //first for loop here and just add tags for new entities.
                //Requires caching the tag count, but arguably should be doing
                //that anyway. Not important right now. This way works.
                private void particle_count_bytag(){
                        foreach(TagCounter count in Particles.count_bytag()){
                                lua_push_uint_to_table(count.get_name(), "c", (int)count.get_count());
                        }
                }
                private void mobile_count_bytag(){
                        foreach(TagCounter count in Mobiles.count_bytag()){
                                lua_push_uint_to_table(count.get_name(), "c", (int)count.get_count());
                        }
                }
                private List<List<string>> decide_floor_tile(){
                        lua_do_function("""map_cares_insert()""");
                        List<string> cares = get_lua_last_return();
                        List<List<string>> tmp = new List<List<string>>();
                        if(cares != null){
                                if(cares.nth_data(0) == "true"){
                                        message("Will it blend?");
                                        lua_do_function("""floor_image_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""floor_sound_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""floor_fonts_decide()""");
                                        tmp.append(get_lua_last_return());
                                }
                        }
                        return tmp;
                }
                private List<List<string>> decide_block_tile(){
                        lua_do_function("""map_cares_insert()""");
                        List<string> cares = get_lua_last_return();
                        List<List<string>> tmp = new List<List<string>>();
                        if(cares != null){
                                if(cares.nth_data(0) == "true"){
                                        message("Will it blend?");
                                        lua_do_function("""map_image_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""map_sound_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""map_fonts_decide()""");
                                        tmp.append(get_lua_last_return());

                                }
                        }
                        return tmp;
                }
                private List<List<string>> decide_mobile_tile(string aiScript){
                        lua_do_function("""mob_cares_insert()""");
                        List<string> cares = get_lua_last_return();
                        List<List<string>> tmp = new List<List<string>>();
                        if(cares != null){
                                if(cares.nth_data(0) == "true"){
                                        message("Will it blend?");
                                        lua_do_function("""mob_image_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""mob_sound_decide()""");
                                        tmp.append(get_lua_last_return());
                                        lua_do_function("""mob_fonts_decide()""");
                                        tmp.append(get_lua_last_return());
                                }
                        }
                        return tmp;
                }
                //Only coarse generation of the dungeon structure is done in the native code, most of the logic will be handed to scripts eventually.
                private void generate_floor(Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        message("Floor Generation At x %s y %s, os %s oy %s",
                                                xx.to_string(),
                                                yy.to_string(),
                                                get_offset_x(xx).to_string(),
                                                get_offset_y(yy).to_string() );
                                        Floor.generate_floor(GameMaster,
                                                generator_push_xy_to_lua(xx, yy),
                                                renderer);
                                }
                        }
                }
                private void generate_particles(Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        message("Particle Generation At x %s y %s, os %s oy %s",
                                                xx.to_string(),
                                                yy.to_string(),
                                                get_offset_x(xx).to_string(),
                                                get_offset_y(yy).to_string() );
                                        Particles.generate_particle(GameMaster,
                                                generator_push_xy_to_lua(xx, yy),
                                                decide_block_tile(),
                                                renderer);
                                }
                        }
                }
                private void generate_mobiles(string aiScript, Video.Renderer* renderer){
                        int WT = (int)(get_w() / 32); int HT = (int)(get_h() / 32);
                        for (int xx = 0; xx < WT; xx++){
                                for (int yy = 0; yy < HT; yy++){
                                        message("Mobile Generation At x %s y %s, os %s oy %s",
                                                xx.to_string(),
                                                yy.to_string(),
                                                get_offset_x(xx).to_string(),
                                                get_offset_y(yy).to_string() );
                                        Mobiles.generate_mobile(GameMaster,
                                                generator_push_xy_to_lua(xx, yy),
                                                decide_mobile_tile(aiScript),
                                                aiScript,
                                                renderer);
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
                public unowned List<Entity> get_mobiles(){
                        return Mobiles.get_mobiles();
                }
                public int take_turns(){
                        int tmp = 1;
                        if (has_player()){
                                if(Mobiles.length() > 0){
                                        foreach(Entity mob in Mobiles.get_mobiles()){
                                                mob.run();
                                        }
                                }
                                tmp = Player.run();
                        }else{
                                if(Mobiles.length() > 0){
                                        foreach(Entity mob in Mobiles.get_mobiles()){
                                                mob.run();
                                        }
                                }
                        }
                        return tmp;
                }
                public bool player_detect_collisions(){
                        bool t = false;
                        if(has_player()){
                                foreach(Entity particle in Particles.get_particles()){
                                        t = Player.detect_collisions(particle);

                                }
                                foreach(Entity mob in Mobiles.get_mobiles()){
                                        t = Player.detect_collisions(mob) ? true : t;
                                }
                        }
                        return t;
                }
                public bool mob_detect_collisions(Entity mob){
                        bool t = false;
                        foreach(Entity mob2 in Mobiles.get_mobiles()){
                                mob.detect_nearby_entities(mob2);
                        }
                        foreach(Entity particle in Particles.get_particles()){
                                if(has_player()){
                                        t = mob.detect_collisions(Player);
                                        mob.detect_collisions(particle);
                                        mob.detect_nearby_entities(particle);
                                }else{
                                        mob.detect_collisions(particle);
                                        mob.detect_nearby_entities(particle);
                                }
                        }
                        return t;
                }
                public bool mob_dedupe_memories(){
                        bool r = false;
                        foreach(Entity mob in Mobiles.get_mobiles()){
                                r = mob.dedupe_and_shrink_nearby_entities();
                        }
                        return r;
                }
                private AutoRect get_hitrect(){
                        return Border;
                }
                private string stringify_hitrect(){
                        string HBSUM = "x:";
                        HBSUM += Border.x().to_string();
                        HBSUM += "y:";
                        HBSUM += Border.y().to_string();
                        HBSUM += "w:";
                        HBSUM += Border.w().to_string();
                        HBSUM += "h:";
                        HBSUM += Border.h().to_string();
                        return HBSUM;
                }
                public int detect_transitions(Entity tmp){
                        int r = 0;
                        message("detect_transitions 0");
                        if(tmp!=null){
                                message("detect_transitions 1");
                                bool TLeftCorner = get_hitrect().in_range(tmp.get_hitbox().tlc());
                                bool TRightCorner = get_hitrect().in_range(tmp.get_hitbox().trc());
                                bool BLeftCorner = get_hitrect().in_range(tmp.get_hitbox().blc());
                                bool BRightCorner = get_hitrect().in_range(tmp.get_hitbox().brc());
                                message("detect_transitions 3");
                                if (TLeftCorner){
                                        r++;
                                        message("Detected transiton, TLC %s", TLeftCorner.to_string());
                                }
                                if (BLeftCorner){
                                        r++;
                                        message("Detected transiton, BLC %s", BLeftCorner.to_string());
                                }
                                if (BRightCorner){
                                        r++;
                                        message("Detected transiton, BRC %s", BLeftCorner.to_string());
                                }
                                if (TRightCorner){
                                        r++;
                                        message("Detected transiton, TRC %s", TRightCorner.to_string());
                                }
                                message("detect_transitions 4");
                        }
                        message("detect_transitions 5");
                        return r;
                }
                public void render_copy(Video.Renderer renderer, AutoPoint player_pos){
			if (visited){
                                foreach(Entity floor in Floor.get_floor()){
					floor.render(renderer, player_pos);
				}
				foreach(Entity particle in Particles.get_particles()){
					particle.render(renderer, player_pos);
				}
			}
                        if (has_player()){
				Player.render(renderer, player_pos);
				if (visited = false){
					visited = true;
				}
                                if(Mobiles.length() > 0){
                                        foreach(Entity mob in Mobiles.get_mobiles()){
                                                mob.render(renderer, player_pos);
                                        }
                                }
			}
		}
		public bool enter_room(Entity player){
                        message("enter_room 0");
			if (player != null){
                                message("    Player entering Rroom.");
				Player = player;
                                visited = true;
			}else{
                                message("    Player staying in room");
                                Player = null;
                                visited = false;
                        }
                        message("enter_room 2");
			return visited;
		}
                public bool mob_enter_room(Entity mob = null){
                        message("mob_enter_room 0");
			if (mob != null){
                                message("    Mob Entering Room.");
				Mobiles.add_mobile(mob);
			}
                        message("mob_enter_room 2");
			return visited;
		}
		public Entity leave_room(int doleave){
                        Entity tmp = null;
                        message("leave_room 0");
                        if (doleave == 4){
                                message("leave_room 1 doleave %s", doleave.to_string());
                                if (Player != null){
                                        message("leave_room 1 player is present");
                                        tmp = Player;
                                        Player = null;
                                }
                        }else if (doleave > 0){
                                message("leave_room 2 doleave %s", doleave.to_string());
                                if (Player != null){
                                        message("leave_room 2 player is present");
                                        tmp = Player;
                                }
                        }
                        message("leave_room 3");
			return tmp;
		}
                public Entity mob_leave_room(int doleave, int mob_index){
                        Entity tmp = null;
                        message("mob_leave_room 0");
                        if (doleave == 4){
                                message("mob_leave_room 1 doleave %s", doleave.to_string());
                                if ( mob_index < Mobiles.length()){
                                        message("mob_leave_room 0");
                                        Entity do_leave = Mobiles.get_mobile(mob_index);
                                        Mobiles.delete_mobile(Mobiles.get_mobile(mob_index));
                                        return do_leave;
                                }
                        }else if (doleave > 0){
                                message("mob_leave_room 2 doleave %s", doleave.to_string());
                                if (mob_index < Mobiles.length()){
                                        message("mob_leave_room 0");
                                        Entity dont_leave = Mobiles.get_mobile(mob_index);
                                        return dont_leave;
                                }
                        }
                        message("mob_leave_room 3");
			return tmp;
		}
	}
}
