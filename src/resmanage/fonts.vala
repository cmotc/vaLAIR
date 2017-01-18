using SDL;
using SDLTTF;

namespace LAIR{
	class Fonts : LairFile {
		private SDLTTF.Font font;
		private string Size;
		public Fonts(string path, string size){
			base.WithPath(path);
			Size = size;
			load();
		}
                public Fonts.WithAttList(List<string> path, string size){
			base.WithAttList(path);
			Size = size;
			load();
		}
                private bool load(){
			bool tmp = false;
			if (check_path()){
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
				}
				font = new SDLTTF.Font(get_path(), sz);
				tmp = true;
			}
			return tmp;
		}
		public SDLTTF.Font* get_font(){
                        SDLTTF.Font* tmp = font;
			return tmp;
		}
	}
}
