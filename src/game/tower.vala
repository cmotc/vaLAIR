using SDL;
namespace LAIR{
	class Tower : Object{
		private List<Floor> floors = new List<Floor>();
		public Tower(string size){
			int w = 320;
			int h = 320;
			int count = 10;
			if (size == "giant"){
				w = 1280;
				h = 1280;
				count = 30;
			}else if (size == "large"){
				w = 640;
				h = 640;
				count = 20;
			}else if (size == "medium"){
				w = 320;
				h = 320;
				count = 10;
			}else if (size == "small"){
				w = 320;
				h = 320;
				count = 8;
			}else if (size == "tiny"){
				w = 240;
				h = 240;
				count = 4;
			}
			for (int c = 0; c <= count; c++){
				stdout.printf("Creating new floor : %s \n", c.to_string());
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
