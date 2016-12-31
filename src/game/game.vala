using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Game : Scribe{
		private Video.Window window;
		private Video.Renderer WindowRenderer;

		private Tower GameEnvironment;

		public Game(string[] listPaths, string[] scriptPaths, string mapSize, int screenW, int screenH) {
                        base.LLL(3, "floor:");
                        string imageListPath = listPaths[0];
                        string soundListPath = listPaths[1];
                        string fontsListPath = listPaths[2];
			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, screenW, screenH, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);
                        window.show();
			assert(WindowRenderer != null);

                        int imgInitFlags = SDLImage.InitFlags.PNG;
                        int initResult = SDLImage.init(imgInitFlags);
                        if ((initResult & imgInitFlags) != imgInitFlags) {

                        }

                        GameEnvironment = new Tower(mapSize, scriptPaths, new FileDB(imageListPath, soundListPath, fontsListPath), WindowRenderer);
		}
		private int UpdateScreen(){
			int r = GameEnvironment.TakeTurns();
                        GameEnvironment.DetectCollisions();
			GameEnvironment.RenderCopy(WindowRenderer);
			WindowRenderer.present();
			return r;
		}
		public int run(){
			int exit = 1;
			while(exit != 0){
                                WindowRenderer.set_draw_color(0xFF, 0xFF, 0xFF, Video.Alpha.TRANSPARENT);
                                WindowRenderer.clear();
				exit = UpdateScreen();
                                prints(" -> input was:%s\n", exit.to_string());
                                SDL.Timer.delay(120);
                                //SDL.Timer.delay(1200);
                                //SDL.Timer.delay(12000);
			}
			return exit;
		}
	}
}
