using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Move : Inventory{
                public Move(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Move.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Move.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Move.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Move.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Move.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
		private void AInput(){
		}
		public int PInput(){
                        int t = 1;
                        Event e;
			//for (Event e = {0}; e.type != EventType.QUIT; Event.poll (out e)) {
                        stdout.printf("     Player is taking a turn : ");
                        while(Event.poll (out e) == 1){
                                stdout.printf(" Checking Event for Player Input\n");
				if (e.type == EventType.KEYDOWN) {
                                        switch(e.key.keysym.sym){
                                                case Input.Keycode.ESCAPE:
                                                        t = 0;
                                                        break;
                                                case Input.Keycode.DOWN:
                                                        t = 2;
                                                        SetY(GetY() + Speed());
                                                        break;
                                                case Input.Keycode.UP:
                                                        t = 3;
                                                        SetY(GetY() - Speed());
                                                        break;
                                                case Input.Keycode.RIGHT:
                                                        t = 4;
                                                        SetX(GetX() + Speed());
                                                        break;
                                                case Input.Keycode.LEFT:
                                                        t = 5;
                                                        SetX(GetX() - Speed());
                                                        break;
                                        }
                                }else if (e.type == EventType.MOUSEMOTION || e.type == EventType.MOUSEBUTTONDOWN || e.type == EventType.MOUSEBUTTONUP){
                                        int x = 0, y = 0;
                                        Input.Cursor.get_state(ref x, ref y);
                                        bool inside = true;
                                        if (inside){
                                                switch (e.type) {
                                                        case EventType.MOUSEMOTION:
                                                                t = 6;
                                                                break;
                                                        case EventType.MOUSEBUTTONDOWN:
                                                                t = 7;
                                                                break;
                                                        case EventType.MOUSEBUTTONUP:
                                                                t = 8;
                                                                break;
                                                }
                                        }
                                }
			}
                        return t;
		}
		public int run(){
                        int r = 1;
			if (IsPlayer()){
				r = PInput();
			}else{
				AInput();
			}
                        return r;
		}
	}
}
