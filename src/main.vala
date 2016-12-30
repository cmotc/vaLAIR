using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	public class Lair {
		private Game GameMap;
                private static bool help = false;
                private static string ImageFilePath = GetFilePath("lair/images.list");
		private static string SoundFilePath = GetFilePath("lair/sounds.list");
		private static string FontsFilePath = GetFilePath("lair/fonts.list");
                private static string MapGenLua = GetFilePath("lair/demo/dungeon.lua");
                private static string PlayerConfig = GetFilePath("lair/demo/player.lua");
                private static string AiConfig = GetFilePath("lair/demo/ai.lua");
		public Lair(string[] lspt, string[] scrpt, string mapSize, int screenW, int screenH){
                        if (!help){
                                if (SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL) > 0){
                                        //log some shit here.
                                }
                                if (SDLImage.init(SDLImage.InitFlags.PNG) < 0) {
                                        //log some more shit.
                                }
                                SDLTTF.init();
                                GameMap = new Game(lspt, scrpt, mapSize, screenW, screenH);
                                GameMap.run();
                        }else{
                                stdout.printf("***********************************************************************************\n\n\n");
                                stdout.printf("<I      <I I>         <I I>      I>\n");
                                stdout.printf(" |       | |           | |       |\n");
                                stdout.printf("<^^>____<^^^>_________<^^^>____<^^>\n");
                                stdout.printf(" || L        A    IIIII RRRRR   ||\n");
                                stdout.printf(" || L       A A     I   R    R  ||\n");
                                stdout.printf(" || L      AAAAA    I   RRRRR   ||\n");
                                stdout.printf(" || LLLLL A     A IIIII R    R  ||\n");
                                stdout.printf("<vv>___________________________<vv>\n\n");
                                stdout.printf("This is a game called LAIR, a free, self-hosted, worldbuilding, procedurally\n");
                                stdout.printf("generated 2D survival RPG. It can be played in a wide variety of ways, as\n");
                                stdout.printf("everything from a coffee-break roguelike to a political strategy game. The\n");
                                stdout.printf("following options can be used to configure it at runtime. For more information,\n");
                                stdout.printf("please see the manual as soon as I finish writing it.\n");
                                stdout.printf("     -i : display this menu\n");
                                stdout.printf("     -p : path to the image file listing\n");
                                stdout.printf("     -s : path to the sound file listing\n");
                                stdout.printf("     -f : path to the fonts file listing\n");
                                stdout.printf("     -m : map size(tiny, small, medium, large, giant\n");
                                stdout.printf("     -c : path to map generation script\n");
                                stdout.printf("     -e : path to character generation script\n");
                                stdout.printf("     -a : path to ai library script\n");
                                stdout.printf("     -w : screen width\n");
                                stdout.printf("     -h : screen height\n");
                                stdout.printf("\n***********************************************************************************\n");
                        }
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
                        MapGenLua = GetFilePath("lair/demo/dungeon.lua");
                        PlayerConfig = GetFilePath("lair/demo/player.lua");
                        AiConfig = GetFilePath("lair/demo/ai.lua");
			List<string> Arguments = new List<string>();
			string MapSize = "tiny";
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
                                                help = true;
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
