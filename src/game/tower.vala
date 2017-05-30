using SDL;
namespace LAIR{
	class Tower : Scribe{
		private List<Floor> floors = new List<Floor>();
		public Tower(string size, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base.new_local_attributes(4, "tower:");
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
                        message("Building %s-size Tower\n", size);
			for (int c = 0; c <= count-1; c++){
                                message(" Creating new floor :%s\n", c.to_string());
                                if (c == 0){
                                        floors.append(new Floor.WithPlayer(count, 0, scripts, DM, renderer));
                                }else{
                                        floors.append(new Floor(count, scripts, DM, renderer));
                                }
			}
		}
                public int take_turns(){
                        int tmp = 1;
                        message(" Entities in the tower are taking turns.\n");
                        foreach(Floor floor in floors){
                                tmp = floor.take_turns();
                        }
                        return tmp;
                }
                public bool detect_collisions(){
                        bool tmp = false;
                        foreach(Floor floor in floors){
                                tmp = floor.detect_collisions() ? true : tmp;
                        }
                        return tmp;
                }
                public bool dedupe_memories(){
                        bool r = false;
                        foreach(Floor floor in floors){
                                r = floor.dedupe_memories();
                        }
                        return r;
                }
		public void render_copy(Video.Renderer renderer){
			foreach(Floor floor in floors){
				floor.render_copy(renderer);
			}
		}
	}
}
