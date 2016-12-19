using SDL;
namespace LAIR{
	class Tower : Object{
		private List<Floor> floors = new List<Floor>();
		public Tower(string size, FileDB DM, Video.Renderer? renderer){
			int w = 320;
			int h = 320;
			int count = 10;
			if (size == "giant"){
				w = 2560;
				h = 2560;
				count = 6;
			}else if (size == "large"){
				w = 1280;
				h = 1280;
				count = 5;
			}else if (size == "medium"){
				w = 640;
				h = 640;
				count = 4;
			}else if (size == "small"){
				w = 480;
				h = 480;
				count = 2;
			}else if (size == "tiny"){
				w = 320;
				h = 320;
				count = 2;
			}
                        stdout.printf("Building %s-size Tower\n", size);
			for (int c = 0; c <= count-1; c++){
                                stdout.printf(" Creating new floor :%s\n", c.to_string());
                                if (c == 0){
                                        floors.append(new Floor.WithPlayer(w, h, count, 0, DM, renderer));
                                }else{
                                        floors.append(new Floor(w, h, count, DM, renderer));
                                }
			}
		}
                public int TakeTurns(){
                        int tmp = 1;
                        stdout.printf(" Entities in the tower are taking turns.\n");
                        foreach(Floor floor in floors){
                                tmp = (tmp != 1) ? tmp : floor.TakeTurns();
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer renderer){
                        stdout.printf(" Rendering Tower.\n");
			foreach(Floor floor in floors){
				floor.RenderCopy(renderer);
			}
		}
	}
}
