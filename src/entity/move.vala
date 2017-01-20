using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Move : Inventory{
                public Move(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Move.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Move.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Move.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Move.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Move.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
                protected int quit(){
                        return 0;
                }
                protected int step_down(){
                        set_y(get_y() + Speed());
                        return 2;
                }
                protected int step_up(){
                        set_y(get_y() - Speed());
                        return 3;
                }
                protected int step_right(){
                        set_x(get_x() + Speed());
                        return 4;
                }
                protected int step_left(){
                        set_x(get_x() - Speed());
                        return 5;
                }
                protected int mouse_move(int X, int Y){
                        Video.Point tmp = Video.Point(){x = X, y = Y};
                        set_cursor_position(tmp);
                        return 6;
                }
                protected int show_my_stats(){
                        show_stats();
                        return 7;
                }
                protected int show_my_skills(){
                        show_skills();
                        return 8;
                }
                protected bool bounce(bool tl, bool tr, bool bl, bool br, Video.Rect evenout){
                        bool r = false;
                        if(tl){
                                print_withname("Collision detected, Top Left Corner");
                                if(bl){
                                        print_withname(" and Bottom Left Corner\n");
                                        set_x((int)(evenout.x + evenout.w));
                                        step_right();
                                }else if(tr){
                                        print_withname(" and Top Right Corner\n");
                                        set_y((int)(evenout.y + evenout.h));
                                        step_down();
                                }else{
                                        print_withname("\n");
                                        set_x((int)(evenout.x + evenout.w));
                                        set_y((int)(evenout.y + evenout.h));
                                        step_right();
                                        step_down();
                                }
                                r = true;
                        }
                        if(tr){
                                print_withname("Collision detected, Top Right Corner");
                                if(br){
                                        print_withname(" and Bottom Right Corner\n");
                                        set_x((int)(evenout.x - evenout.w));
                                        step_left();
                                }else if(tl){
                                        print_withname(" and Top Left Corner\n");
                                        set_y((int)(evenout.y + evenout.h));
                                        step_down();
                                }else{
                                        print_withname("\n");
                                        set_x((int)(evenout.x - evenout.w));
                                        set_y((int)(evenout.y + evenout.h));
                                        step_left();
                                        step_down();
                                }
                                r = true;
                        }
                        if(bl){
                                print_withname("Collision detected, Bottom Left Corner");
                                if(tl){
                                        print_withname(" and Top Left Corner\n");
                                        set_x((int)(evenout.x + evenout.w));
                                        step_right();
                                }else if(br){
                                        print_withname(" and Bottom Right Corner\n");
                                        set_y((int)(evenout.y - evenout.h));
                                        step_up();
                                }else{
                                        print_withname("\n");
                                        set_x((int)(evenout.x + evenout.w));
                                        set_y((int)(evenout.y - evenout.h));
                                        step_right();
                                        step_up();
                                }
                                r = true;
                        }
                        if(br){
                                print_withname("Collision detected, Bottom Right Corner");
                                if(tr){
                                        print_withname("and Top Right Corner\n");
                                        set_x((int)(evenout.x - evenout.w));
                                        step_left();
                                }else if(bl){
                                        print_withname("and Bottom Left Corner\n");
                                        set_y((int)(evenout.y - evenout.h));
                                        step_up();
                                }else{
                                        print_withname("\n");
                                        set_x((int)(evenout.x - evenout.w));
                                        set_y((int)(evenout.y - evenout.h));
                                        step_left();
                                        step_up();
                                }
                                r = true;
                        }
                        return r;
                }
		private void ai_input(){
		}
		public int player_input(){
                        int t = 1;
                        Event e;
                        print_withname("     Player is taking a turn : ");
                        while(Event.poll (out e) == 1){
                                print_withname(" Checking Event for Player Input\n");
				if (e.type == EventType.MOUSEMOTION || e.type == EventType.MOUSEBUTTONDOWN || e.type == EventType.MOUSEBUTTONUP){
                                        int x = 0, y = 0;
                                        Input.Cursor.get_state(ref x, ref y);
                                        bool inside = true;
                                        if (inside){
                                                switch (e.type) {
                                                        case EventType.MOUSEMOTION:
                                                                t = mouse_move(x, y);
                                                                break;
                                                        case EventType.MOUSEBUTTONDOWN:
                                                                t = 7;
                                                                break;
                                                        case EventType.MOUSEBUTTONUP:
                                                                t = 8;
                                                                break;
                                                }
                                        }
                                }else if (e.type == EventType.KEYDOWN) {
                                        switch(e.key.keysym.sym){
                                                case Input.Keycode.ESCAPE:
                                                        t = quit();
                                                        break;
                                                case Input.Keycode.s:
                                                        t = step_down();
                                                        break;
                                                case Input.Keycode.w:
                                                        t = step_up();
                                                        break;
                                                case Input.Keycode.d:
                                                        t = step_right();
                                                        break;
                                                case Input.Keycode.a:
                                                        t = step_left();
                                                        break;
                                                case Input.Keycode.DOWN:
                                                        t = step_down();
                                                        break;
                                                case Input.Keycode.UP:
                                                        t = step_up();
                                                        break;
                                                case Input.Keycode.RIGHT:
                                                        t = step_right();
                                                        break;
                                                case Input.Keycode.LEFT:
                                                        t = step_left();
                                                        break;
                                                case Input.Keycode.TAB:
                                                        t = show_my_stats();
                                                        break;
                                                case Input.Keycode.CAPSLOCK:
                                                        t = show_my_skills();
                                                        break;
                                        }
                                }
			}
                        return t;
		}
		public int run(){
                        int r = 1;
			if (is_player()){
				r = player_input();
			}else{
				ai_input();
			}
                        return r;
		}
	}
}
