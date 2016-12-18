using SDL;
using SDLImage;
namespace LAIR{
	public class Anim : Type{
                private Video.Rect position = Video.Rect(){x=0,y=0,w=32,h=32};
                private Video.Rect source = Video.Rect(){x=0,y=0,w=32,h=32};
                public Anim(Video.Rect rect){
                        base();
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
                public Anim.Blocked(Video.Rect rect){
                        base.Blocked();
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
                public Anim.Parameter(Video.Rect rect, string tag){
                        base.Parameter(tag);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
                public Anim.ParameterList(Video.Rect rect, List<string> tags){
                        base.ParameterList(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
                public Anim.ParameterBlocked(Video.Rect rect, string tag){
                        base.ParameterBlocked(tag);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
                public Anim.ParameterListBlocked(Video.Rect rect, List<string> tags){
                        base.ParameterListBlocked(tags);
                        position = Video.Rect(){x=rect.x,y=rect.y,w=rect.w,h=rect.h};
                        source = Video.Rect(){x=0,y=0,w=rect.w,h=rect.h};
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s", rect.y.to_string());
                        stdout.printf(" W: %s,", rect.w.to_string());stdout.printf(" H: %s", rect.h.to_string());
                        stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s", position.h.to_string());
                        stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s", source.h.to_string());
                }
		public Video.Rect GetPosition(){
                        //stdout.printf("     Position X: %s,", position.x.to_string());stdout.printf(" Y: %s", position.y.to_string());
                        //stdout.printf(" W: %s,", position.w.to_string());stdout.printf(" H: %s ", position.h.to_string());
			return position;
		}
		public Video.Rect GetSource(){
                        //stdout.printf("     Source X: %s,", source.x.to_string());stdout.printf(" Y: %s", source.y.to_string());
                        //stdout.printf(" W: %s,", source.w.to_string());stdout.printf(" H: %s ", source.h.to_string());
                        return source;
		}
		public int GetWidth(){
			return (int) source.w;
		}
                public int GetHalfWidth(){
                        int hW = (int) source.w/2;
                        return hW;
                }
		public int GetHeight(){
			return (int) source.h;
		}
                public int GetHalfHeight(){
                        int hH = (int) source.h/2;
			return hH;
		}
		public int GetX(){
			return (int) position.x;
		}
		public int GetY(){
			return (int) position.y;
		}
                public Video.Point GetCenter(){
                        Video.Point coords = Video.Point(){x=GetX()+GetHalfWidth(),y=GetY()+GetHalfHeight()};
                        return coords;
                }
                private double RadiansToDegrees(double radians){
                        double r = (180/Math.PI) * radians;
                        return r;
                }
                public double GetAngle(Video.Point cursorPosition){
                        double degrees = 0.0;
                        Video.Point CP = GetCenter();
                        degrees = RadiansToDegrees((Math.atan2(cursorPosition.x - CP.x, CP.y - cursorPosition.y) + 360) % 360);
                        return degrees;
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
