using SDL;

namespace LAIR{
	class Tower : Dice{
		private List<Level> levels = new List<Level>();
        private unowned Video.Renderer renderer_pointer;
        private unowned FileDB dungeon_master = null;
        private unowned string[] scripts;
        private bool levels_init = false;
        private int size = 3;
        private GLib.ThreadPool<LevelGenerationThread> level_threads;
        private int get_size(){
            return size + 2;
        }
		public Tower(string[] lua_scripts, FileDB DM, Video.Renderer? renderer){
            base(lua_scripts[0]);
            size = roll_dice(2, 5);
            renderer_pointer = renderer;
            dungeon_master = DM;
            scripts = lua_scripts;
            message("Building Tower, %s levels", levels.length().to_string());
            append_level(true);
            levels_init = true;
            try {
                level_threads = new ThreadPool<LevelGenerationThread>.with_owned_data ((thread) => {
                    thread.generate_level(lua_scripts, size, dungeon_master, renderer_pointer);
                }, 4, false);
            } catch (ThreadError e) {
                message("ThreadError: %s\n", e.message);
            }
		}
        public class LevelGenerationThread{
            public LevelGenerationThread(string[] sc, int sz, FileDB dm, Video.Renderer rp, out List<Level> ll, bool hp=false){
                ll.append(generate_level(sc, sz, dm, rp, hp));
                GLib.Thread.usleep(500000);
            }
            public Level generate_level(string[] sc, int sz, FileDB dm, Video.Renderer rp, bool hp=false){
                Level tmp = new Level( sc, sz, dm, rp);
                return tmp;
            }
        }
        private Level generate_level(bool has_player){
            Level tmp = new Level(
                    scripts,
                    size,
                    dungeon_master,
                renderer_pointer);
            return tmp;
        }
        public void append_level_thread(bool has_player = false){
            try {
                level_threads.add(new LevelGenerationThread(scripts, size, dungeon_master, renderer_pointer, out levels, has_player));
            }catch (ThreadError e) {
                message("ThreadError: %s\n", e.message);
            }
        }
        private void append_level(bool has_player){
            levels.append(generate_level(has_player));
            message(" Creating new level :%s", levels.length().to_string());
        }
        public int grow_a_level(){
            if (levels.length() + level_threads.get_num_threads() + (get_size() -(levels.length() + level_threads.get_num_threads()) ) < get_size()) {
                append_level_thread(false);
            }
            message("Completed levels: %s", get_size().to_string());
            message("Potential levels: %s", levels.length().to_string());
            return get_size() + (int) levels.length();
        }
        public int take_turns(){
            int tmp = 1;
            message(" Entities in the tower are taking turns.");
            foreach(Level level in levels){
                tmp = level.take_turns();
            }
            return tmp;
        }
        public bool detect_collisions(){
            bool tmp = false;
            foreach(Level level in levels){
                tmp = level.detect_collisions() ? true : tmp;
            }
            return tmp;
        }
        public unowned Level level_has_player(){
            int r = 0;
            if(levels_init){
                foreach( Level level in levels ){
                    if( level.has_player() ){
                        break;
                    }
                    r++;
                }
            }
            unowned Level ret = levels.nth_data(r);
            return ret;
        }
        public bool dedupe_memories(){
            bool r = false;
            foreach(Level level in levels){
                r = level.dedupe_memories();
            }
            return r;
        }
		public void render_copy(Video.Renderer renderer){
			foreach(Level level in levels){
				level.render_copy(renderer);
			}
		}
	}
}
