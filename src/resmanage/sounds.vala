using SDL;
using SDLMixer;

namespace LAIR{
	class Sound : LairFile {
                private Music music;
		public Sound(string path){
                        base.WithPath(path);
                        Load();
		}
                public Sound.WithAttList(List<string> path){
                        base.WithAttList(path);
                        Load();
		}
                public bool Load(){
                        bool tmp = false;
			if (CheckPath()){
				prints("Loading the sound to a Music %s \n", GetPath());
				music = new Music(GetPath());
				tmp = true;
			}else{
				prints("Sound not found at location %s \n", GetPath());
			}
			return tmp;
                }
                /*public bool SoundLoad(string path){
                        SetPath(path);
			bool tmp = false;
			if (CheckPath()){
				prints("Loading the sound to a Music %s \n", GetPath());
				music = new Music(GetPath());
				tmp = true;
			}else{
				prints("Sound not found at location %s \n", GetPath());
			}
			return tmp;
                }
                public bool CheckSound(){
			if (CheckPath()){
				return true;
			}else{
				return false;
			}
		}*/
		public Music* GetSound(){
                        Music* tmp = music;
			return tmp;
		}
	}
}
