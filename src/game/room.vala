using SDL;
using Lua;

namespace LAIR{
	class Room : LuaConf{
		private bool visited = false;
                private Video.Rect Border = Video.Rect(){ x = 0, y = 0, w = 0, h = 0 };
                private FloorList Floor = null;
                private ParticlesList Particles = null;
                private MobilesList Mobiles = null;
                private Entity Player = null;
                private static FileDB GameMaster = null;
                public Room(Video.Rect position, Video.Rect floordims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        set_dimensions(position.x, position.y, position.w, position.h);
                        set_floor_dimensions(floordims);
                        set_name("room("+stringify_hitbox()+"): ");
                        message("generating room%s", get_name());
                        GameMaster = DM;
                        Floor = new FloorList(get_hitbox());
                        Particles = new ParticlesList(get_hitbox());
                        Mobiles = new MobilesList(get_hitbox());
                        lua_push_dimensions(get_hitbox());
                        generate_floor(renderer);
                        message("loading scripts: %s, %s, %s",scripts[0],scripts[1],scripts[2]);
                        generate_particles(renderer);
                        generate_mobiles(scripts[2], renderer);
		}
                public Room.WithPlayer(Video.Rect position, Video.Rect floordims, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0], 2, "room:");
                        set_dimensions(position.x, position.y, position.w, position.h);
                        set_floor_dimensions(floordims);
                        set_name("room ("+stringify_hitbox()+"): ");
                        message("generating room with player");
                        GameMaster = DM;
                        Floor = new FloorList(get_hitbox());
                        Particles = new ParticlesList(get_hitbox());
                        Mobiles = new MobilesList(get_hitbox());
                        lua_push_dimensions(get_hitbox());
                        generate_floor(renderer);
                        generate_particles(renderer);
                        message("loading scripts: %s, %s, %s",scripts[0],scripts[1],scripts[2]);
                        generate_mobiles(scripts[2], renderer);
                        generate_player(scripts[1], renderer);
		}
                private void set_dimensions(int xx, int yy, uint ww, uint hh){
                        Border = Video.Rect(){ x = xx, y = yy, w = ww, h = hh };
                        Border.x = xx;
                        Border.y = yy;
                        Border.w = ww;
                        Border.h = hh;
                }
                private void set_floor_dimensions(Video.Rect floordims){
                        lua_push_uint_to_table("floor_w", "w", (int)floordims.w );
                        lua_push_uint_to_table("floor_h", "h", (int)floordims.h );
                        lua_push_uint_to_table("floor_coarse_w", "w", (int)(floordims.w / 32) );
                        lua_push_uint_to_table("floor_coarse_h", "h", (int)(floordims.h / 32) );
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
                public uint get_w(){     return Border.w;}
                public uint get_h(){     return Border.h;}
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
                private bool point_in_room(AutoPoint point, Video.Rect hitbox){
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
                public int detect_transitions(Entity t){
                        int r = 0;
                        if(t!=null){
                                AutoPoint tlc = new AutoPoint(t.get_hitbox().x,
                                        t.get_hitbox().y );
                                bool TLeftCorner = point_in_room(tlc, get_hitbox());
                                AutoPoint trc = new AutoPoint( (int)(t.get_hitbox().x + t.get_hitbox().w),
                                        t.get_hitbox().y );
                                bool TRightCorner = point_in_room(trc, get_hitbox());
                                AutoPoint blc = new AutoPoint( t.get_hitbox().x,
                                        (int)(t.get_hitbox().y + t.get_hitbox().h) );
                                bool BLeftCorner = point_in_room(blc, get_hitbox());
                                AutoPoint brc = new AutoPoint( (int)(t.get_hitbox().x + t.get_hitbox().w),
                                        (int)(t.get_hitbox().y + t.get_hitbox().h) );
                                bool BRightCorner = point_in_room( brc, get_hitbox());
                                if (TLeftCorner){
                                        r++;
                                }
                                if (BLeftCorner){
                                        r++;
                                }
                                if (BRightCorner){
                                        r++;
                                }
                                if (TRightCorner){
                                        r++;
                                }
                        }
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
			if (player != null){
                                message("    Player Entering Room.");
				Player = player;
                                visited = true;
			}else{
                                Player = null;
                                visited = false;
                        }
			return visited;
		}
                public bool mob_enter_room(Entity mob){
			if (mob != null){
                                message("    Mob Entering Room.");
				Mobiles.add_mobile(mob);
			}
			return visited;
		}
		public Entity leave_room(int doleave){
                        Entity tmp = null;
                        if (doleave == 4){
                                if (Player != null){
                                        tmp = Player;
                                        Player = null;
                                }
                        }else if (doleave > 0){
                                if (Player != null){
                                        tmp = Player;
                                }
                        }
			return tmp;
		}
                public Entity mob_leave_room(int doleave, int mob_index){
                        Entity tmp = null;
                        if (doleave == 4){
                                if ( mob_index < Mobiles.length()){
                                        Entity do_leave = Mobiles.get_mobile(mob_index);
                                        Mobiles.delete_mobile(Mobiles.get_mobile(mob_index));
                                        return do_leave;
                                }
                        }else if (doleave > 0){
                                if (mob_index < Mobiles.length()){
                                        Entity dont_leave = Mobiles.get_mobile(mob_index);
                                        return dont_leave;
                                }
                        }
			return tmp;
		}
	}
}
