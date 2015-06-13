using Gee;
using SDL;
using SDLImage;
namespace LAIR{
	class Tiles : Files{
		ArrayList<ImageResource> rTiles = new ArrayList<ImageResource>();
		public Tiles(ArrayList<string> TilesData){
			foreach(string TileData in TilesData){
				this.AddTile(TileData);
			}
		}
		private void AddTile(string TilePath){
			rTiles.add(new ImageResource(TilePath));
		}
	}
	class ImageResource : Object{
		Graphics.Surface rSurface;
		public ImageResource(string TilePath){
			rSurface = SDLImage.load(TilePath);
		}
	}
}