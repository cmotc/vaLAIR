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
                //protected CallbackFunc step_down = () => {};
                protected int step_down(LuaVM vm = this.vm_copy()){
                        set_y(get_y() + WalkingSpeed());
                        toggle_wobble_on();
                        return 2;
                }
                protected int step_up(LuaVM vm = this.vm_copy()){
                        set_y(get_y() - WalkingSpeed());
                        toggle_wobble_on();
                        return 3;
                }
                protected int step_right(LuaVM vm = this.vm_copy()){
                        set_x(get_x() + WalkingSpeed());
                        toggle_wobble_on();
                        return 4;
                }
                protected int step_left(LuaVM vm = this.vm_copy()){
                        set_x(get_x() - WalkingSpeed());
                        toggle_wobble_on();
                        return 5;
                }
                protected int swing_left(LuaVM vm = this.vm_copy()){
                        //toggle_swing_on_left();
                        return 6;
                }
                protected int swing_right(LuaVM vm = this.vm_copy()){
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
                protected bool bounce(int[] overlaps, AutoRect evenout){
                        int tl = overlaps[0];
                        int tr = overlaps[1];
                        int bl = overlaps[2];
                        int br = overlaps[3];
                        bool r = false;
                        switch (tl){
                                case 1:
                                        set_x(evenout.x()+(int)evenout.w()+WalkingSpeed());
                                        break;
                                case 2:
                                        set_x(evenout.x()+(int)evenout.w()+WalkingSpeed());
                                        break;
                                case 3:
                                        set_y(evenout.y()+(int)evenout.h()+WalkingSpeed());
                                        break;
                                case 4:
                                        set_y(evenout.y()+(int)evenout.h()+WalkingSpeed());
                                        break;
                                case 0:
                                        break;
                        }
                        switch (tr){
                                case 1:
                                        set_x(evenout.x()-(int)get_hitbox().w()-WalkingSpeed());
                                        break;
                                case 2:
                                        set_x(evenout.x()-(int)get_hitbox().w()-WalkingSpeed());
                                        break;
                                case 3:
                                        set_y(evenout.y()+(int)evenout.h()-WalkingSpeed());
                                        break;
                                case 4:
                                        set_y(evenout.y()+(int)evenout.h()-WalkingSpeed());
                                        break;
                                case 0:
                                        break;
                        }
                        switch (bl){
                                case 1:
                                        set_y(evenout.y()-(int)get_hitbox().h()-WalkingSpeed());
                                        break;
                                case 2:
                                        set_y(evenout.y()-(int)get_hitbox().h()-WalkingSpeed());
                                        break;
                                case 3:
                                        set_x(evenout.x()-(int)evenout.w()-WalkingSpeed());
                                        break;
                                case 4:
                                        set_x(evenout.x()-(int)evenout.w()-WalkingSpeed());
                                        break;
                                case 0:
                                        break;
                        }
                        switch (br){
                                case 1:
                                        set_y(evenout.y()-(int)get_hitbox().h()-WalkingSpeed());
                                        break;
                                case 2:
                                        set_y(evenout.y()-(int)get_hitbox().h()-WalkingSpeed());
                                        break;
                                case 3:
                                        set_x(evenout.x()-(int)get_hitbox().w()-WalkingSpeed());
                                        break;
                                case 4:
                                        set_x(evenout.x()-(int)get_hitbox().w()-WalkingSpeed());
                                        break;
                                case 0:
                                        break;
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
                                        t = 7;//mouse_move(x, y);
                                        break;
                                case "aim()":
                                        t = swing_left();
                                        break;
                                case "fire()":
                                        t = swing_left();
                                        break;
                                case "action()":
                                        t = swing_right();
                                        break;
                                case "throw()":
                                        t = swing_right();
                                        break;
                                case "step_down()":
                                        t = step_down();
                                        break;
                                case "step_up()":
                                        t = step_up();
                                        break;
                                case "step_right()":
                                        t = step_right();
                                        break;
                                case "step_left()":
                                        t = step_left();
                                        break;
                                case "stand_still()":
                                        t = stand_still();
                                        break;
                        }
                }
		public int player_input(){
                        int t = 1;
                        Event e;
                        message("     Player is taking a turn : ");
                        while(Event.poll (out e) == 1){
                                if (e.type == EventType.MOUSEMOTION || e.type == EventType.MOUSEBUTTONDOWN || e.type == EventType.MOUSEBUTTONUP){
                                        int x = 0, y = 0;
                                        Input.Cursor.get_state(ref x, ref y);
                                        switch (e.type) {
                                                case EventType.MOUSEMOTION:
                                                        t = mouse_move(x, y);
                                                        break;
                                                case EventType.MOUSEBUTTONDOWN:
                                                        t = swing_left();
                                                        break;
                                                case EventType.MOUSEBUTTONUP:
                                                        t = swing_left();
                                                        break;
                                        }
                                }else if(e.type == EventType.KEYDOWN){
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
                                }else if(e.type == EventType.KEYUP){
                                        break;
                                }
			}
                        unowned bool[] current_key_states = Input.Keyboard.get_state();
                        if (current_key_states[Input.Scancode.ESCAPE]){
                                t = quit();
                        }
                        if (current_key_states[Input.Scancode.S]){
                                t = step_down();
                        }
                        if (current_key_states[Input.Scancode.W]){
                                t = step_up();
                        }
                        if (current_key_states[Input.Scancode.D]){
                                t = step_right();
                        }
                        if (current_key_states[Input.Scancode.A]){
                                t = step_left();
                        }
                        if (current_key_states[Input.Scancode.DOWN]){
                                t = step_down();
                        }
                        if (current_key_states[Input.Scancode.UP]){
                                t = step_up();
                        }
                        if (current_key_states[Input.Scancode.RIGHT]){
                                t = step_right();
                        }
                        if (current_key_states[Input.Scancode.LEFT]){
                                t = step_left();
                        }
                        if (current_key_states[Input.Scancode.TAB]){
                                t = show_my_stats();
                        }
                        if (current_key_states[Input.Scancode.CAPSLOCK]){
                                t = show_my_skills();
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
