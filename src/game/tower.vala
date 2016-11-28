using SDL;
namespace LAIR{
	class Tower : Object{
		private List<Floor> floors = new List<Floor>();
		public Tower(string size, int rooms, int count){
			int w;
			int h;
			if (size == "giant"){
				w = 1280;
				h = 1280;
			}else if (size == "large"){
				w = 640;
				h = 640;
			}else if (size == "medium"){
				w = 320;
				h = 320;
			}else if (size == "small"){
				w = 320;
				h = 320;
			}else if (size == "tiny"){
				w = 240;
				h = 240;
			}else {
				w = 320;
				h = 320;
			}
			for (int c = 0; c <= count; c++){
				Floor tmp = new Floor(w,h,count);
				floors.append(tmp);
			}
		}
		public void RenderCopy(Video.Renderer* renderer){
			foreach(Floor floor in floors){
				floor.RenderCopy(renderer);
			}
		}
	}
}
