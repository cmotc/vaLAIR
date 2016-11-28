using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Game{
		private Video.Window window;
		private Video.Renderer? WindowRenderer;
		private Video.Surface surface;
		private Video.Surface LairSurface;

		private FileDB Resources;

		private Entity Player = new Entity();

		private Tower GameEnvironment;

		public Game(string imageListPath, string soundListPath, string fontsListPath, string mapsize, int levels, int rooms) {
			SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);
			SDLTTF.init();

			Resources = new FileDB(imageListPath, soundListPath, fontsListPath);
			GameEnvironment = new Tower(mapsize, levels, rooms);

			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, 640, 480, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);

			surface = window.get_surface();

			Resources.LoadFiles();
			window.show();
			assert(WindowRenderer != null);
		}
		public void UpdateScreen(){
			LairSurface.blit(null, surface, null);
			GameEnvironment.RenderCopy(WindowRenderer);
			WindowRenderer.present();
			window.update_surface();
			SDL.Timer.delay(2000);
		}
	}
}
