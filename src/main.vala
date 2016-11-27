using SDL;
using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	public class Lair {
		private FileDB Resources = new FileDB("/etc/lair/images.list", "/etc/lair/sounds.list", "/etc/lair/fonts.list");
		private Video.Window window;
		private Video.Renderer? window_renderer;
		private Video.Surface surface;
		private Video.Surface LairSurface;
		~Lair() {
			SDL.quit();
		}
		public void run() {
			LairSurface.blit(null, surface, null);
			window.update_surface();
			SDL.Timer.delay(2000);
		}
		public void load_media() {
			LairSurface = SDLImage.load("resources/hello_world.bmp");
			Resources.LoadFiles();
		}
		public void init() {
			SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);
			SDLTTF.init();

			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, 640, 480, Video.WindowFlags.SHOWN);
			window_renderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);

			surface = window.get_surface();
			load_media();

			window.show();
			assert(window_renderer == null);
		}
		public static void main(){
			var app = new Lair();
			app.init();
			app.run();
		}
	}
}