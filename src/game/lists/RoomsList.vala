using SDL;
namespace LAIR{
	class RoomsList : LuaConf {
                protected AutoRect floor_dims;
                private unowned Video.Renderer renderer_pointer;
                private unowned FileDB dungeon_master = null;
                protected List<Room> rooms = new List<Room>();
                protected unowned string[] lua_scripts;
                protected AutoRect position_with_offset;
                public RoomsList(string[] scripts, FileDB DM, Video.Renderer? renderer){
                        base(scripts[0]);
                        int count = 2;
                        int width = ((count * 6) * 32);
                        int height = ((count * 6) * 32);
                        dungeon_master = DM;
                        renderer_pointer = renderer;
                        lua_scripts = scripts;
                        floor_dims = new AutoRect(0,0,(width * count),(height * count));
                        position_with_offset = new AutoRect((0*width),(0*height),width,height);
                }
                protected class RoomGenerationThread {

                        public RoomGenerationThread(AutoRect pwo, AutoRect fd, string[] sc, FileDB dm, Video.Renderer? rp, out List<Room> fr, bool wp = false){
                                fr.append(generate_room(pwo, fd, sc, dm, rp, wp));
                        }
                        public Room generate_room(AutoRect pwo, AutoRect fd, string[] sc, FileDB dm, Video.Renderer? rp, bool wp = false){
                                if(wp){
                                        Room r = new Room(pwo, fd, sc, dm, rp);
                                        r.generate_room(true);
                                        return r;
                                }else{
                                        Room r =  new Room(pwo, fd, sc, dm, rp);
                                        r.generate_room();
                                        return r;
                                }
                        }
                }
                protected Room generate_room(AutoRect position_with_offset, bool with_player = false){
                        if(with_player){
                                Room r = new Room(position_with_offset, floor_dims, lua_scripts, dungeon_master, renderer_pointer);
                                r.generate_room(true);
                                return r;
                        }else{
                                Room r =  new Room(position_with_offset, floor_dims, lua_scripts, dungeon_master, renderer_pointer);
                                r.generate_room();
                                return r;
                        }
                }
                protected void append_room(AutoRect position_with_offset, bool with_player = false ){
                        rooms.append(generate_room(position_with_offset, with_player));
                }
                public int generate_new_room(AutoRect position_with_offset){
                        int r = 19231;
                        if(rooms.length() > 0){
                                if(rooms.nth_data(rooms.length() - 1).ingeneration()){
                                        message("Generating new tile in last room: ");
                                        rooms.nth_data(rooms.length() - 1).generate_conditional();
                                }else{
                                        message("Last room generated. Initializing new room: ");
                                        rooms.append(new Room(position_with_offset, floor_dims, lua_scripts, get_dungeon_master(), get_renderer_pointer()));
                                }
                        }
                        return r;
                }
                protected unowned FileDB get_dungeon_master(){
                        return dungeon_master;
                }
                public unowned Video.Renderer get_renderer_pointer(){
                        return renderer_pointer;
                }
        }
}
