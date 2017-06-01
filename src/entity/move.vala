using SDL;
using SDLMixer;
using SDLTTF;
using Lua;
namespace LAIR{
	class Move : Inventory{
                private string ai_func = "";
                public Move(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Move.Wall(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.Wall(corner, Surfaces, music, font, renderer, tags);
                }
                public Move.Mobile(AutoPoint corner, string aiScript, string aiFunc, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.Mobile(corner, aiScript, Surfaces, music, font, renderer, tags);
                        ai_func = aiFunc;
                        set_stat_func("stats_" + get_ai_func());
                }
                public Move.Player(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Player(corner, Surfaces, music, font, renderer);
                }
                protected int quit(){
                        return 0;
                }
                protected int stand_still(){
                        toggle_wobble_on();
                        return 1;
                }
                protected int step_down(LuaVM vm = this.get_lua_vm()){
                        set_y(get_y() + Speed());
                        toggle_wobble_on();
                        return 2;
                }
                protected int step_up(LuaVM vm = this.get_lua_vm()){
                        set_y(get_y() - Speed());
                        toggle_wobble_on();
                        return 3;
                }
                protected int step_right(LuaVM vm = this.get_lua_vm()){
                        set_x(get_x() + Speed());
                        toggle_wobble_on();
                        return 4;
                }
                protected int step_left(LuaVM vm = this.get_lua_vm()){
                        set_x(get_x() - Speed());
                        toggle_wobble_on();
                        return 5;
                }
                protected int swing_left(LuaVM vm = this.get_lua_vm()){
                        //toggle_swing_on_left();
                        return 6;
                }
                protected int swing_right(LuaVM vm = this.get_lua_vm()){
                        //toggle_swing_on_right();
                        return 7;
                }
                protected int mouse_move(int xx, int yy){
                        set_cursor_position(xx, yy);
                        return 8;
                }
                protected int show_my_stats(){
                        show_stats();
                        return 9;
                }
                protected int show_my_skills(){
                        show_skills();
                        return 10;
                }
                protected bool bounce(bool tl, bool tr, bool bl, bool br, Video.Rect evenout){
                        bool r = false;
                        if(tl){
                                message("Collision detected, Top Left Corner");
                                if(bl){
                                        message(" and Bottom Left Corner");
                                        set_x((int)(evenout.x + evenout.w));
                                        step_right();
                                }else if(tr){
                                        message(" and Top Right Corner");
                                        set_y((int)(evenout.y + evenout.h));
                                        step_down();
                                }else{
                                        message("");
                                        set_x((int)(evenout.x + evenout.w));
                                        set_y((int)(evenout.y + evenout.h));
                                        step_right();
                                        step_down();
                                }
                                r = true;
                        }
                        if(tr){
                                message("Collision detected, Top Right Corner");
                                if(br){
                                        message(" and Bottom Right Corner");
                                        set_x((int)(evenout.x - evenout.w));
                                        step_left();
                                }else if(tl){
                                        message(" and Top Left Corner");
                                        set_y((int)(evenout.y + evenout.h));
                                        step_down();
                                }else{
                                        message("");
                                        set_x((int)(evenout.x - evenout.w));
                                        set_y((int)(evenout.y + evenout.h));
                                        step_left();
                                        step_down();
                                }
                                r = true;
                        }
                        if(bl){
                                message("Collision detected, Bottom Left Corner");
                                if(tl){
                                        message(" and Top Left Corner");
                                        set_x((int)(evenout.x + evenout.w));
                                        step_right();
                                }else if(br){
                                        message(" and Bottom Right Corner");
                                        set_y((int)(evenout.y - evenout.h));
                                        step_up();
                                }else{
                                        message("");
                                        set_x((int)(evenout.x + evenout.w));
                                        set_y((int)(evenout.y - evenout.h));
                                        step_right();
                                        step_up();
                                }
                                r = true;
                        }
                        if(br){
                                message("Collision detected, Bottom Right Corner");
                                if(tr){
                                        message("and Top Right Corner");
                                        set_x((int)(evenout.x - evenout.w));
                                        step_left();
                                }else if(bl){
                                        message("and Bottom Left Corner");
                                        set_y((int)(evenout.y - evenout.h));
                                        step_up();
                                }else{
                                        message("");
                                        set_x((int)(evenout.x - evenout.w));
                                        set_y((int)(evenout.y - evenout.h));
                                        step_left();
                                        step_up();
                                }
                                r = true;
                        }
                        return r;
                }
                protected string get_ai_func(){
                        string r;
                        if(ai_func == ""){
                                r = "default()";
                        }else{
                                r = ai_func;
                        }
                        return r;
                }
		private void ai_input(){
                        lua_do_function(get_ai_func());
                        List<string> aiDo = get_lua_last_return();
                        ai_input_compare(aiDo.nth_data(0));
		}
                private void ai_input_compare(string ai_do){
                        int t;
                        switch (ai_do) {
                                case "rotate()":
                                        message("AI is turning");
                                        t = 7;//mouse_move(x, y);
                                        break;
                                case "aim()":
                                        message("AI is aiming");
                                        t = swing_left();
                                        break;
                                case "fire()":
                                        message("AI is firing");
                                        t = swing_left();
                                        break;
                                case "action()":
                                        message("AI is attempting");
                                        t = swing_right();
                                        break;
                                case "throw()":
                                        message("AI is throwing");
                                        t = swing_right();
                                        break;
                                case "step_down()":
                                        message("AI is stepping down");
                                        t = step_down();
                                        break;
                                case "step_up()":
                                        message("AI is stepping up");
                                        t = step_up();
                                        break;
                                case "step_right()":
                                        message("AI is stepping right");
                                        t = step_right();
                                        break;
                                case "step_left()":
                                        message("AI is stepping left");
                                        t = step_left();
                                        break;
                                case "stand_still()":
                                        message("AI is standing still");
                                        t = stand_still();
                                        break;
                        }
                }
		public int player_input(){
                        int t = 1;
                        Event e;
                        message("     Player is taking a turn : ");
                        while(Event.poll (out e) == 1){
                                message(" Checking Event for Player Input");
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
                                                                t = swing_left();
                                                                //t = swing_right();
                                                                break;
                                                        case EventType.MOUSEBUTTONUP:
                                                                t = swing_left();
                                                                //t = swing_right();
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
