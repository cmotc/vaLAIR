using SDL;
using SDLImage;
using SDLGraphics;
using SDLMixer;
using SDLTTF;

namespace LAIR{
	class FileDB : Dice {
		private List<Image> imgRes = new List<Image>();
		private List<Sound> sndRes = new List<Sound>();
		private List<Fonts> ttfRes = new List<Fonts>();
		private LairFile imgListPath = null;
		private LairFile sndListPath = null;
		private LairFile ttfListPath = null;
                private List<List<string>> BodyParts = new List<List<string>>();
                private List<string> SoundParts = new List<string>();
                //private Dice Sorcerer = new Dice("immobile");
		public FileDB(string imgList, string sndList, string ttfList){
                        base("immobile");
			var imgfile = new LairFile.WithPath(imgList);
			message("Pre-Loading the game data files.");
			if (imgfile.check_path()){
				message("Pre-Loading the image files(data at %s).", imgfile.get_path());
				imgListPath = imgfile;
			}else{
				message("File '%s' doesn't exist.", imgfile.get_path());
			}
			var sndfile = new LairFile.WithPath(sndList);
			if (sndfile.check_path()){
				message("Pre-Loading the sound files(data at %s).", sndfile.get_path());
				sndListPath = sndfile;
			}else{
				message("File '%s' doesn't exist.", sndfile.get_path());
			}
			var ttffile = new LairFile.WithPath(ttfList);
			if (ttffile.check_path()){
				message("Pre-Loading the font files(data at %s).", ttffile.get_path());
				ttfListPath = ttffile;
			}else{
				message("File '%s' doesn't exist.", ttffile.get_path());
			}
			load_files_with_tags();
                        init_body_vars();
		}
                private void init_body_vars(){
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
                        SoundParts.append("footstep");
                        SoundParts.append("bonk");
                        SoundParts.append("ambient");
                }
                private bool load_files_with_tags(){
			bool tmp = false;
			if (imgListPath.check_path()){
				message("Loading the image files");
                                for (int x = 0; x < imgListPath.len_of_config(); x++){
                                        List<string> image = imgListPath.get_config_line(x);
                                        foreach(string y in image){
                                                message("(%s)", y);
                                        }
                                        message(".");
					imgRes.append(new Image.WithAttList(image));
                                }
				tmp = true;
			}else{
				tmp = false;
			}
			if (sndListPath.check_path()){
				message("Loading the sound files");
                                for (int x = 0; x < sndListPath.len_of_config(); x++){
                                        List<string> sound = sndListPath.get_config_line(x);
                                        foreach(string y in sound){
                                                message("(%s)", y);
                                        }
                                        message(".");
					sndRes.append(new Sound.WithAttList(sound));
                                }
				tmp = true;
			}else{
				tmp = false;
			}
			if (ttfListPath.check_path()){
				message("Loading the font files");
                                for (int x = 0; x < ttfListPath.len_of_config(); x++){
                                        List<string> font = ttfListPath.get_config_line(x);
                                        foreach(string y in font){
                                                message("(%s)", y);
                                        }
                                        message(".");
					ttfRes.append(new Fonts.WithAttList(font, "tiny"));
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
                private int get_sounds_length(){
                        return (int) sndRes.length();
                }
                private int get_fonts_length(){
                        return (int) ttfRes.length();
                }
                private int get_random_sound_index(){
                        int tmp = int_range(0, get_sounds_length());
                        message("Random Sound from Index # %s ", tmp.to_string());
                        return tmp;
                }
                private int get_random_font_index(){
                        int tmp = int_range(0, get_fonts_length());
                        message("Random Font from Index #: %s ", tmp.to_string());
                        return tmp;
                }
                public Music* get_rand_sound(){
                        return sndRes.nth_data(get_random_sound_index()).get_sound();
                }
                public List<Music*> no_sound(){
                        return new List<Music*>();
                }
                public List<Music*> sound_by_name(string name){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Music*> r = new List<Music*>();
			foreach (Sound file in sndRes){
				if (file.has_name(name)){
                                        if(c<2){
                                                message("Name found in FileDB: %s", name);
                                        }
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
                        message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
			r.append(sndRes.nth_data(tmp.nth_data(index)).get_sound());
                        return r;
		}
                public List<Music*> sound_by_tag(string tag){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Music*> r = new List<Music*>();
			foreach (Image file in imgRes){
				if (file.has_tag(tag)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
                        message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
			r.append(sndRes.nth_data(tmp.nth_data(index)).get_sound());
                        return r;
		}
                /*
                public Music* GetRandSoundByRange(int bottom, int top){
                        return sndRes.nth_data(GetRandomSoundIndexByRange(bottom,top)).get_sound();
                }*/
                public SDLTTF.Font* get_rand_font(){
                        return ttfRes.nth_data(get_random_font_index()).get_font();
                }/*
                public SDLTTF.Font* GetRandFontByRange(int bottom, int top){
                        return ttfRes.nth_data(GetRandomFontIndexByRange(bottom, top)).GetFont();
                }*/
                public List<Video.Surface*> image_by_name(string name){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.has_name(name)){
                                        if(c<2){
                                                message("Name found in FileDB: %s", name);
                                        }
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
                        message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
			r.append(imgRes.nth_data(tmp.nth_data(index)).get_image());
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
                        message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
			r.append(imgRes.nth_data(tmp.nth_data(index)).get_image());
                        return r;
		}*/
                private Video.Surface* image_by_tag_list(List<string> tagList){
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
                                if (file.has_tag_list(tagList)){
                                        r.append(file.get_image());
                                }
			}
                        int top = (int) r.length();
                        int index = int_range(0, top);
                        message("Emitting random image from subindex #: %s :", index.to_string() );
                        return r.nth_data(index);
		}
                /*public List<Video.Surface*> ImageListByName(string name, int num){
                        int c = 0;
                        List<int> tmp = new List<int>();
                        List<Video.Surface*> r = new List<Video.Surface*>();
			foreach (Image file in imgRes){
				if (file.has_name(name)){
					tmp.append(c);
				}
                                c++;
			}
                        int top = (int) tmp.length();
                        for (int i = 0; i < num; i++){
                                int index = int_range(0, top);
                                message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
                                r.append(imgRes.nth_data(tmp.nth_data(index)).get_image());
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
                                message("Emitting random image from index #: %s ", tmp.nth_data(index).to_string() );
                                r.append(imgRes.nth_data(tmp.nth_data(index)).get_image());
                        }
			return r;
		}*/
                //public List<Video.Surface*> BodyByTone(string tone){}
                public List<Video.Surface*> body_by_tone(string tone){
                        List<Video.Surface*> r = new List<Video.Surface*>();
                        foreach(unowned List<string> part in BodyParts.copy()){
                                part.append(tone);
                                r.append(image_by_tag_list(part));
                        }
			return r;
                }
                public List<Music*> basic_sounds(){
                        List<Music*> r = new List<Music*>();
                        foreach(string part in SoundParts.copy()){
                                r.append(sound_by_tag(part));
                        }
			return r;
                }
                //public List<Video.Surface*> BodyByTagList(List<string> query){
                //}
                /*public Music* SoundByName(string name){
			List<Music*> tmp = new List<Music*>();
			foreach (Sound file in sndRes){
				if (file.has_name(name)){
					tmp.append(file.get_sound());
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
					tmp.append(file.get_sound());
				}
			}
                        int top = (int) tmp.length();
                        int index = int_range(0, top);
			return tmp.nth_data(0);
		}
                public SDLTTF.Font* FontByName(string name){
			List<SDLTTF.Font*> tmp = new List<SDLTTF.Font*>();
			foreach (Fonts file in ttfRes){
				if (file.get_path() == name){
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
                private int int_range(int low, int high){
                        if(high>low){
                                return roll_dice(low, high);
                        }else{
                                return 0;
                        }
                }
	}
}
