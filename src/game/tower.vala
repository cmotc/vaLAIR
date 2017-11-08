using SDL;
namespace LAIR{
	class Tower : Dice{
		private List<Floor> floors = new List<Floor>();
                private unowned Video.Renderer renderer_pointer;
                private unowned FileDB dungeon_master = null;
                private unowned string[] scripts;
                private bool floors_init = false;
                private int size = 3;
                private int get_size(){
                        return size + 2;
                }
		public Tower(string[] lua_scripts, FileDB DM, Video.Renderer? renderer){
                        base("room_roller");
                        size = roll_dice(2, 5);
                        renderer_pointer = renderer;
                        dungeon_master = DM;
                        scripts = lua_scripts;
                        message("Building Tower, %s floors", floors.length().to_string());
                        append_floor(true);
                        floors_init = true;
		}
                private Floor generate_floor(bool has_player){
                        Floor tmp = new Floor(
                                        scripts,
                                        size,
                                        dungeon_master,
                                renderer_pointer);
                        return tmp;
                }
                private void append_floor(bool has_player){
                        floors.append(generate_floor(has_player));
                        message(" Creating new floor :%s", floors.length().to_string());
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
                public int generate_more_stuff(){
                        int r = 19230;
                        if (floor_has_player() != null){
                                if (floor_has_player().length() > 0){
                                        if ( floor_has_player().length() < floor_has_player().visited() + 16 ){
                                                r = floor_has_player().generate_new_room();
                                        }
                                }
                        }
                        return r;
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
                public unowned Floor floor_has_player(){
                        int r = 0;
                        if(floors_init){
                                foreach( Floor floor in floors ){
                                        if( floor.has_player() ){
                                                break;
                                        }
                                        r++;
                                }
                        }
                        unowned Floor ret = floors.nth_data(r);
                        return ret;
                }
	}
}
