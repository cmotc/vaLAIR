using SDL;
using SDLImage;
namespace LAIR{
	class Anim : Type{
                private Video.Rect position = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect source = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect offsetHitBox = Video.Rect(){ x=7, y=7, w=16, h=16 };
                private Video.Point cursorPosition = Video.Point(){x=0,y=0};
                public Anim(Video.Rect rect){
                        base();
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Blocked(Video.Rect rect){
                        base.Blocked();
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.Parameter(Video.Rect rect, string tag){
                        base.Parameter(tag);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.ParameterList(Video.Rect rect, List<string> tags){
                        base.ParameterList(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.ParameterBlocked(Video.Rect rect, string tag){
                        base.ParameterBlocked(tag);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Anim.ParameterListBlocked(Video.Rect rect, List<string> tags){
                        base.ParameterListBlocked(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                }
                public Video.Rect GetPosition(Video.Point offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x - offset_px.x,
                                y = position.y - offset_px.y,
                                w = position.w,
                                h = position.h
                        };
			return r;
		}
                public Video.Rect GetTextSource(){
                        return Video.Rect(){x=0,y=0,w=200,h=11};

                }
                public Video.Rect GetTextPosition(Video.Point offset_px){
                        Video.Rect r = Video.Rect(){
                                x = position.x - offset_px.x,
                                y = position.y - offset_px.y,
                                w = 200,
                                h = 11
                        };
			return r;
		}
		public Video.Rect GetSource(){
                        return source;
		}
		public int GetWidth(){
			return (int) source.w;
		}
                public int GetHalfWidth(){
                        int hW = (int) (position.w / 2);
                        return hW;
                }
		public int GetHeight(){
			return (int) source.h;
		}
                public int GetHalfHeight(){
                        int hH = (int) (position.h / 2);
			return hH;
		}
		public unowned int get_x(){
                        //int t = 0;
                        //if(!position.is_empty()){
                        unowned int t = position.x;
                        //if(&position != null){
                                //Video.Rect p = new Video.Rect(){x=0,y=0,w=32,h=32};
                                //p = position;
                                //Video.Rect* p = &position;
                                //if(!position.is_equal(Video.Rect(){x=0,y=0,w=32,h=32})){
                                //t = &position.x;
                                //t = (int) p.x;
                        //}
			return t;
		}
		public unowned int get_y(){
                        //int t = 0;
                        //if(!position.is_empty()){
                        unowned int t = position.y;
                        //if(&position != null){
                                //Video.Rect p = new Video.Rect(){x=0,y=0,w=32,h=32};
                                //p = position;
                                //Video.Rect* p = &position;
                                //if(!position.is_equal(Video.Rect(){x=0,y=0,w=32,h=32})){
                                //t = &position.y;
                        //}
			return t;
		}
                public Video.Rect get_hitbox(){
                        Video.Rect r = Video.Rect(){x=0,y=0,w=0,h=0};
                        if(GetBlock()){
                                if(IsPlayer()){
                                        r = Video.Rect(){ x = get_x() + offsetHitBox.x,
                                                y = get_y() + offsetHitBox.y,
                                                w = offsetHitBox.w,
                                                h = offsetHitBox.h };
                                }else{
                                        r = Video.Rect(){ x = get_x() + 1,
                                                y = get_y() + 1,
                                                w = (GetWidth() - 1),
                                                h = (GetHeight() - 1) };
                                }
                        }
                        return r;
                }
                public Video.Point GetCenter(){
                        Video.Point coords = Video.Point(){x=get_x()+GetHalfWidth(), y=get_y()+GetHalfHeight()};
                        return coords;
                }
                private double RadiansToDegrees(double radians){
                        double r = (180/Math.PI) * radians;
                        return r;
                }
                protected void SetCursorPosition(Video.Point cursor){
                        cursorPosition = cursor;
                }
                public double GetAngle(){
                        double degrees = 0.0;
                        if (cursorPosition.x == 0){
                                if (cursorPosition.y == 0){
                                        degrees = 0.0;
                                }
                        }else{
                                degrees = RadiansToDegrees(Math.atan2(cursorPosition.x - GetCenter().x, cursorPosition.y - GetCenter().y) + 135);
                        }
                        return degrees * -1;
                }
		public int SetX(int x){
			position.x = x;
			return position.x;
		}
		public int SetY(int y){
			position.y = y;
			return position.y;
		}
	}
}
