using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	class Image : LairFile {
		private Video.Surface surface;
		public Image(string Path){
			base.WithPath(Path);
			load();
		}
                public Image.WithAttList(List<string> atts){
                        base.WithAttList(atts);
                        load();
                }
                public bool load(){
			bool tmp = false;
			if (check_path()){
				message("Loading the Image to a Surface %s", get_path());
				surface = SDLImage.load(get_path());
				tmp = true;
			}else{
				message("Image not found at location %s", get_path());
			}
			return tmp;
		}
		public Video.Surface* get_image(){
			return surface;
		}
	}
}
