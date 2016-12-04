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
                        stdout.printf("Update Sent");
			//LairSurface.blit(null, window, null);
			GameEnvironment.RenderCopy(WindowRenderer);
			WindowRenderer.present();
			window.update_surface();
			SDL.Timer.delay(2000);
			return 1;
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
