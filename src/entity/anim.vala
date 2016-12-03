using SDL;
using SDLImage;
namespace LAIR{
	public class Anim : Type{
		private int X = 64;
		private int Y = 64;
		private int W = 32;
		private int H = 32;
                public Anim(int x, int y, int w, int h){
                        X = x;
                        Y = y;
                        W = w;
                        H = h;
                }
		public Video.Rect GetPosition(){
			Video.Rect pos = {X, Y, W, H};
			return pos;
		}
		public Video.Rect GetSource(){
			Video.Rect pos = {0, 0, W, H};
			return pos;
		}
		protected int SetWidth(int width){
			W = width;
			return W;
		}
		protected int SetHeight(int height){
			H = height;
			return H;
		}
		public int GetWidth(){
			return W;
		}
		public int GetHeight(){
			return H;
		}
		public int GetX(){
			return X;
		}
		public int GetY(){
			return Y;
		}
		public int SetX(int x){
			X = x;
			return X;
		}
		public int SetY(int y){
			Y = y;
			return Y;
		}
	}
}