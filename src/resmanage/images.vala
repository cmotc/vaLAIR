using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Image : LairFile {
		private Video.Surface surface;
		public Image(string Path){
			base.WithPath(Path);
			Load();
		}
                public bool Load(){
			bool tmp = false;
			if (CheckPath()){
				stdout.printf("Loading the Image to a Surface %s \n", GetPath());
				surface = SDLImage.load(GetPath());
				tmp = true;
			}else{
				stderr.printf("Image not found at location %s \n", GetPath());
			}
			return tmp;
		}
		public bool ImageLoad(string Path){
			SetPath(Path);
			bool tmp = false;
			if (CheckPath()){
				stdout.printf("Loading the Image to a Surface %s \n", GetPath());
				surface = SDLImage.load(GetPath());
				tmp = true;
			}else{
				stderr.printf("Image not found at location %s \n", GetPath());
			}
			return tmp;
		}
		public bool CheckImage(){
			if (CheckPath()){
				return true;
			}else{
				return false;
			}
		}
		public Video.Surface* GetImage(){
                        Video.Surface* tmp = surface;
			return tmp;
		}
	}
}