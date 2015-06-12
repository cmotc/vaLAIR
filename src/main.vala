using SDL;
using SDLImage;
namespace LAIR{
	protected static Graphics.Window window;
	protected static Graphics.Renderer? window_renderer;
	public static void main () {
		window = new Graphics.Window("LAIR! Social MMORPG", Graphics.Window.POS_CENTERED, Graphics.Window.POS_CENTERED, 800,600, Graphics.WindowFlags.RESIZABLE);
		window_renderer = Graphics.Renderer.create(window, -1, Graphics.RendererFlags.ACCELERATED | Graphics.RendererFlags.PRESENTVSYNC);
		//Game INSTANCE = new Game();
		while (true) {
		}
	}
}