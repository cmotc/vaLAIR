using SDL;
namespace LAIR{
	class Floor : Object{
		private List<Room> rooms = new List<Room>();
		public Floor(int width, int height, int count, FileDB* DM, Video.Renderer? renderer){
			for (int c = 0; c <= count; c++){
				rooms.append(new Room(width, height, DM, renderer));
			}
		}
		public Floor.WithPlayer(int width, int height, int count, int entry, FileDB* DM, Video.Renderer? renderer){
			for (int c = 0; c <= count; c++){
                                stdout.printf("   Generating room:%s\n", c.to_string());
				if (count == entry){
					Room tmp = new Room.WithPlayer(width, height, DM, renderer);
					rooms.append(tmp);
				}else{
					Room tmp = new Room(width, height, DM, renderer);
					rooms.append(tmp);
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
                public int TakeTurns(){
                        int tmp = 1;
                        foreach(Room room in rooms){
                                stdout.printf("   Entities on the floor are taking turns\n");
                                tmp = (tmp != 1) ? tmp : room.TakeTurns();
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer* renderer){
                        stdout.printf("   Rendering Room.\n");
                        foreach(Room room in rooms){
                                room.RenderCopy(renderer);
                        }
		}
	}
}
