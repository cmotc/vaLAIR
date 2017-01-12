using SDL;
using SDLTTF;

namespace LAIR{
	class Fonts : LairFile {
		private SDLTTF.Font font;
		private string Size;
		public Fonts(string path, string size){
			base.WithPath(path);
			Size = size;
			Load();
		}
                public Fonts.WithAttList(List<string> path, string size){
			base.WithAttList(path);
			Size = size;
			Load();
		}
                private bool Load(){
			bool tmp = false;
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
				}
				font = new SDLTTF.Font(GetPath(), sz);
				tmp = true;
			}
			return tmp;
		}
/*		private bool FontLoad(string path){
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
				font = new SDLTTF.Font(GetPath(), sz);
				tmp = true;
			}
			return tmp;
		}
                public bool CheckFont(){
			if (CheckPath()){
				return true;
			}else{
				return false;
			}
		}*/
		public SDLTTF.Font* GetFont(){
                        SDLTTF.Font* tmp = font;
			return tmp;
		}
	}
}
