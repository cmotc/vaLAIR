using SDL;
using SDLImage;
namespace LAIR{
	protected static Video.Window window;
	protected static Video.Renderer? window_renderer;
	public static void main () {
		SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);
		SDLTTF.init();

		window = new Video.Window("LAIR! Social MMORPG", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, 800,600, Video.WindowFlags.RESIZABLE);
		window_renderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);

		window.show();
		assert(window_renderer == null);

		//Game INSTANCE = new Game();
		while (true) {
		}
	}
}