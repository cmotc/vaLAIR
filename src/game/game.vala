using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Game{
                private GLib.Rand DungeonMaster = new GLib.Rand ();
		private Video.Window window;
		private Video.Renderer? WindowRenderer;
		private Video.Surface LairSurface;

		private FileDB Resources;
		private Entity Player;
		private Tower GameEnvironment;

		public Game(string imageListPath, string soundListPath, string fontsListPath, string mapSize, int screenW, int screenH) {
                        //Player = new Entity();
			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, screenW, screenH, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);
                        window.show();
			assert(WindowRenderer != null);

                        Resources = new FileDB(imageListPath, soundListPath, fontsListPath);
                        GameEnvironment = new Tower(mapSize, Resources, WindowRenderer);
			//surface = window.get_surface();

		}
		private int UpdateScreen(){
			GameEnvironment.TakeTurns();
			GameEnvironment.RenderCopy(WindowRenderer);
			WindowRenderer.present();
			window.update_surface();
			SDL.Timer.delay(2000000);
			return 1;
		}
		public int run(){
			int exit = 1;
			while(exit != 0){
                                stdout.printf("Update Sent \n");
				exit = UpdateScreen();
			}
			return exit;
		}
	}
}
