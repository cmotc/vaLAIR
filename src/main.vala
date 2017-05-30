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
                        base.new_local_attributes(1, "global log: ", verbosity);
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
                                message("***********************************************************************************\n\n\n");
                                message("<I      <I I>         <I I>      I>\n");
                                message(" |       | |           | |       |\n");
                                message("<^^>____<^^^>_________<^^^>____<^^>\n");
                                message(" || L        A    IIIII RRRRR   ||\n");
                                message(" || L       A A     I   R    R  ||\n");
                                message(" || L      AAAAA    I   RRRRR   ||\n");
                                message(" || LLLLL A     A IIIII R    R  ||\n");
                                message("<vv>___________________________<vv>\n\n");
                                message("This is a game called LAIR, a free, self-hosted, worldbuilding, procedurally\n");
                                message("generated 2D survival RPG. It can be played in a wide variety of ways, as\n");
                                message("everything from a coffee-break roguelike to a political strategy game. The\n");
                                message("following options can be used to configure it at runtime. For more information,\n");
                                message("please see the manual as soon as I finish writing it.\n\n");
                                message("----------------------------\n");
                                message("     -i : display this info\n");
                                message("     -p : path to the image file listing\n");
                                message("     -s : path to the sound file listing\n");
                                message("     -f : path to the fonts file listing\n");
                                message("     -m : map size(tiny, small, medium, large, giant\n");
                                message("     -c : path to map generation script\n");
                                message("     -e : path to character generation script\n");
                                message("     -a : path to ai library script\n");
                                message("     -w : log output verbosity\n");
                                message("     -w : screen width\n");
                                message("     -h : screen height\n");
                                message("\n***********************************************************************************\n");
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
                                message("***********************************************************************************\n\n\n");
                                message("<I      <I I>         <I I>      I>\n");
                                message(" |       | |           | |       |\n");
                                message("<^^>____<^^^>_________<^^^>____<^^>\n");
                                message(" || L        A    IIIII RRRRR   ||\n");
                                message(" || L       A A     I   R    R  ||\n");
                                message(" || L      AAAAA    I   RRRRR   ||\n");
                                message(" || LLLLL A     A IIIII R    R  ||\n");
                                message("<vv>___________________________<vv>\n\n");
                                message("\n\n");
                                message("----------------------------\n");
                                message("   Goodbye!                 \n");
                                message("----------------------------\n");
                                message("\n***********************************************************************************\n");
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
						MapSize = get_file_path(Arguments.nth_data(index+1));
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
                        set_global_log_level(Verbosity);
			message("Image file path from options: %s \n", ImageFilePath);
			message("Sound file path from options: %s \n", SoundFilePath);
			message("Font file path from options: %s \n", FontsFilePath);
                        message("Dungeon file path from options: %s \n", MapGenLua);
                        message("Player file path from options: %s \n", PlayerConfig);
                        message("AI file path from options: %s \n", AiConfig);
                        string[2] listPaths = { ImageFilePath, SoundFilePath, FontsFilePath };
                        string[2] scriptPaths = { MapGenLua, PlayerConfig, AiConfig };
			var app = new Lair(listPaths, scriptPaths, MapSize, PixelW, PixelH, Verbosity);
                        return app.goodbye();
		}
	}
}
