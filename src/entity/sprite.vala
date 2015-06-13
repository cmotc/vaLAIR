using SDL;
using SDLImage;
namespace LAIR{
	public class Sprite : Type{
		Graphics.Texture mSprite = null;
		TRect mRectDest = null;
		public Sprite(Graphics.Surface TheSurface){
			LoadSprite(TheSurface);
		}
		public bool IntersectTest(Sprite OtherSprite){
			bool temp = false;
			if((OtherSprite!=null && mSprite!=null)){
				temp = mRectDest.IntersectTest(OtherSprite.GetLocation());
			}
			return temp;
		}
		public TRect GetLocation(){
			return mRectDest;
		}
		public void LoadSprite(Graphics.Surface TheSurface){
			mRectDest = new TRect(TheSurface.w/3, TheSurface.h/4);
			mSprite = Graphics.Texture.create_from_surface(window_renderer, TheSurface);
			assert(mSprite ==null);
		}
		public uint Width(){
			uint w = mRectDest.W();
			return w;			
		}
		public uint Height(){
			uint h = mRectDest.H(); 
			return h;
		}
	}
	public class TRect{
		Graphics.Rect mRect;
		public TRect(uint w, uint h){
			mRect.x = 0;
			mRect.y = 0;
			mRect.w = w;
			mRect.h = h;
		}
		public int X(){
			return mRect.x;
		}
		public int Y(){
			return mRect.y;
		}
		public void setXY(uint x, uint y){
			mRect.x = (int) x ;
			mRect.y = (int) y ;
		}
		public uint W(){
			return mRect.w;
		}
		public uint H(){
			return mRect.h;
		}
		public Graphics.Rect GetRect(){
			return mRect;
		}
		public bool IntersectTest(TRect OtherRect){
			bool temp = false;
			if((!IsZero() && !OtherRect.IsZero())){
				temp = mRect.is_intersecting(OtherRect.GetRect());
			}
			return temp;				
		}
		public bool IsZero(){
			bool temp = false;
			if((mRect.x + mRect.y + mRect.w + mRect.h)==0){
				temp = true;
			}
			return temp;
		}
	}
}