using SDL;
using SDLImage;
using SDLGraphics;
using SDLMixer;
using SDLTTF;

namespace LAIR{
	class FileDB : Scribe {
		private List<Image> imgRes = new List<Image>();
		private List<Sound> sndRes = new List<Sound>();
		private List<Fonts> ttfRes = new List<Fonts>();
		private LairFile imgListPath = null;
		private LairFile sndListPath = null;
		private LairFile ttfListPath = null;
                private List<List<string>> BodyParts = new List<List<string>>();
                private GLib.Rand Sorcerer = new GLib.Rand();
		public FileDB(string imgList, string sndList, string ttfList){
                        base.LLL(4, "filedb:");
			var imgfile = new LairFile.WithPath(imgList);
			prints("Pre-Loading the game data files.\n");
			if (imgfile.CheckPath()){
				prints("Pre-Loading the image files(data at %s).\n", imgfile.GetPath());
				imgListPath = imgfile;
			}else{
				prints("File '%s' doesn't exist.\n", imgfile.GetPath());
			}
			var sndfile = new LairFile.WithPath(sndList);
			if (sndfile.CheckPath()){
				prints("Pre-Loading the sound files(data at %s).\n", sndfile.GetPath());
				sndListPath = sndfile;
			}else{
				prints("File '%s' doesn't exist.\n", sndfile.GetPath());
			}
			var ttffile = new LairFile.WithPath(ttfList);
			if (ttffile.CheckPath()){
				prints("Pre-Loading the font files(data at %s).\n", ttffile.GetPath());
				ttfListPath = ttffile;
			}else{
				prints("File '%s' doesn't exist.\n", ttffile.GetPath());
			}
			LoadFilesWithTags();
                        InitBodyVars();
		}
                private void InitBodyVars(){
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(0).append("head");
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(1).append("arms"); BodyParts.nth_data(1).append("left");
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(2).append("arms"); BodyParts.nth_data(2).append("right");
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(3).append("body");
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(4).append("leg"); BodyParts.nth_data(4).append("left");
                        BodyParts.append(new List<string>());
                        BodyParts.nth_data(5).append("leg");BodyParts.nth_data(5).append("right");
                }
                public bool LoadFilesWithTags(){
			bool tmp = false;
			if (imgListPath.CheckPath()){
				prints("Loading the image files\n");
                                for (int x = 0; x < imgListPath.LenLineDelimitedConfig(); x++){
                                        List<string> image = imgListPath.GetConfigLine(x);
                                        foreach(string y in image){
                                                prints("(%s)", y);
                                        }
                                        prints(".\n");
					imgRes.append(new Image.WithAttList(image));
                                }
				tmp = true;
			}else{
				tmp = false;
			}
			if (sndListPath.CheckPath()){
				prints("Loading the sound files\n");
                                for (int x = 0; x < sndListPath.LenLineDelimitedConfig(); x++){
                                        List<string> sound = sndListPath.GetConfigLine(x);
                                        foreach(string y in sound){
                                                prints("(%s)", y);
                                        }
                                        prints(".\n");
					sndRes.append(new Sound.WithAttList(sound));
                                }
				tmp = true;
			}else{
				tmp = false;
			}
			if (ttfListPath.CheckPath()){
				prints("Loading the font files\n");
                                for (int x = 0; x < ttfListPath.LenLineDelimitedConfig(); x++){
                                        List<string> font = ttfListPath.GetConfigLine(x);
                                        foreach(string y in font){
                                                prints("(%s)", y);
                                        }
                                        prints(".\n");
					ttfRes.append(new Fonts.WithAttList(font, "medium"));
                                }
				tmp = true;
			}else{
				tmp = false;
			}
			return tmp;
		}
                /*public int GetImagesLength(){
                        return (int) imgRes.length();
                }*/
                public int GetSoundsLength(){
                        return (int) sndRes.length();
                }
                public int GetFontsLength(){
                        return (int) ttfRes.length();
                }
                private int GetRandomSoundIndex(){
                        int tmp = int_range(0, GetSoundsLength());
                        prints("Random Sound from Index # %s \n", tmp.to_string());
                        return tmp;
                }
                private int GetRandomFontIndex(){
                        int tmp = int_range(0, GetFontsLength());
                        prints("Random Font from Index #: %s \n", tmp.to_string());
                        return tmp;
                }
                public Music* GetRandSound(){
                        return sndRes.nth_data(GetRandomSoundIndex()).GetSound();
                }/*
                public Music* GetRandSoundByRange(int bottom, int top){
                        return sndRes.nth_data(GetRandomSoundIndexByRange(bottom,top)).GetSound();
                }*/
                public SDLTTF.Font* GetRandFont(){
                        return ttfRes.nth_data(GetRandomFontIndex()).GetFont();
                }/*
                public SDLTTF.Font* GetRandFontByRange(int bottom, int top){
                        return ttfRes.nth_data(GetRandomFontIndexByRange(bottom, top)).GetFont();
                }*/
                public List<Video.Surface*> ImageByName(string name){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.HasName(name)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
                        prints("Emitting random image from index #: %s \n", tmp.nth_data(index).to_string() );
			r.append(imgRes.nth_data(tmp.nth_data(index)).GetImage());
                        return r;
		}
                /*public List<Video.Surface*> ImageByTag(string tag){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.HasTag(tag)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
                        prints("Emitting random image from index #: %s \n", tmp.nth_data(index).to_string() );
			r.append(imgRes.nth_data(tmp.nth_data(index)).GetImage());
                        return r;
		}*/
                private Video.Surface* ImageByTagList(List<string> tagList){
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
                                if (file.HasTagList(tagList)){
                                        r.append(file.GetImage());
                                }
			}
                        int top = (int) r.length();
                        int index = int_range(0, top);
                        prints("Emitting random image from subindex #: %s \n:", index.to_string() );
                        return r.nth_data(index);
		}
                public List<Video.Surface*> SingleImageByTagList(List<string> tagList){
                        List<Video.Surface*> r = new List<Video.Surface*>();
                        r.append(ImageByTagList(tagList));
                        return r;
                }
                /*public List<Video.Surface*> ImageListByName(string name, int num){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.HasName(name)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        for (int i = 0; i < num; i++){
                                int index = int_range(0, top);
                                prints("Emitting random image from index #: %s \n", tmp.nth_data(index).to_string() );
                                r.append(imgRes.nth_data(tmp.nth_data(index)).GetImage());
                        }
			return r;
		}*/
                /*public List<Video.Surface*> ImageListByTag(string tag, int num){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.HasTag(tag)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        for (int i = 0; i < num; i++){
                                int index = int_range(0, top);
                                prints("Emitting random image from index #: %s \n", tmp.nth_data(index).to_string() );
                                r.append(imgRes.nth_data(tmp.nth_data(index)).GetImage());
                        }
			return r;
		}*/
                //public List<Video.Surface*> BodyByTone(string tone){}
                public List<Video.Surface*> BodyByTone(string tone){
                        List<Video.Surface*> r = new List<Video.Surface*>();
                        foreach(unowned List<string> part in BodyParts.copy()){
                                part.append(tone);
                                r.append(ImageByTagList(part));
                        }
			return r;
                }
                //public List<Video.Surface*> BodyByTagList(List<string> query){
                //}
                /*public Music* SoundByName(string name){
			List<Music*> tmp = new List<Music*>();
			foreach (Sound file in sndRes){
				if (file.HasName(name)){
					tmp.append(file.GetSound());
				}
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
			return tmp.nth_data(index);
		}
		public Music* SoundByTag(string query){
			List<Music*> tmp = new List<Music*>();
			foreach (Sound file in sndRes){
				if (file.HasTag(query)){
					tmp.append(file.GetSound());
				}
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
			return tmp.nth_data(0);
		}
                public SDLTTF.Font* FontByName(string name){
			List<SDLTTF.Font*> tmp = new List<SDLTTF.Font*>();
			foreach (Fonts file in ttfRes){
				if (file.GetPath() == name){
					tmp.append(file.GetFont());
				}
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
			return tmp.nth_data(index);
		}
		public SDLTTF.Font* FontByTag(string query){
			List<SDLTTF.Font*> tmp = new List<SDLTTF.Font*>();
			foreach (Fonts file in ttfRes){
				if (file.HasTag(query)){
					tmp.append(file.GetFont());
				}
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
			return tmp.nth_data(0);
		}*/
                public int int_range(int low, int high){
                        return Sorcerer.int_range(low, high);
                }
	}
}
