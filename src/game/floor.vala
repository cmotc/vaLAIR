using SDL;
namespace LAIR{
	class Floor : Scribe{
		private List<Room> rooms = new List<Room>();
		public Floor(int count, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.LLL(4, "floor:");
                        int width = (((count + 1) * 5) * 32);
                        int height = (((count + 1) * 5) * 32);
                        Video.Rect FloorDims = Video.Rect(){
                                x = 0,
                                y = 0,
                                w = (width * count),
                                h = (height * count)};
			for (int x = 0; x < count; x++){
                                for (int y = 0; y < count; y++){
                                        Video.Rect XYOffset = Video.Rect(){x = (x*width), y = (y*height), w = width, h = height};
                                        rooms.append(new Room(XYOffset, FloorDims, scripts, DM, renderer));
                                }
			}
		}
		public Floor.WithPlayer(int count, int entry, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.LLL(3, "floor:");
                        int c = 0;
                        int width = (((count + 1) * 5) * 32);
                        int height = (((count + 1) * 5) * 32);
                        Video.Rect FloorDims = Video.Rect(){
                                x = 0,
                                y = 0,
                                w = (width * count) ,
                                h = (height * count) };
			for (int x = 0; x < count; x++){
                                for (int y = 0; y < count; y++){
                                        Video.Rect XYOffset = Video.Rect(){x = (x*width), y = (y*height), w = width, h = height};
                                        if (c == entry){
                                                rooms.append(new Room.WithPlayer(XYOffset, FloorDims, scripts, DM, renderer));
                                        }else{
                                                rooms.append(new Room(XYOffset, FloorDims, scripts, DM, renderer));
                                        }
                                        c++;
                                }
			}
                }
		private bool has_player(){
			bool tmp = false;
			foreach(Room room in rooms){
				tmp = tmp ? tmp : room.has_player();
			}
			return tmp;
		}
                private Entity get_player(){
                        Entity temp = null;
                        foreach(Room room in rooms){
                                if(room.has_player()){
                                        temp = room.get_player();
                                }
                        }
                        return temp;
                }
                private Room get_room_player(){
                        Room temp = null;
                        foreach(Room room in rooms){
                                if(room.has_player()){
                                        temp = room;
                                }
                        }
                        return temp;
                }
                private Video.Point get_room_player_corner(){
                        Video.Point r = Video.Point(){
                                x = ((get_player().get_x() - (get_room_player().get_w() / 3)) > 0) ?
                                        (int)(get_player().get_x() - (get_room_player().get_w()/3)) :
                                        0,
                                y = ((get_player().get_y() - (get_room_player().get_h() / 3)) > 0) ?
                                        (int)(get_player().get_y() - (get_room_player().get_h()/3)) :
                                        0
                        };
                        return r;
                }
                public int take_turns(){
                        int tmp = 1;
                        foreach(Room room in rooms){
                                print_withname("   Entities on the floor are taking turns\n");
                                tmp = room.take_turns();
                        }
                        return tmp;
                }
                public bool detect_collisions(){
                        bool tmp = false;
                        foreach(Room room in rooms){
                                tmp = room.detect_collisions() ? true : tmp;
                                if (!room.has_player()) {
                                        bool transit = room.detect_transitions(get_player());
                                        if (transit) {
                                                room.enter_room(get_room_player().leave_room(transit));
                                        }
                                }
                        }
                        return tmp;
                }
                public void render_copy(Video.Renderer renderer){
                        if (has_player()){
                                foreach(Room room in rooms){
                                        room.render_copy(renderer, get_room_player_corner());
                                }
                        }
		}
	}
}
