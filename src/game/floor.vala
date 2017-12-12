using SDL;
//using Glib
namespace LAIR{
	class Floor : RoomsList {
        private int entry_room = 0;
        private int generator_room = 0;
        private int size = 3;
		public Floor(string[] scripts, int pre_size, FileDB DM, Video.Renderer? renderer){
            base(scripts, DM, renderer);
            size = pre_size * pre_size;
            //entry_room = roll_dice(0, size-1);
            message("Generating room at : x %s y %s w %s h%s", position_with_offset.x().to_string(), position_with_offset.y().to_string(), position_with_offset.w().to_string(), position_with_offset.h().to_string() );
            lua_do_function("""archive_old_map()""");
            generate_room_thread(position_with_offset, insert_player(entry_room));
		}
        public int visited(){
            int r = 0;
            if( &rooms != null){
                foreach (Room room in rooms.copy()){
                    if (room.visited_room()){
                        r++;
                    }
                }
            }
            return r;
        }
        private bool insert_player(int current_count){
            bool r = false;
            message("Current Count: %s ", current_count.to_string());
            if(current_count == entry_room){
                r = true;
                message("Inserting player into room");
            }
            return r;
        }
		public bool has_player(){
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
        public uint length(){
            return rooms.length();
        }
	}
}
