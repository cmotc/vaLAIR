using SDL;
using SDLImage;
int x_max = 320;
int y_max = 320;

namespace LAIR{
	class Anim : Type{
                private AutoRect position = new AutoRect(0,0,32,32);
                private AutoRect source = new AutoRect(0,0,32,32);
                private AutoRect offsetHitBox = new AutoRect(8,8,16,16);
                private AutoRect rangeOfSight = new AutoRect(160,160,320,320);
                private bool wobble = false;
                private static AutoPoint cursorPosition = new AutoPoint(0,0);
                public Anim(AutoRect rect){
                        base();
                        position = new AutoRect.FromRect(rect.get_rect());
                        source = new AutoRect(0,0,rect.w(),rect.h());
                }
                public Anim.Parameter(AutoRect rect, List<string> tags){
                        base.ParameterList(tags);
                        position = new AutoRect.FromRect(rect.get_rect());
                        source = new AutoRect(0,0,rect.w(),rect.h());
                }
                public Anim.Blocked(AutoRect rect, List<string> tags){
                        base.ParameterListBlocked(tags);
                        position = new AutoRect.FromRect(rect.get_rect());
                        source = new AutoRect(0,0,rect.w(),rect.h());
                }
                public Anim.Mobile(AutoRect rect, string aiScript, List<string> tags){
                        base.Mobile(tags, aiScript);
                        position = new AutoRect.FromRect(rect.get_rect());
                        source = new AutoRect(0,0,rect.w(),rect.h());
                }
                public Anim.Player(AutoRect rect, List<string> tags){
                        base.Player(tags);
                        position = new AutoRect.FromRect(rect.get_rect());
                        source = new AutoRect(0,0,rect.w(),rect.h());
                }
                protected Video.Rect get_source(){
                        return source.get_rect();
		}
                private int do_wobble(){
                        int r = 0;
                        if(wobble == true){
                                r = roll_dice(-2,2);
                        }
                        return r;
                }
                protected void toggle_wobble_on(){
                        wobble = true;
                }
                protected void toggle_wobble_off(){
                        wobble = false;
                }
                protected Video.Rect get_position(AutoPoint offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x() - offset_px.x() - do_wobble(),
                                y = position.y() - offset_px.y() - do_wobble(),
                                w = position.w(),
                                h = position.h()
                        };
			return r;
		}
                protected Video.Rect get_text_source(){
                        return Video.Rect(){x=0,y=0,w=200,h=11};

                }
                protected Video.Rect get_text_position(AutoPoint offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x() - offset_px.x(),
                                y = position.y() - offset_px.y(),
                                w = 200,
                                h = 11
                        };
			return r;
		}

		public int get_width(){
                        int r = 0;
                        if(source.w() >= 0){
                               r = (int) source.w();
                        }
			return r;
		}
                public string stringify_width(){
                        int t = get_width();
                        string r = " w:";
                        if(t > 0){
                                r += t.to_string();
                        }
                        return r;
                }
                public int get_half_width(){
                        int hW = (int) (get_width() / 2);
                        return hW;
                }
		public int get_height(){
                        int r = 0;
                        if(source.h() >= 0){
                               r = (int) source.h();
                        }
			return r;
                }
                public string stringify_height(){
                        int t = get_height();
                        string r = " h:";
                        if(t > 0){
                                r += t.to_string();
                        }
                        return r;
                }
                public int get_half_height(){
                        int hH = (int) (get_height() / 2);
			return hH;
		}
		public int get_x(){
                        int t = position.x();
			return t;
		}
                public string stringify_x(){
                        int t = get_x();
                        string r = " x:";
                        if(t > 0){
                                r += t.to_string();
                        }
                        return r;
                }
		public int get_y(){
                        int t = position.y();
			return t;
		}
                public string stringify_y(){
                        int t = get_y();
                        string r = " y:";
                        if(t > 0){
                                r += t.to_string();
                        }
                        return r;
                }
                public unowned AutoRect get_hitbox(){
                        return position;
                }
                public AutoRect get_range_of_sight(int player_aim = 0){
                        int new_x = ((get_x() + rangeOfSight.x() + (player_aim * 32))>0) ?
                                (get_x() + rangeOfSight.x() + (player_aim * 32)) :
                                -160 + (get_x() + rangeOfSight.x() + (player_aim * 32));
                        int new_y = ((get_y() + rangeOfSight.y() + (player_aim * 32))>0) ?
                                (get_y() + rangeOfSight.y() + (player_aim * 32)) :
                                -160 + (get_y() + rangeOfSight.y() + (player_aim * 32));
                        AutoRect temp = new AutoRect(new_x,
                                new_y,
                                rangeOfSight.w(),
                                rangeOfSight.h());
                        return temp;
                }
                private int get_center_x(){
                        return get_x() + get_half_width();
                }
                private int get_center_y(){
                        return get_y() + get_half_height();
                }
                public AutoPoint get_center(){
                        AutoPoint coords = new AutoPoint(
                                get_center_x(),
                                get_center_y());
                        return coords;
                }
                private double radians_to_degrees(double radians){
                        double r = (180.0/Math.PI) * radians;
                        return r;
                }
                protected void set_cursor_position(int xx, int yy){
                        cursorPosition.set_position(xx, yy);
                }
                public double get_angle(){
                        double degrees = 0.0;
                        if (cursorPosition.x() == 0){
                                if (cursorPosition.y() == 0){
                                        degrees = 0.0;
                                }
                        }else{
                                degrees = radians_to_degrees(Math.atan2(cursorPosition.x() - get_center().x(), cursorPosition.y() - get_center().y()) + 135.0);
                        }
                        return degrees * -1.0;
                }
		public int set_x(int x){
			position.set_x(x);
                        if(position.x() < 0){
                                position.set_x(0);
                        }else if(position.x() > x_max){
                                position.set_x(x_max);
                        }
			return position.x();
		}
		public int set_y(int y){
			position.set_y(y);
                        if(position.y() < 0){
                                position.set_y(0);
                        }else if(position.y() > y_max){
                                position.set_y(y_max);
                        }
			return position.y();
		}
                protected string stringify_coordinates(){
                        //string r = "";
                        string r = stringify_x()
                                + stringify_y()
                                + stringify_width()
                                + stringify_height();
                        return r;
                }
	}
}
