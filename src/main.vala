using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	public class Lair {
		private Game GameMap;
		public Lair(string imageListPath, string soundListPath, string fontsListPath, string mapsize, int levels, int rooms){
			GameMap = new Game(imageListPath, soundListPath, fontsListPath, mapsize, levels, rooms);
			GameMap.UpdateScreen();
		}
		~Lair() {
			SDL.quit();
		}
		public static void main(string args[]){
			string ImageFilePath = "/usr/share/lair/images.list";
			string SoundFilePath = "/usr/share/lair/sounds.list";
			string FontsFilePath = "/usr/share/lair/fonts.list";
			List<string> Arguments = new List<string>();
			string MapSize = "medium";
			int NumLevels = 10;
			int NumRooms = 10;
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
					case "-l":
						NumLevels = Arguments.nth_data(index+1).to_int();
						break;
					case "-r":
						NumRooms = Arguments.nth_data(index+1).to_int();
						break;
					default:
						break;
				}
			}
			stdout.printf(ImageFilePath);	stdout.printf("\n");
			stdout.printf(SoundFilePath);	stdout.printf("\n");
			stdout.printf(FontsFilePath);	stdout.printf("\n");
			var app = new Lair(ImageFilePath, SoundFilePath, FontsFilePath, MapSize, NumLevels, NumRooms);
		}
	}
}
