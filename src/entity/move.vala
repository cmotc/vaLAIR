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
                protected int Quit(){
                        return 0;
                }
                protected int StepDown(){
                        SetY(GetY() + Speed());
                        return 2;
                }
                protected int StepUp(){
                        SetY(GetY() - Speed());
                        return 3;
                }
                protected int StepRight(){
                        SetX(GetX() + Speed());
                        return 4;
                }
                protected int StepLeft(){
                        SetX(GetX() - Speed());
                        return 5;
                }
                protected bool Bounce(bool tl, bool tr, bool bl, bool br, Video.Rect evenout){
                        bool r = false;
                        if(tl){
                                stdout.printf("Collision detected, Top Left Corner");
                                if(bl){
                                        stdout.printf(" and Bottom Left Corner\n");
                                        SetX((int)(evenout.x + evenout.w));
                                        StepRight();
                                }else if(tr){
                                        stdout.printf(" and Top Right Corner\n");
                                        SetY((int)(evenout.y + evenout.h));
                                        StepDown();
                                }else{
                                        stdout.printf("\n");
                                        SetX((int)(evenout.x + evenout.w));
                                        SetY((int)(evenout.y + evenout.h));
                                        StepRight();
                                        StepDown();
                                }
                                r = true;
                        }
                        if(tr){
                                stdout.printf("Collision detected, Top Right Corner");
                                if(br){
                                        stdout.printf(" and Bottom Right Corner\n");
                                        SetX((int)(evenout.x - evenout.w));
                                        StepLeft();
                                }else if(tl){
                                        stdout.printf(" and Top Left Corner\n");
                                        SetY((int)(evenout.y + evenout.h));
                                        StepDown();
                                }else{
                                        stdout.printf("\n");
                                        SetX((int)(evenout.x - evenout.w));
                                        SetY((int)(evenout.y + evenout.h));
                                        StepLeft();
                                        StepDown();
                                }
                                r = true;
                        }
                        if(bl){
                                stdout.printf("Collision detected, Bottom Left Corner");
                                if(tl){
                                        stdout.printf(" and Top Left Corner\n");
                                        SetX((int)(evenout.x + evenout.w));
                                        StepRight();
                                }else if(br){
                                        stdout.printf(" and Bottom Right Corner\n");
                                        SetY((int)(evenout.y - evenout.h));
                                        StepUp();
                                }else{
                                        stdout.printf("\n");
                                        SetX((int)(evenout.x + evenout.w));
                                        SetY((int)(evenout.y - evenout.h));
                                        StepRight();
                                        StepUp();
                                }
                                r = true;
                        }
                        if(br){
                                stdout.printf("Collision detected, Bottom Right Corner");
                                if(tr){
                                        stdout.printf("and Top Right Corner\n");
                                        SetX((int)(evenout.x - evenout.w));
                                        StepLeft();
                                }else if(bl){
                                        stdout.printf("and Bottom Left Corner\n");
                                        SetY((int)(evenout.y - evenout.h));
                                        StepUp();
                                }else{
                                        stdout.printf("\n");
                                        SetX((int)(evenout.x - evenout.w));
                                        SetY((int)(evenout.y - evenout.h));
                                        StepLeft();
                                        StepUp();
                                }
                                r = true;
                        }
                        return r;
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
                                                        t = Quit();
                                                        break;
                                                case Input.Keycode.DOWN:
                                                        t = StepDown();
                                                        break;
                                                case Input.Keycode.UP:
                                                        t = StepUp();
                                                        break;
                                                case Input.Keycode.RIGHT:
                                                        t = StepRight();
                                                        break;
                                                case Input.Keycode.LEFT:
                                                        t = StepLeft();
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
                                }else{
                                        break;
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
