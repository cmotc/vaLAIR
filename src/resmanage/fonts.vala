using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Fonts : LairFile {
		private SDLTTF.Font* font;
		private string Size;
		public Fonts(string path, string size){
			base.WithPath(path);
			Size = size;
			FontLoad(path);
		}
		private bool FontLoad(string path){
			bool tmp = false;
			SetPath(path);
			if (CheckPath()){
				int sz = 12;
				if (Size == "giant"){
					sz = 28;
				}else if (Size == "large"){
					sz = 20;
				}else if (Size == "medium"){
					sz = 12;
				}else if (Size == "small"){
					sz = 10;
				}else if (Size == "tiny"){
					sz = 8;
				}else {
					sz = 12;
				}
				font = new SDLTTF.Font(path, sz);
				tmp = true;
			}
			return tmp;
		}
		public SDLTTF.Font* GetFont(){
			return font;
		}
	}
}