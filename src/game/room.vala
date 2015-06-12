using Gee;
namespace LAIR{
	class Room : Object{
		ArrayList<ArrayList<Entity>> mTiles;
		public Room(){
			for(int y=0; y<10; y++){
				mTiles.add(new ArrayList<Entity>());
				for(int x = 0; x<10; x++){
					mTiles.get(x).add(new Entity("asset/nullgraphic.png"));
				}
			}
		}
	}
}