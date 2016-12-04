using SDL;
namespace LAIR{
	class Floor : Object{
		private List<Room> rooms = new List<Room>();
		public Floor(int width, int height, int count, FileDB* DM, Video.Renderer? renderer){
			for (int c = 0; c <= count; c++){
				rooms.append(new Room(width, height, DM, renderer));
			}
		}
		public Floor.WithPlayer(int width, int height, int count, int entry, Entity* player, FileDB* DM, Video.Renderer? renderer){
			for (int c = 0; c <= count; c++){
				if (count == entry){
					Room tmp = new Room(width, height, DM, renderer);
					rooms.append(tmp);
				}else{
					Room tmp = new Room.WithPlayer(width, height, player, DM, renderer);
					rooms.append(tmp);
				}
			}
		}
		private bool HasPlayer(){
			bool tmp = false;
			foreach(Room room in rooms){
				tmp = room.HasPlayer();
			}
			return tmp;
		}
                public int TakeTurns(){
                        int tmp = 1;
                        foreach(Room room in rooms){
                                room.TakeTurns();
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer* renderer){
			foreach(Room room in rooms){
                                        stdout.printf("Propagating Renderer to Room. \n");
					room.RenderCopy(renderer);
			}
		}
	}
}