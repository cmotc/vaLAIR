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
		private Entity Player = new Entity();
		private Tower GameEnvironment;

		public Game(string imageListPath, string soundListPath, string fontsListPath) {
			Resources = new FileDB(imageListPath, soundListPath, fontsListPath);
			Resources.LoadFiles();
			GameEnvironment = new Tower("medium", DungeonMaster);

			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, 640, 480, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);

			//surface = window.get_surface();

			window.show();
			assert(WindowRenderer != null);
		}
		private int UpdateScreen(){
			//LairSurface.blit(null, window, null);
			GameEnvironment.RenderCopy(WindowRenderer);
			WindowRenderer.present();
			window.update_surface();
			SDL.Timer.delay(2000);
			return 0;
		}
		public int run(){
			bool exit = false;
			while(!exit){
				int t = UpdateScreen();
				if ( t == 0 ){
					exit = true;
				}
			}
			return 0;
		}
	}
}
