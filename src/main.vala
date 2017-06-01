using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Lair : Scribe {
		private static Game GameMap;
                private static bool help = false;
                private static string ImageFilePath = get_file_path("lair/images.list");
		private static string SoundFilePath = get_file_path("lair/sounds.list");
		private static string FontsFilePath = get_file_path("lair/fonts.list");
                private static string MapGenLua = get_file_path("lair/demo/dungeon.lua");
                private static string PlayerConfig = get_file_path("lair/demo/player.lua");
                private static string AiConfig = get_file_path("lair/demo/ai.lua");
		public Lair(string[] lspt, string[] scrpt, string mapSize, int screenW, int screenH, int verbosity){
                        base.new_local_attributes(verbosity, "global log: ");
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
                                message("***********************************************************************************");
                                message("<I      <I I>         <I I>      I>");
                                message(" |       | |           | |       |");
                                message("<^^>____<^^^>_________<^^^>____<^^>");
                                message(" || L        A    IIIII RRRRR   ||");
                                message(" || L       A A     I   R    R  ||");
                                message(" || L      AAAAA    I   RRRRR   ||");
                                message(" || LLLLL A     A IIIII R    R  ||");
                                message("<vv>___________________________<vv>");
                                message("This is a game called LAIR, a free, self-hosted, worldbuilding, procedurally");
                                message("generated 2D survival RPG. It can be played in a wide variety of ways, as");
                                message("everything from a coffee-break roguelike to a political strategy game. The");
                                message("following options can be used to configure it at runtime. For more information,");
                                message("please see the manual as soon as I finish writing it.");
                                message("----------------------------");
                                message("     -i : display this info");
                                message("     -p : path to the image file listing");
                                message("     -s : path to the sound file listing");
                                message("     -f : path to the fonts file listing");
                                message("     -m : map size(tiny, small, medium, large, giant");
                                message("     -c : path to map generation script");
                                message("     -e : path to character generation script");
                                message("     -a : path to ai library script");
                                message("     -w : log output verbosity");
                                message("     -w : screen width");
                                message("     -h : screen height");
                                message("***********************************************************************************");
                        }
		}
		~Lair() {
			SDL.quit();
		}
                public static string get_file_path(string path){
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
                        return RETURN.get_path();
                }
                public static int goodbye(){
                                message("***********************************************************************************");
                                message("<I      <I I>         <I I>      I>");
                                message(" |       | |           | |       |");
                                message("<^^>____<^^^>_________<^^^>____<^^>");
                                message(" || L        A    IIIII RRRRR   ||");
                                message(" || L       A A     I   R    R  ||");
                                message(" || L      AAAAA    I   RRRRR   ||");
                                message(" || LLLLL A     A IIIII R    R  ||");
                                message("<vv>___________________________<vv>");
                                message("----------------------------");
                                message("   Goodbye!                 ");
                                message("----------------------------");
                                message("***********************************************************************************");
                                return 0;
                }
		public static int main(string args[]){
                        ImageFilePath = get_file_path("lair/images.list");
                        SoundFilePath = get_file_path("lair/sounds.list");
                        FontsFilePath = get_file_path("lair/fonts.list");
                        MapGenLua = get_file_path("lair/demo/dungeon.lua");
                        PlayerConfig = get_file_path("lair/demo/player.lua");
                        AiConfig = get_file_path("lair/demo/ai.lua");
			List<string> Arguments = new List<string>();
			string MapSize = "tiny";
			int PixelW = 800;
			int PixelH = 600;
                        int Verbosity = 0;
                        bool save = false;
			foreach(var arg in args){
				Arguments.append(arg);
			}
			for (int index = 0; index < Arguments.length(); index++){
				switch (Arguments.nth_data(index)){
                                        case "-i":
                                                help = true;
						break;
                                        case "-l":
                                                save = true;
						break;
					case "-p":
						ImageFilePath = get_file_path(Arguments.nth_data(index+1));
						break;
					case "-s":
						SoundFilePath = get_file_path(Arguments.nth_data(index+1));
						break;
					case "-f":
						FontsFilePath = get_file_path(Arguments.nth_data(index+1));
						break;
					case "-m":
						MapSize = Arguments.nth_data(index+1);
						break;
                                        case "-c":
                                                MapGenLua = get_file_path(Arguments.nth_data(index+1));
						break;
                                        case "-e":
                                                PlayerConfig = get_file_path(Arguments.nth_data(index+1));
						break;
                                        case "-a":
                                                AiConfig = get_file_path(Arguments.nth_data(index+1));
						break;
                                        case "-v":
                                                Verbosity = int.parse(Arguments.nth_data(index+1));
						break;
					case "-w":
						PixelW = int.parse(Arguments.nth_data(index+1));
						break;
					case "-h":
						PixelH = int.parse(Arguments.nth_data(index+1));
						break;
					default:
						break;
				}
			}
                        set_log_level(Verbosity);
			message("Image file path from options: %s ", ImageFilePath);
			message("Sound file path from options: %s ", SoundFilePath);
			message("Font file path from options: %s ", FontsFilePath);
                        message("Dungeon file path from options: %s ", MapGenLua);
                        message("Player file path from options: %s ", PlayerConfig);
                        message("AI file path from options: %s ", AiConfig);
                        string[2] listPaths = { ImageFilePath, SoundFilePath, FontsFilePath };
                        string[2] scriptPaths = { MapGenLua, PlayerConfig, AiConfig };
			var app = new Lair(listPaths, scriptPaths, MapSize, PixelW, PixelH, Verbosity);
                        return app.goodbye();
		}
	}
}
