using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	public class Lair {
		private Game GameMap;
                private static string HELP = "<^^>____<^^^>_________<^^^>____<^^>\n || L        A    IIIII RRRRR   ||\n || L       A A     I   R    R  ||\n || L      AAAAA    I   RRRRR   ||\n || LLLLL A     A IIIII R    R  ||\n<vv>___________________________<vv>\n\tThis is a game called LAIR, a free, self-hosted, worldbuilding, procedurally\ngenerated 2D survival RPG. It can be played in a wide variety of ways, as\neverything from a coffee-break roguelike to a political strategy game. The\nfollowing options can be used to configure it at runtime. For more information,\nplease see the manual as soon as I finish writing it.\n\t-i : display this menu\n\t-p : path to the image file listing\n\t-s : path to the sound file listing\n\t-f : path to the fonts file listing\n\t-m : map size(tiny, small, medium, large, giant\n\t-c : path to map generation script\n\t-e : path to character generation script\n\t-a : path to ai library script\n\t-w : screen width\n\t-h : screen height\n";
                private static string ImageFilePath = GetFilePath("lair/images.list");
		private static string SoundFilePath = GetFilePath("lair/sounds.list");
		private static string FontsFilePath = GetFilePath("lair/fonts.list");
                private static string MapGenLua = GetFilePath("lair/demodungeon.lua");
                private static string PlayerConfig = GetFilePath("lair/demoplayer.lua");
                private static string AiConfig = GetFilePath("lair/demoai.lua");
		public Lair(string[] lspt, string[] scrpt, string mapSize, int screenW, int screenH){
                        if (SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL) > 0){
                                //log some shit here.
                        }
                        if (SDLImage.init(SDLImage.InitFlags.PNG) < 0) {
                                //log some more shit.
                        }
			SDLTTF.init();
			GameMap = new Game(lspt, scrpt, mapSize, screenW, screenH);
			GameMap.run();
		}
		~Lair() {
			SDL.quit();
		}
                public static string GetFilePath(string path){
                        var DEFAULT = File.new_for_path("/usr/share/" + path);
                        var TEST = File.new_for_path(Environment.get_user_config_dir() + path);
                        var RETURN = File.new_for_path(path);
                        if (!RETURN.query_exists()){
                                if (TEST.query_exists()){
                                        RETURN = File.new_for_path(TEST.get_path());
                                }else if (DEFAULT.query_exists()){
                                        RETURN = File.new_for_path(DEFAULT.get_path());
                                }
                        }
                        stdout.printf("<%s\n", RETURN.get_path());
                        return RETURN.get_path();
                }
		public static void main(string args[]){
                        ImageFilePath = GetFilePath("lair/images.list");
                        SoundFilePath = GetFilePath("lair/sounds.list");
                        FontsFilePath = GetFilePath("lair/fonts.list");
                        MapGenLua = GetFilePath("lair/demodungeon.lua");
                        PlayerConfig = GetFilePath("lair/demoplayer.lua");
                        AiConfig = GetFilePath("lair/demoai.lua");
			List<string> Arguments = new List<string>();
			string MapSize = "oneroom";
			int PixelW = 800;
			int PixelH = 600;
			foreach(string arg in args){
				Arguments.append(arg);
			}
			for (int index = 0; index < Arguments.length(); index++){
				stdout.printf(Arguments.nth_data(index));
				stdout.printf("\n");
				switch (Arguments.nth_data(index)){
                                        case "-i":
                                                stdout.printf(HELP);
						break;
					case "-p":
						ImageFilePath = GetFilePath(Arguments.nth_data(index+1));
						break;
					case "-s":
						SoundFilePath = GetFilePath(Arguments.nth_data(index+1));
						break;
					case "-f":
						FontsFilePath = GetFilePath(Arguments.nth_data(index+1));
						break;
					case "-m":
						MapSize = GetFilePath(Arguments.nth_data(index+1));
						break;
                                        case "-c":
                                                MapGenLua = GetFilePath(Arguments.nth_data(index+1));
						break;
                                        case "-e":
                                                PlayerConfig = GetFilePath(Arguments.nth_data(index+1));
						break;
                                        case "-a":
                                                AiConfig = GetFilePath(Arguments.nth_data(index+1));
						break;
					case "-w":
						PixelW = Arguments.nth_data(index+1).to_int();
						break;
					case "-h":
						PixelH = Arguments.nth_data(index+1).to_int();
						break;
					default:
						break;
				}
			}
			stdout.printf("Image file path from options: %s \n", ImageFilePath);
			stdout.printf("Sound file path from options: %s \n", SoundFilePath);
			stdout.printf("Font file path from options: %s \n", FontsFilePath);
                        string[2] listPaths = { ImageFilePath, SoundFilePath, FontsFilePath };
                        string[2] scriptPaths = { MapGenLua, PlayerConfig, AiConfig};
			var app = new Lair(listPaths, scriptPaths, MapSize, PixelW, PixelH);
		}
	}
}
