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
			if(doc != null){
				Context ctx = new Context(doc);
				if(ctx != null){
					Xml.XPath.Object* obj = ctx.eval_expression("/path/");
					if(obj != null){
				                Xml.Node* node = null;
						if(obj->nodesetval != null && obj->nodesetval->item(0) != null){
							node = obj->nodesetval->item(0);
							rSurface = SDLImage.load(node->get_content());
						}
						delete node;
						delete obj;
					}
					Xml.XPath.Object* objcat = ctx.eval_expression("/category/");
					if(objcat != null){
				                Xml.Node* node = null;
						if(objcat->nodesetval != null && objcat->nodesetval->item(0) != null){
							int t = 0;
							while(objcat->nodesetval->item(t)!=null){
								node = objcat->nodesetval->item(0);
								rCategory = node->get_content();
								t++;
							}
						}
						delete node;
						delete objcat;
					}
					Xml.XPath.Object* objtag = ctx.eval_expression("/tags/");
					if(objtag != null){
				                Xml.Node* node = null;
						if(objtag->nodesetval != null && objtag->nodesetval->item(0) != null){
							int t = 0;
							while(objtag->nodesetval->item(t)!=null){
								node = objtag->nodesetval->item(0);
								rTags.add(node->get_content());
								t++;
							}
						}
						delete node;
						delete objtag;
					}
				}
				delete doc;
			}
		}
	}
}