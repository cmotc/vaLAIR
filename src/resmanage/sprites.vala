using Gee;
namespace LAIR{
	class Sprites : Tiles{
		ArrayList<ImageResource> rSprites = new ArrayList<ImageResource>();
		public Sprites(ArrayList<string> TilesData, ArrayList<string> SpritesData){
			base(TilesData);
			foreach(string SpriteData in SpritesData){
				this.AddSprite(SpriteData);
			}
		}
		public void AddSprite(string SpritePath){
			rSprites.add(new ImageResource(SpritePath));
		}
	}
}