using Gee;
using SDL;
using SDLImage;
using Xml;
using Xml.XPath;
namespace LAIR{
	class Tiles : GLib.Object{
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
	class ImageResource : GLib.Object{
		Graphics.Surface rSurface;
		ArrayList<string> rCategory = new ArrayList<string>();
		ArrayList<string> rTags = new ArrayList<string>();
		public ImageResource(string TilePath){
			//rSurface = SDLImage.load(TilePath);
		}
	}
}