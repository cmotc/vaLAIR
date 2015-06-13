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
		string rCategory = null;
		ArrayList<string> rTags = new ArrayList<string>();
		public ImageResource(string TilePath){
			Parser.init();
			Xml.Doc* doc = Parser.parse_doc(TilePath);
			if(doc!=null){
				Context ctx = new Context(doc);
				if(ctx!=null){
					Xml.XPath.Object* obj = ctx.eval_expression("/path/");
					if(obj!=null){
				                Xml.Node* node = null;
						if(obj->nodesetval != null && obj->nodesetval->item(0) != null){
							node = obj->nodesetval->item(0);
							temp.add(node->get_content());
							t++;
						}
						delete node;
						delete obj;
					}
					Xml.XPath.Object* obj = ctx.eval_expression("/category/");
					if(obj!=null){
				                Xml.Node* node = null;
						if(obj->nodesetval != null && obj->nodesetval->item(0) != null){
							int t = 0;
							while(obj->nodesetval->item(t)!=null){
								node = obj->nodesetval->item(0);
								temp.add(node->get_content());
								t++;
							}
						}
						delete node;
						delete obj;
					}
					Xml.XPath.Object* obj = ctx.eval_expression("/tags/");
					if(obj!=null){
				                Xml.Node* node = null;
						if(obj->nodesetval != null && obj->nodesetval->item(0) != null){
							int t = 0;
							while(obj->nodesetval->item(t)!=null){
								node = obj->nodesetval->item(0);
								temp.add(node->get_content());
								t++;
							}
						}
						delete node;
						delete obj;
					}
				}
				delete doc;
			}
			//rSurface = SDLImage.load(TilePath);
		}
	}
}