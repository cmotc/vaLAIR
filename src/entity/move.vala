using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Move : Inventory{
		private Event e;
                public Move(int x, int y, Video.Surface* surface, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(x, y, surface, music, font, renderer);
                }
		private void aInput(){
		}
		public void pInput(){
			for (Event e = {0}; e.type != EventType.QUIT; Event.poll (out e)) {
				if (e.type == EventType.KEYDOWN) {
					if (e.key.keysym.sym == Input.Keycode.DOWN) {
						SetY(GetY() + Speed());
					}
					if (e.key.keysym.sym == Input.Keycode.UP) {
						SetY(GetY() - Speed());
					}
					if (e.key.keysym.sym == Input.Keycode.RIGHT) {
						SetX(GetX() + Speed());
					}
					if (e.key.keysym.sym == Input.Keycode.LEFT) {
						SetX(GetX() - Speed());
					}
					/*if (e.key.keysym.sym== Input.Keycode.SPACE) {
					}
					if (e.type == EventType.MOUSEMOTION || e.type == EventType.MOUSEBUTTONDOWN || e.type == EventType.MOUSEBUTTONUP) {
					}*/
				}
			}
		}
		public void run(){
			if (IsPlayer()){
				pInput();
			}else{
				aInput();
			}
		}
	}
}