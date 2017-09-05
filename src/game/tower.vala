using SDL;
namespace LAIR{
	class Tower : Dice{
		private List<Floor> floors = new List<Floor>();
                unowned Video.Renderer renderer_pointer;
                unowned FileDB dungeonmaster_pointer;
                private int size_number = 2;
                string[] scripts_cache;
		public Tower(string size, string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base("room_roller");
                        renderer_pointer = renderer;
                        dungeonmaster_pointer = DM;
                        scripts_cache = scripts;
                        size_number = 2;
                        switch (size){
                                case "giant":
                                        size_number = 6; break;
                                case "large":
                                        size_number = 5; break;
                                case "medium":
                                        size_number = 4; break;
                                case "small":
                                        size_number = 3; break;
                                case "tiny":
                                        size_number = 2; break;
                                case "oneroom":
                                        size_number = 1; break;
                        }
                        message("Building %s-size Tower, %s floors", size, size_number.to_string());
			for (int c = 0; c <= size_number-1; c++){
                                message(" Creating new floor :%s", c.to_string());
                                if (c == 0){
                                        append_floor(true);
                                }else{
                                        append_floor(false);
                                }
			}
		}
                private Floor generate_floor(bool has_player){
                        Floor tmp = has_player ? new Floor.WithPlayer(
                                        size_number,
                                        0,
                                        scripts_cache,
                                        dungeonmaster_pointer,
                                renderer_pointer) : new Floor(
                                        size_number,
                                        scripts_cache,
                                        dungeonmaster_pointer,
                                renderer_pointer);
                        return tmp;
                }
                private void append_floor(bool has_player){
                        floors.append(generate_floor(has_player));
                }
                public int take_turns(){
                        int tmp = 1;
                        message(" Entities in the tower are taking turns.");
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
