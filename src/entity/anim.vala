using SDL;
using SDLImage;
namespace LAIR{
	public class Anim : Type{
                private Video.Rect position = new Video.Rect();
                public Anim(Video.Rect rect){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                }
                public Anim.Blocked(Video.Rect rect){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                        base.Blocked();
                }
                public Anim.Parameter(Video.Rect rect, string tag){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                        base.Parameter(tag);
                }
                public Anim.ParameterList(Video.Rect rect, List<string> tags){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                        base.ParameterList(tags);
                }
                public Anim.ParameterBlocked(Video.Rect rect, string tag){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                        base.ParameterBlocked(tag);
                }
                public Anim.ParameterListBlocked(Video.Rect rect, List<string> tags){
                        //position = rect;
                        Video.Rect position = new Video.Rect();
                        stdout.printf("     Rect X: %s,", rect.x.to_string());stdout.printf(" Y: %s\n", rect.y.to_string());
                        position.x = rect.x;
                        position.y = rect.y;
                        position.w = rect.w;
                        position.h = rect.h;//*/
                        base.ParameterListBlocked(tags);
                }
		public Video.Rect GetPosition(){
			return position;
		}
		public Video.Rect GetSource(){
			Video.Rect pos = {0, 0, position.w, position.h};
			return pos;
		}
		protected int SetWidth(int width){
			position.w = width;
			return (int) position.w;
		}
		protected int SetHeight(int height){
			position.h = height;
			return (int) position.h;
		}
		public int GetWidth(){
			return (int) position.w;
		}
                public int GetHalfWidth(){
                        int hW = (int) position.w/2;
                        return hW;
                }
		public int GetHeight(){
			return (int) position.h;
		}
                public int GetHalfHeight(){
                        int hH = (int) position.h/2;
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
