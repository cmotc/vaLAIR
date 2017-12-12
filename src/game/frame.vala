using SDL;
using Lua;

namespace LAIR{
	class Frame : LuaConf{
        private AutoRect Border = new AutoRect(0,0,0,0);
        private unowned string[] gen_scripts;
        private int generator_ticks = 0;
        private int generator_cycle = 0;
        private int q = 0;
        public Frame(AutoRect position, AutoRect floor_dims, string[] scripts){
            base(scripts[0]);
            gen_scripts = scripts;
            Border = new AutoRect(position.x(), position.y(), position.w(), position.h());
            lua_push_dimensions_generator_phase(get_hitrect(), floor_dims);
            set_name("room("+stringify_hitrect()+"): ");
            message("generating room%s", get_name());
            generator_ticks = get_adjusted_w() * get_adjusted_h();
		}
        protected int get_generator_cycle(){
            int r = generator_cycle;
            if(generator_cycle <= 2){
                if(generator_cycle >= 0){
                    generator_cycle++;
                }else{
                    generator_cycle = 0;
                }
            }else{
                generator_cycle = 0;
                r = generator_cycle;
            }
            message("generator is on: %s", r.to_string());
            return r;
        }
        protected int get_generator_ticks(){
            if(generator_ticks > 0 ){
                return generator_ticks;
            }else{
                generator_ticks = 0;
                return 0;
            }
        }
        public bool ingeneration(){
            return (generator_ticks > 0);
        }
        protected int get_x(){     return (int) Border.x();}
        protected int get_offset_x(int x){
            int r = (x * 32) + get_x();
            return r;
        }
        protected int get_y(){     return (int) Border.y();}
        protected int get_offset_y(int y) {
            int r = (y * 32) + get_y();
            return r;
        }
        public uint get_w(){     return Border.w();}
        public uint get_h(){     return Border.h();}
        public int get_adjusted_w(){
            return (int) Border.w() /32;
        }
        public int get_adjusted_h(){
            return (int) Border.h() /32;
        }
        protected AutoRect get_hitrect(){
            return Border;
        }
        private string stringify_hitrect(){
            string HBSUM = "x:";
            HBSUM += Border.x().to_string();
            HBSUM += "y:";
            HBSUM += Border.y().to_string();
            HBSUM += "w:";
            HBSUM += Border.w().to_string();
            HBSUM += "h:";
            HBSUM += Border.h().to_string();
            return HBSUM;
        }
        public int detect_transitions(Entity tmp){
            int r = 0;
            if(tmp!=null){
                bool TLeftCorner = get_hitrect().in_range(tmp.get_hitbox().tlc());
                bool TRightCorner = get_hitrect().in_range(tmp.get_hitbox().trc());
                bool BLeftCorner = get_hitrect().in_range(tmp.get_hitbox().blc());
                bool BRightCorner = get_hitrect().in_range(tmp.get_hitbox().brc());
                if (TLeftCorner){
                    r++;
                    message("Detected transiton, TLC %s", TLeftCorner.to_string());
                }
                if (BLeftCorner){
                    r++;
                    message("Detected transiton, BLC %s", BLeftCorner.to_string());
                }
                if (BRightCorner){
                    r++;
                    message("Detected transiton, BRC %s", BLeftCorner.to_string());
                }
                if (TRightCorner){
                    r++;
                    message("Detected transiton, TRC %s", TRightCorner.to_string());
                }
            }
            return r;
        }
        public AutoRect rect_select(){
            AutoRect r = null;
            if(q == 0){
                r = new AutoRect(this.Border.x(),
                    this.Border.y()+(int)this.Border.h(),
                    this.Border.w(),
                    this.Border.h());
            }else if(q == 1){
                r = new AutoRect(this.Border.x(),
                    this.Border.y()-(int)this.Border.h(),
                    this.Border.w(),
                    this.Border.h());
            }else if(q == 2){
                r = new AutoRect(this.Border.x()-(int)this.Border.w(),
                    this.Border.y(),
                    this.Border.w(),
                    this.Border.h());
            }else if(q == 3){
                r = new AutoRect(this.Border.x()+(int)this.Border.w(),
                this.Border.y(),
                this.Border.w(),
                this.Border.h());
            }
            return r;
        }
        protected string get_script(int index){
            return gen_scripts[index];
        }
        protected bool decrement_ticks(){
            if(generator_ticks > 0){
                generator_ticks--;
                return true;
            }else{
                return false;
            }
        }
	}
}
