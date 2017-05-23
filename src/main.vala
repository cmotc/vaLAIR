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
                                print_force("***********************************************************************************\n\n\n");
                                print_force("<I      <I I>         <I I>      I>\n");
                                print_force(" |       | |           | |       |\n");
                                print_force("<^^>____<^^^>_________<^^^>____<^^>\n");
                                print_force(" || L        A    IIIII RRRRR   ||\n");
                                print_force(" || L       A A     I   R    R  ||\n");
                                print_force(" || L      AAAAA    I   RRRRR   ||\n");
                                print_force(" || LLLLL A     A IIIII R    R  ||\n");
                                print_force("<vv>___________________________<vv>\n\n");
                                print_force("This is a game called LAIR, a free, self-hosted, worldbuilding, procedurally\n");
                                print_force("generated 2D survival RPG. It can be played in a wide variety of ways, as\n");
                                print_force("everything from a coffee-break roguelike to a political strategy game. The\n");
                                print_force("following options can be used to configure it at runtime. For more information,\n");
                                print_force("please see the manual as soon as I finish writing it.\n\n");
                                print_force("----------------------------\n");
                                print_force("     -i : display this info\n");
                                print_force("     -p : path to the image file listing\n");
                                print_force("     -s : path to the sound file listing\n");
                                print_force("     -f : path to the fonts file listing\n");
                                print_force("     -m : map size(tiny, small, medium, large, giant\n");
                                print_force("     -c : path to map generation script\n");
                                print_force("     -e : path to character generation script\n");
                                print_force("     -a : path to ai library script\n");
                                print_force("     -w : log output verbosity\n");
                                print_force("     -w : screen width\n");
                                print_force("     -h : screen height\n");
                                print_force("\n***********************************************************************************\n");
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
                                print_static("***********************************************************************************\n\n\n");
                                print_static("<I      <I I>         <I I>      I>\n");
                                print_static(" |       | |           | |       |\n");
                                print_static("<^^>____<^^^>_________<^^^>____<^^>\n");
                                print_static(" || L        A    IIIII RRRRR   ||\n");
                                print_static(" || L       A A     I   R    R  ||\n");
                                print_static(" || L      AAAAA    I   RRRRR   ||\n");
                                print_static(" || LLLLL A     A IIIII R    R  ||\n");
                                print_static("<vv>___________________________<vv>\n\n");
                                print_static("\n\n");
                                print_static("----------------------------\n");
                                print_static("   Goodbye!                 \n");
                                print_static("----------------------------\n");
                                print_static("\n***********************************************************************************\n");
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
                        set_global_loglevel(Verbosity);
			print_static("Image file path from options: %s \n", ImageFilePath);
			print_static("Sound file path from options: %s \n", SoundFilePath);
			print_static("Font file path from options: %s \n", FontsFilePath);
                        print_static("Dungeon file path from options: %s \n", MapGenLua);
                        print_static("Player file path from options: %s \n", PlayerConfig);
                        print_static("AI file path from options: %s \n", AiConfig);
                        string[2] listPaths = { ImageFilePath, SoundFilePath, FontsFilePath };
                        string[2] scriptPaths = { MapGenLua, PlayerConfig, AiConfig};
			var app = new Lair(listPaths, scriptPaths, MapSize, PixelW, PixelH, Verbosity);
                        return app.goodbye();
		}
	}
}
