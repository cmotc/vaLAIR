using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	class Image : LairFile {
		private Video.Surface surface;
		public Image(string Path){
			base.WithPath(Path);
			Load();
		}
                public Image.WithAttList(List<string> atts){
                        base.WithAttList(atts);
                        Load();
                }
                public bool Load(){
			bool tmp = false;
			if (CheckPath()){
				prints("Loading the Image to a Surface %s \n", GetPath());
				surface = SDLImage.load(GetPath());
				tmp = true;
			}else{
				prints("Image not found at location %s \n", GetPath());
			}
			return tmp;
		}
		/*public bool ImageLoad(string Path){
			SetPath(Path);
			bool tmp = false;
			if (CheckPath()){
				prints("Loading the Image to a Surface %s \n", GetPath());
				surface = SDLImage.load(GetPath());
				tmp = true;
			}else{
				prints("Image not found at location %s \n", GetPath());
			}
			return tmp;
		}*/
		public Video.Surface* GetImage(){
			return surface;
		}
	}
}
