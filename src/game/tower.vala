using SDL;
namespace LAIR{
	class Tower : Scribe{
		private List<Floor> floors = new List<Floor>();
		public Tower(string size, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.LLL(4, "tower:");
                        int count = 1;
			if (size == "giant"){
				count = 6;
			}else if (size == "large"){
				count = 5;
			}else if (size == "medium"){
				count = 4;
			}else if (size == "small"){
				count = 3;
			}else if (size == "tiny"){
				count = 2;
			}else if (size == "oneroom"){
				count = 1;
			}
                        prints("Building %s-size Tower\n", size);
			for (int c = 0; c <= count-1; c++){
                                prints(" Creating new floor :%s\n", c.to_string());
                                if (c == 0){
                                        floors.append(new Floor.WithPlayer(count, 0, scripts, DM, renderer));
                                }else{
                                        floors.append(new Floor(count, scripts, DM, renderer));
                                }
			}
		}
                public int TakeTurns(){
                        int tmp = 1;
                        prints(" Entities in the tower are taking turns.\n");
                        foreach(Floor floor in floors){
                                tmp = floor.TakeTurns();
                        }
                        return tmp;
                }
                public bool DetectCollisions(){
                        bool tmp = false;
                        foreach(Floor floor in floors){
                                tmp = floor.DetectCollisions() ? true : tmp;
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer renderer){
			foreach(Floor floor in floors){
				floor.RenderCopy(renderer);
			}
		}
	}
}
