using SDL;
namespace LAIR{
	class Floor : Object{
		private List<Room> rooms = new List<Room>();
		public Floor(int width, int height, int count, FileDB DM, Video.Renderer? renderer){
			for (int x = 1; x <= count; x++){
                                for (int y = 1; y <= count; y++){
                                        int [2] xyo = {(x*width)-width, (y*height)-height};
                                        stdout.printf("<< generating room\n");
                                        rooms.append(new Room(width, height, DM, renderer, xyo));
                                }
			}
		}
		public Floor.WithPlayer(int width, int height, int count, int entry, FileDB DM, Video.Renderer? renderer){
                        int c = 0;
			for (int x = 1; x <= count; x++){
                                for (int y = 1; y <= count; y++){
                                        int [2] xyo = {(x*width)-width, (y*height)-height};
                                        stdout.printf("<< count %s \n", c.to_string());
                                        if (c == entry){
                                                stdout.printf("<< generating room with player\n");
                                                rooms.append(new Room.WithPlayer(width, height, DM, renderer, xyo));
                                        }else{
                                                stdout.printf("<< generating room\n");
                                                rooms.append(new Room(width, height, DM, renderer, xyo));
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
                                stdout.printf("   Entities on the floor are taking turns\n");
                                int x = room.TakeTurns();
                                tmp = ( x != 1) ? x : 1;
                        }
                        return tmp;
                }
                public bool DetectCollisions(){
                        bool tmp = false;
                        foreach(Room room in rooms){
                                tmp = room.DetectCollisions() ? true : tmp;
                                //if(HasPlayer()){
                                //        if(room.DetectTransition(GetPlayer())){
                                //                room.EnterRoom(GetPlayerRoom().LeaveRoom());
                                //        }
                                //}
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer renderer){
                        stdout.printf("   Rendering Floor.\n");
                        if (HasPlayer()){
                                foreach(Room room in rooms){
                                        room.RenderCopy(renderer);
                                }
                        }
		}
	}
}
