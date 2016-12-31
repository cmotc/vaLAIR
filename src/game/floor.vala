using SDL;
namespace LAIR{
	class Floor : Scribe{
		private List<Room> rooms = new List<Room>();
		public Floor(int width, int height, int count, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.LLL(5);
			for (int x = 1; x <= count; x++){
                                for (int y = 1; y <= count; y++){
                                        int [2] xyo = {(x*width)-width, (y*height)-height};
                                        prints("<< generating room\n");
                                        rooms.append(new Room(width, height, scripts, DM, renderer, xyo));
                                }
			}
		}
		public Floor.WithPlayer(int width, int height, int count, int entry, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.LLL(5);
                        int c = 0;
			for (int x = 1; x <= count; x++){
                                for (int y = 1; y <= count; y++){
                                        int [2] xyo = {(x*width)-width, (y*height)-height};
                                        prints("<< count %s \n", c.to_string());
                                        if (c == entry){
                                                prints("<< generating room with player\n");
                                                rooms.append(new Room.WithPlayer(width, height, scripts, DM, renderer, xyo));
                                        }else{
                                                prints("<< generating room\n");
                                                rooms.append(new Room(width, height, scripts, DM, renderer, xyo));
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
                                        room.RenderCopy(renderer);
                                }
                        }
		}
	}
}
