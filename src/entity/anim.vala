using SDL;
using SDLImage;
namespace LAIR{
	class Anim : Type{
                private Video.Rect position = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect source = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect offsetHitBox = Video.Rect(){ x=7, y=7, w=16, h=16 };
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
                public Anim.Player(Video.Rect rect, List<string> tags){
                        base.Player(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                protected Video.Rect get_source(){
                        return source;
		}
                protected Video.Rect get_position(Video.Point offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x - offset_px.x,
                                y = position.y - offset_px.y,
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
			return (int) source.w;
		}
                public int get_half_width(){
                        int hW = (int) (position.w / 2);
                        return hW;
                }
		public int get_height(){
			return (int) source.h;
		}
                public int get_half_height(){
                        int hH = (int) (position.h / 2);
			return hH;
		}
		public unowned int get_x(){
                        unowned int t = position.x;
			return t;
		}
		public unowned int get_y(){
                        unowned int t = position.y;
			return t;
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
                public Video.Point get_center(){
                        Video.Point coords = Video.Point(){x=get_x()+get_half_width(), y=get_y()+get_half_height()};
                        return coords;
                }
                private double radians_to_degrees(double radians){
                        double r = (180/Math.PI) * radians;
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
                                degrees = radians_to_degrees(Math.atan2(cursorPosition.x - get_center().x, cursorPosition.y - get_center().y) + 135);
                        }
                        return degrees * -1;
                }
		public int set_x(int x){
			position.x = x;
			return position.x;
		}
		public int set_y(int y){
			position.y = y;
			return position.y;
		}
	}
}
