using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	public class Lair {
		private Game GameMap;
		public Lair(string imageListPath, string soundListPath, string fontsListPath, string mapSize, int screenW, int screenH){
                        SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);
			SDLTTF.init();

			GameMap = new Game(imageListPath, soundListPath, fontsListPath, mapSize, screenW, screenH);
			GameMap.run();
		}
		~Lair() {
			SDL.quit();
		}
		public static void main(string args[]){
			string ImageFilePath = "/usr/share/lair/images.list";
			string SoundFilePath = "/usr/share/lair/sounds.list";
			string FontsFilePath = "/usr/share/lair/fonts.list";
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
						ImageFilePath = Arguments.nth_data(index+1);
						break;
					case "-s":
						SoundFilePath = Arguments.nth_data(index+1);
						break;
					case "-f":
						FontsFilePath = Arguments.nth_data(index+1);
						break;
					case "-m":
						MapSize = Arguments.nth_data(index+1);
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
			var app = new Lair(ImageFilePath, SoundFilePath, FontsFilePath, MapSize, PixelW, PixelH);
		}
	}
}
