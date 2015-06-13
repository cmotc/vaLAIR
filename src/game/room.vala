using Gee;
using SDL;
namespace LAIR{
	class Room : Object{
		ArrayList<ArrayList<Entity>> mTiles;
		public Room(ArrayList<Graphics.Surface> blank){
			for(int y=0; y<10; y++){
				mTiles.add(new ArrayList<Entity>());
				for(int x = 0; x<10; x++){
					mTiles.get(x).add(new Entity(blank[0], "", ""));
				}
			}
		}
	}
}