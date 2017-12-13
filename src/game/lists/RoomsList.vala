using SDL;
namespace LAIR{
    class RoomsList : LuaConf {
        protected AutoRect floor_dims;
        private unowned Video.Renderer renderer_pointer;
        private unowned FileDB dungeon_master = null;
        protected List<Room> rooms = new List<Room>();
        protected unowned string[] lua_scripts;
        protected AutoRect position_with_offset;
        private GLib.ThreadPool<RoomGenerationThread> room_threads;
        public RoomsList(string[] scripts, FileDB DM, Video.Renderer? renderer){
            base(scripts[0]);
            int count = 2;
            int width = ((count * 6) * 32);
            int height = ((count * 6) * 32);
            position_with_offset = new AutoRect((0*width),(0*height),width,height);
            floor_dims = new AutoRect(0,0,(width * count),(height * count));
            lua_scripts = scripts;
            dungeon_master = DM;
            renderer_pointer = renderer;
            try {
                room_threads = new ThreadPool<RoomGenerationThread>.with_owned_data ((thread) => {
                    thread.generate_room(position_with_offset, floor_dims, lua_scripts, dungeon_master, renderer_pointer);
                }, 2, false);
            } catch (ThreadError e) {
                message("ThreadError: %s\n", e.message);
            }
        }
        protected class RoomGenerationThread {
            public RoomGenerationThread(AutoRect pwo, AutoRect fd, string[] sc, FileDB dm, Video.Renderer? rp, out List<Room> fr, bool wp = false){
                fr.append(generate_room(pwo, fd, sc, dm, rp, wp));
                GLib.Thread.usleep (10000);
            }
            public Room generate_room(AutoRect pwo, AutoRect fd, string[] sc, FileDB dm, Video.Renderer? rp, bool wp = false){
                Room r =  new Room(pwo, fd, sc, dm, rp, wp);
                return r;
            }
        }
        protected void generate_room_thread(AutoRect position_with_offset, bool with_player = false){
            try {
                room_threads.add(new RoomGenerationThread(position_with_offset, floor_dims, lua_scripts, dungeon_master, renderer_pointer, out rooms, with_player));
            }catch (ThreadError e) {
                message("ThreadError: %s\n", e.message);
            }
        }
        public int generate_new_room(AutoRect position_with_offset, bool with_player = false){
            int r = 19231;
            if(rooms.length() > 0){
                if(rooms.nth_data(rooms.length() - 1).ingeneration()){
                    message("Generating new tile in last room: ");
                    rooms.nth_data(rooms.length() - 1).generate_conditional();
                }else{
                    message("Last room generated. Initializing new room: ");
                    generate_room_thread(position_with_offset, with_player);
                }
            }
            return r;
        }
        public unowned Room get_room_player(){
            unowned Room temp = null;
            foreach(unowned Room room in rooms){
                if(room.has_player()){
                    temp = room;
                }
            }
            return temp;
        }
        /*protected unowned FileDB get_dungeon_master(){
            return dungeon_master;
        }
        public unowned Video.Renderer get_renderer_pointer(){
            return renderer_pointer;
        }*/
    }
}
