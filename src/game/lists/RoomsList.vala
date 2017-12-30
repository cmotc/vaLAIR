using SDL;
namespace LAIR{
    class RoomsList : LuaConf {
        protected AutoRect floor_dims;
        private unowned Video.Renderer renderer_pointer;
        private unowned FileDB dungeon_master = null;
        protected List<Room> rooms = new List<Room>();
        protected unowned string[] lua_scripts;
        private GLib.ThreadPool<RoomGenerationThread> room_threads;
        protected static int count = 2;
        protected static int width = ((count * 6) * 32);
        protected static int height = ((count * 6) * 32);
        public RoomsList(string[] scripts, FileDB DM, Video.Renderer? renderer){
            base(scripts[0]);
            //position_with_offset = new AutoRect((0*width),(0*height),width,height);
            floor_dims = new AutoRect(0,0,(width * count),(height * count));
            lua_scripts = scripts;
            dungeon_master = DM;
            renderer_pointer = renderer;
            try {
                room_threads = new ThreadPool<RoomGenerationThread>.with_owned_data ((thread) => {
                    thread.generate_room(room_select(), floor_dims, lua_scripts, dungeon_master, renderer_pointer);
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
        public int generate_new_room(bool with_player = false){
            AutoRect positon_with_offset = room_select();
            generate_room_thread(positon_with_offset);
            int r = 1692;
            return r;
        }
        public int generate_room_loop(){
            return 1692;
        }
        public AutoRect room_select(bool with_player = false){
            AutoRect r = null;
            if (with_player) {
                r = new AutoRect((0*width),(0*height),width,height);
            }else{
                if (get_room_player() == null){
                    r = new AutoRect((0*width),(0*height),width,height);
                }else{
                    r = get_room_player().rect_select();
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
