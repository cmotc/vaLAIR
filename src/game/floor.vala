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
		private bool HasPlayer(){
			bool tmp = false;
			foreach(Room room in rooms){
				tmp = tmp ? tmp : room.HasPlayer();
			}
			return tmp;
		}
                private Entity GetPlayer(){
                        Entity temp = null;
                        foreach(Room room in rooms){
                                if(room.HasPlayer()){
                                        temp = room.GetPlayer();
                                }
                        }
                        return temp;
                }
                private Room GetPlayerRoom(){
                        Room temp = null;
                        foreach(Room room in rooms){
                                if(room.HasPlayer()){
                                        temp = room;
                                }
                        }
                        return temp;
                }
                private Video.Point GetPlayerRoomCorner(){
                        Video.Point r = Video.Point(){
                                x = ((GetPlayer().GetX() - (GetPlayerRoom().GetW() / 3)) > 0) ?
                                        (int)(GetPlayer().GetX() - (GetPlayerRoom().GetW()/3)) :
                                        0,
                                y = ((GetPlayer().GetY() - (GetPlayerRoom().GetH() / 3)) > 0) ?
                                        (int)(GetPlayer().GetY() - (GetPlayerRoom().GetH()/3)) :
                                        0
                        };
                        return r;
                }
                public int TakeTurns(){
                        int tmp = 1;
                        foreach(Room room in rooms){
                                prints("   Entities on the floor are taking turns\n");
                                tmp = room.TakeTurns();
                        }
                        return tmp;
                }
                public bool DetectCollisions(){
                        bool tmp = false;
                        foreach(Room room in rooms){
                                tmp = room.DetectCollisions() ? true : tmp;
                                if (!room.HasPlayer()) {
                                        bool transit = room.DetectTransition(GetPlayer());
                                        if (transit) {
                                                room.EnterRoom(GetPlayerRoom().LeaveRoom(transit));
                                        }
                                }
                        }
                        return tmp;
                }
                public void RenderCopy(Video.Renderer renderer){
                        if (HasPlayer()){
                                foreach(Room room in rooms){
                                        room.RenderCopy(renderer, GetPlayerRoomCorner());
                                }
                        }
		}
	}
}
