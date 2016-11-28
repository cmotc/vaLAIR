using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	class FileDB {
		private List<Image> imgRes = new List<Image>();
		private List<Sound> sndRes = new List<Sound>();
		private List<Fonts> ttfRes = new List<Fonts>();
		private LairFile imgListPath = null;
		private LairFile sndListPath = null;
		private LairFile ttfListPath = null;
		public FileDB(string imgList, string sndList, string ttfList){
			var imgfile = new LairFile.WithPath(imgList);
			stdout.printf("Pre-Loading the game data files.\n");
			if (imgfile.CheckPath()){
				stdout.printf("Pre-Loading the image files(data at %s).\n", imgfile.GetPath());
				imgListPath = imgfile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", imgfile.GetPath());
			}
			var sndfile = new LairFile.WithPath(sndList);
			if (sndfile.CheckPath()){
				stdout.printf("Pre-Loading the sound files(data at %s).\n", sndfile.GetPath());
				sndListPath = sndfile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", sndfile.GetPath());
			}
			var ttffile = new LairFile.WithPath(ttfList);
			if (ttffile.CheckPath()){
				stdout.printf("Pre-Loading the font files(data at %s).\n", ttffile.GetPath());
				ttfListPath = ttffile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", ttffile.GetPath());
			}
			LoadFiles();
		}
		public bool LoadFiles(){
			bool tmp = false;
			if (imgListPath.CheckPath()){
				List<string> imgStrings = imgListPath.LoadLineDelimitedConfig();
				stdout.printf("Loading the image files\n");
				foreach(string image in imgStrings){
					stdout.printf("(%s).\n", image);
					imgRes.append(new Image(image));
				}
				tmp = true;
			}
			if (sndListPath.CheckPath()){
				stdout.printf("Loading the sound files\n");
				List<string> sndStrings = sndListPath.LoadLineDelimitedConfig();
				foreach(string sound in sndStrings){
					stdout.printf("(%s).\n", sound);
					sndRes.append(new Sound(sound));
				}
				tmp = true;
			}
			if (ttfListPath.CheckPath()){
				stdout.printf("Loading the font files\n");
				List<string> ttfStrings = ttfListPath.LoadLineDelimitedConfig();
				foreach(string font in ttfStrings){
					stdout.printf("(%s).\n", font);
					ttfRes.append(new Fonts(font,"medium"));
				}
				tmp = true;
			}
			return tmp;
		}
		public Video.Surface* ImageByName(string name){
			List<Video.Surface*> tmp = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.GetPath() == name){
					tmp.append(file);
				}
			}
			return tmp.nth_data(0);
		}
		public Video.Surface* ImageByTag(string query){
			List<Video.Surface*> tmp = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.HasTag(query)){
					tmp.append(file);
				}
			}
			return tmp.nth_data(0);
		}
	}
}