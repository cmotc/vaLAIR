using SDL;
using SDLMixer;

namespace LAIR{
	class Sound : LairFile {
                private Music music;
		public Sound(string path){
                        base.WithPath(path);
                        load();
		}
                public Sound.WithAttList(List<string> path){
                        base.WithAttList(path);
                        load();
		}
                public bool load(){
                        bool tmp = false;
			if (check_path()){
				print_withname("Loading the sound to a Music %s \n", get_path());
				music = new Music(get_path());
				tmp = true;
			}else{
				print_withname("Sound not found at location %s \n", get_path());
			}
			return tmp;
                }
		public Music* get_sound(){
                        Music* tmp = music;
			return tmp;
		}
	}
}
