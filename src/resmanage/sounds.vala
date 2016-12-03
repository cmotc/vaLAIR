using SDL;
using SDLMixer;

namespace LAIR{
	class Sound : LairFile {
                private Music* music;
		public Sound(string path){
                        base.WithPath(path);
                        SoundLoad(path);
		}
                public bool SoundLoad(string path){
                        SetPath(path);
			bool tmp = false;
			if (CheckPath()){
				stdout.printf("Loading the sound to a Music %s \n", path);
				music = new Music(GetPath());
				tmp = true;
			}else{
				stderr.printf("Sound not found at location %s \n", path);
			}
			return tmp;
                }
                public bool CheckSound(){
			if (CheckPath()){
				return true;
			}else{
				return false;
			}
		}
		public Music* GetSound(){
			return music;
		}
	}
}