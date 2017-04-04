using SDL;
using SDLImage;
int x_max = 320;
int y_max = 320;

namespace LAIR{
	class Anim : Type{
                private Video.Rect position = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect source = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect offsetHitBox = Video.Rect(){ x=7, y=7, w=16, h=16 };
                private Video.Rect rangeOfSight = Video.Rect(){ x=-160, y=-160, w=320, h=320};
                private bool wobble = false;
                private static Video.Point cursorPosition = Video.Point(){x=0,y=0};
                public Anim(Video.Rect rect){
                        base();
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Parameter(Video.Rect rect, List<string> tags){
                        base.ParameterList(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Blocked(Video.Rect rect, List<string> tags){
                        base.ParameterListBlocked(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Mobile(Video.Rect rect, string aiScript, List<string> tags){
                        base.Mobile(tags, aiScript);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Player(Video.Rect rect, List<string> tags){
                        base.Player(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                protected Video.Rect get_source(){
                        return source;
		}
                private int do_wobble(){
                        int r = 0;
                        if(wobble == true){
                                r = roll_dice(-4,4);
                        }
                        return r;
                }
                protected void toggle_wobble_on(){
                        wobble = true;
                }
                protected void toggle_wobble_off(){
                        wobble = false;
                }
                protected Video.Rect get_position(Video.Point offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x - offset_px.x - do_wobble(),
                                y = position.y - offset_px.y - do_wobble(),
                                w = position.w,
                                h = position.h
                        };
			return r;
		}
                protected Video.Rect get_text_source(){
                        return Video.Rect(){x=0,y=0,w=200,h=11};

                }
                protected Video.Rect get_text_position(Video.Point offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x - offset_px.x,
                                y = position.y - offset_px.y,
                                w = 200,
                                h = 11
                        };
			return r;
		}

		public int get_width(){
                        int r = 0;
                        if(source.w > 0){
                               r = (int) source.w;
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
                        if(source.h > 0){
                               r = (int) source.h;
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
                        int t = position.x;
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
                        int t = position.y;
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
                public Video.Rect get_hitbox(){
                        Video.Rect r = Video.Rect(){x=0,y=0,w=0,h=0};
                        if(get_block()){
                                if(is_player()){
                                        r = Video.Rect(){ x = get_x() + offsetHitBox.x,
                                                y = get_y() + offsetHitBox.y,
                                                w = offsetHitBox.w,
                                                h = offsetHitBox.h };
                                }else{
                                        r = Video.Rect(){ x = get_x() + 1,
                                                y = get_y() + 1,
                                                w = (get_width() - 1),
                                                h = (get_height() - 1) };
                                }
                        }
                        return r;
                }
                public Video.Rect get_range_of_sight(int player_aim = 0){
                        int new_x = ((get_x() + rangeOfSight.x + (player_aim * 32))>0) ?
                                (get_x() + rangeOfSight.x + (player_aim * 32)) :
                                -160 + (get_x() + rangeOfSight.x + (player_aim * 32));
                        int new_y = ((get_y() + rangeOfSight.y + (player_aim * 32))>0) ?
                                (get_y() + rangeOfSight.y + (player_aim * 32)) :
                                -160 + (get_y() + rangeOfSight.y + (player_aim * 32));
                        Video.Rect temp = Video.Rect(){ x = new_x,
                                y = new_y,
                                w = rangeOfSight.w,
                                h = rangeOfSight.h };
                        return temp;
                }
                private int get_center_x(){
                        return get_x() + get_half_width();
                }
                private int get_center_y(){
                        return get_y() + get_half_height();
                }
                public Video.Point get_center(){
                        Video.Point coords = Video.Point(){
                                x=get_center_x(),
                                y=get_center_y()};
                        return coords;
                }
                private double radians_to_degrees(double radians){
                        double r = (180.0/Math.PI) * radians;
                        return r;
                }
                protected void set_cursor_position(Video.Point cursor){
                        cursorPosition = cursor;
                }
                public double get_angle(){
                        double degrees = 0.0;
                        if (cursorPosition.x == 0){
                                if (cursorPosition.y == 0){
                                        degrees = 0.0;
                                }
                        }else{
                                degrees = radians_to_degrees(Math.atan2(cursorPosition.x - get_center().x, cursorPosition.y - get_center().y) + 135.0);
                        }
                        return degrees * -1.0;
                }
		public int set_x(int x){
			position.x = x;
                        if(position.x < 0){
                                position.x = 0;
                        }else if(position.x > x_max){
                                position.x = x_max;
                        }
			return position.x;
		}
		public int set_y(int y){
			position.y = y;
                        if(position.y < 0){
                                position.y = 0;
                        }else if(position.y > y_max){
                                position.y = y_max;
                        }
			return position.y;
		}
                protected string stringify_coordinates(){
                        //string r = "";
                        string r = stringify_x()
                                + stringify_y()
                                + stringify_width()
                                + stringify_height();
                        /*r += " x:";
                        // (get_x() > ) ? : ;
                        r += get_x().to_string();
                        r += " y:";
                        //
                        r += get_y().to_string();
                        r += " w:";
                        //
                        r += get_width().to_string();
                        r += " h:";
                        //
                        r += get_height().to_string();
                        r += " ";*/
                        return r;
                }
	}
}
