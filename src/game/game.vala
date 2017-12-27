using SDL;
//using SDLGraphics;
using SDLImage;
using SDLTTF;
using SDLMixer;

namespace LAIR{
	class Game : Scribe{
		private Video.Window window;
		private Video.Renderer WindowRenderer;
		private Tower GameEnvironment;
        private bool dedupe = false;
        private const uint frame_ticks = 1000 / 80;
        private AutoTimer cap_timer = new AutoTimer();
		public Game(string[] listPaths, string[] scriptPaths, int screenW, int screenH) {
            base(3);
            string imageListPath = listPaths[0];
            string soundListPath = listPaths[1];
            string fontsListPath = listPaths[2];
			window = new Video.Window("LAIR!", Video.Window.POS_CENTERED, Video.Window.POS_CENTERED, screenW, screenH, Video.WindowFlags.SHOWN);
			WindowRenderer = Video.Renderer.create(window, -1, Video.RendererFlags.ACCELERATED | Video.RendererFlags.PRESENTVSYNC);
            window.show();
			assert(WindowRenderer != null);
            GameEnvironment = new Tower(scriptPaths, new FileDB(imageListPath, soundListPath, fontsListPath), WindowRenderer);
		}
		private int update_screen(){
            GameEnvironment.detect_collisions();
            int r = GameEnvironment.take_turns();
			GameEnvironment.render_copy(WindowRenderer);
            if(dedupe){
                GameEnvironment.dedupe_memories();
                dedupe=false;
            }else{
                dedupe=true;
            }
			WindowRenderer.present();
			return r;
		}
        public int generator_loop(){
            return GameEnvironment.grow_a_level();
        }
		public int run(){
			int exit = 1;
            WindowRenderer.set_draw_color(0xFF, 0xFF, 0xFF, Video.Alpha.TRANSPARENT);
			while(exit != 0){
                WindowRenderer.clear();
                uint cap_ticks = cap_timer.get_ticks();
                if ( cap_ticks < frame_ticks ){
                    SDL.Timer.delay(frame_ticks - cap_ticks);
                }
                exit = generator_loop();
                exit = update_screen();
                message(" -> input was:%s", exit.to_string());

			}
			return exit;
		}
	}
}
