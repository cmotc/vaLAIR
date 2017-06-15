using SDL;
namespace LAIR{
	class Floor : LuaConf { //Scribe{
		private List<Room> rooms = new List<Room>();
                //private bool transit = false;
		public Floor(int count, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0]);
                        int width = (((count + 1) * 5) * 32);
                        int height = (((count + 1) * 5) * 32);
                        x_max = width;
                        y_max = height;
                        AutoRect floor_dims = new AutoRect(0,0,(width * count),(height * count));
			for (int x = 0; x < count; x++){
                                for (int y = 0; y < count; y++){
                                        AutoRect position_with_offset = new AutoRect((x*width),(y*height),width,height);
                                        message("Generating room at : x %s y %s w %s h%s", position_with_offset.x().to_string(), position_with_offset.y().to_string(), position_with_offset.w().to_string(), position_with_offset.h().to_string() );
                                        rooms.append(new Room(position_with_offset, floor_dims, scripts, DM, renderer));
                                }
			}
                        lua_do_function("""archive_old_map()""");
		}
		public Floor.WithPlayer(int count, int entry, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0]);
                        int c = 0;
                        int width = (((count + 1) * 5) * 32);
                        int height = (((count + 1) * 5) * 32);
                        AutoRect floor_dims = new AutoRect(0,0,(width * count),(height * count));
			for (int x = 0; x < count; x++){
                                for (int y = 0; y < count; y++){
                                        AutoRect position_with_offset = new AutoRect((x*width),(y*height),width,height);
                                        message("Generating room at : x %s y %s w %s h%s", position_with_offset.x().to_string(), position_with_offset.y().to_string(), position_with_offset.w().to_string(), position_with_offset.h().to_string() );
                                        if (c == entry){
                                                rooms.append(new Room.WithPlayer(position_with_offset, floor_dims, scripts, DM, renderer));
                                        }else{
                                                rooms.append(new Room(position_with_offset, floor_dims, scripts, DM, renderer));
                                        }
                                        c++;
                                }
			}
                        lua_do_function("""archive_old_map()""");
                }
		private bool has_player(){
			bool tmp = false;
			foreach(unowned Room room in rooms){
				tmp = tmp ? tmp : room.has_player();
			}
			return tmp;
		}
                private Entity get_player(){
                        Entity temp = null;
                        foreach(unowned Room room in rooms){
                                if(room.has_player()){
                                        temp = room.get_player();
                                }
                        }
                        return temp;
                }
                private unowned Room get_room_player(){
                        unowned Room temp = null;
                        foreach(unowned Room room in rooms){
                                if(room.has_player()){
                                        temp = room;
                                }
                        }
                        return temp;
                }
                private AutoPoint get_room_player_corner(){
                        AutoPoint r = new AutoPoint(
                                ((get_player().get_x() - (get_room_player().get_w() / 3) > 0) ? (int)((get_player().get_x() - (get_room_player().get_w()/3))) : 0)
                                        ,
                                ((get_player().get_y() - (get_room_player().get_h() / 3) > 0) ? (int)((get_player().get_y() - (get_room_player().get_h()/3))) : 0)
                                );
                        return r;
                }
                public int take_turns(){
                        int tmp = 1;
                        foreach(unowned Room room in rooms){
                                message("   Entities on the floor are taking turns");
                                tmp = room.take_turns();
                        }
                        return tmp;
                }
                public bool detect_collisions(){
                        bool tmp = false;
                        foreach(unowned Room room in rooms){
                                if (!room.has_player()) {
                                        Entity p = get_player();
                                        int s = room.detect_transitions(p);
                                        Entity rm = get_room_player().leave_room(s);
                                        room.enter_room(rm);
                                }else{
                                        tmp = room.player_detect_collisions() ? true : tmp;
                                }
                                int t = 0;
                                foreach(unowned Entity mob in room.get_mobiles()){
                                        foreach(unowned Room room2 in rooms){
                                                if(room2 != room){
                                                        int s = room2.detect_transitions(mob);
                                                        Entity rm = room.mob_leave_room(s, t);
                                                        room2.mob_enter_room(rm);
                                                }
                                        }
                                        room.mob_detect_collisions(mob);
                                        t++;

                                }
                        }
                        return tmp;
                }
                public bool dedupe_memories(){
                        bool r = false;
                        foreach(unowned Room room in rooms){
                                r = room.mob_dedupe_memories();
                        }
                        return r;
                }
                public void render_copy(Video.Renderer renderer){
                        if (has_player()){
                                foreach(unowned Room room in rooms){
                                        room.render_copy(renderer, get_room_player_corner());
                                }
                        }
		}
	}
}
