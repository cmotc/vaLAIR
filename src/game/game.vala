using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Game{
		private Video.Window window;
		private Video.Renderer WindowRenderer;

		private FileDB Resources;
		private Tower GameEnvironment;

		public Game(string imageListPath, string soundListPath, string fontsListPath, string mapSize, int screenW, int screenH) {
			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, screenW, screenH, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);
                        window.show();
			assert(WindowRenderer != null);

                        int imgInitFlags = SDLImage.InitFlags.PNG;
                        int initResult = SDLImage.init(imgInitFlags);
                        if ((initResult & imgInitFlags) != imgInitFlags) {
                                //stdout.printf("SDL_image could not initialize! SDL_image Error: %s\n", SDLImage.get_error());
                                //return false;
                        }
                        //return true;

                        Resources = new FileDB(imageListPath, soundListPath, fontsListPath);
                        GameEnvironment = new Tower(mapSize, Resources, WindowRenderer);
		}
		private int UpdateScreen(){
			int r = GameEnvironment.TakeTurns();
                        bool c = GameEnvironment.DetectCollisions();
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
                                stdout.printf(" -> input was:%s\n", exit.to_string());
                                SDL.Timer.delay(120);
			}
			return exit;
		}
	}
}
