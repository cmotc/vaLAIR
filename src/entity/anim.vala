using Gee;
using SDL;
using SDLImage;
using SDLGraphics;
namespace LAIR{
	public class Anim : Sprite{
		TRect[,] mRectSrc;
		int Row = 1;
		int Col = 1;
		public Anim(string Path){
			base(Path);
			mRectSrc = new TRect[3,4];
			for(int x=0; x<3; x++){
				for(int y=0;y<4;y++){
					mRectSrc[x,y] = new TRect(Width(), Height());
					mRectSrc[x,y].setXY(x * Width(), y * Height());
				}
			}
		}
		public void FaceNorth(){
			Row=0;
		}
		public void FaceEast(){
			Row=1;
		}
		public void FaceSouth(){
			Row=2;
		}
		public void FaceWest(){
			Row=3;
		}
		public void Swing(){
		}
		public void Step(){
			int temp = Col+1;
			Col = ( Col > 2 ) ? 0 : temp;
		}
		public void Bleed(){
		}
		public void Heal(){
		}
		public void Ill(){
		}
		public void Aid(){
		}
	}
}