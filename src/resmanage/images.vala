using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Image : LairFile {
		private Video.Surface surface;
		public Image(string Path){
			base.WithPath(Path);
			ImageLoad(Path);
		}
		public bool ImageLoad(string Path){
			SetPath(Path);
			bool tmp = false;
			if (CheckPath()){
				surface = SDLImage.load(GetPath());
				tmp = true;
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
		public Video.Surface GetImage(){
			return surface;
		}
	}
}