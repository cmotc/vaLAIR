using Gee;
using Xml;
using Xml.XPath;
namespace LAIR{
	class Files : Fonts{
		string TileResources = "lair/graphic/dollclothes.xml.d/";
		string SpriteResources = "lair/graphic/sprites.xml.d/";
		string DollResources = "lair/graphic/tiles.xml.d/";
		string SoundResources = "lair/sound.xml.d/";
		string FontResources = "lair/font.xml.d/";
		ArrayList<string> STileXMLD = new ArrayList<string>();
		ArrayList<string> SSpriteXMLD = new ArrayList<string>();
		ArrayList<string> SDollXMLD = new ArrayList<string>();
		ArrayList<string> SSoundXMLD = new ArrayList<string>();
		ArrayList<string> SFontXMLD = new ArrayList<string>();
		ArrayList<string> UTileXMLD = new ArrayList<string>();
		ArrayList<string> USpriteXMLD = new ArrayList<string>();
		ArrayList<string> UDollXMLD = new ArrayList<string>();
		ArrayList<string> USoundXMLD = new ArrayList<string>();
		ArrayList<string> UFontXMLD = new ArrayList<string>();
		public Files(){
			STileXMLD = XMLFileList(GetShareDir()+TileResources);
			SSpriteXMLD = XMLFileList(GetShareDir()+SpriteResources);
			SDollXMLD = XMLFileList(GetShareDir()+DollResources);
			SSoundXMLD = XMLFileList(GetShareDir()+SoundResources);
			SFontXMLD = XMLFileList(GetShareDir()+FontResources);
			UTileXMLD = XMLFileList(GetHomeDir()+TileResources);
			USpriteXMLD = XMLFileList(GetHomeDir()+SpriteResources);
			UDollXMLD = XMLFileList(GetHomeDir()+DollResources);
			USoundXMLD = XMLFileList(GetShareDir()+SoundResources);
			UFontXMLD = XMLFileList(GetShareDir()+FontResources);
			base(TilesPathList(), SpritesPathList(), DollPathList(),SoundPathList(),FontPathList());
		}
		private string GetHomeDir(){
			string temp = null;
			temp = Environment.get_home_dir();
			return temp;
		}
		private string GetShareDir(){
			return "/share/";
		}
		private ArrayList<string> XMLFileList(string ConfD){
			string name = null;
			var d = Dir.open(ConfD);
			ArrayList<string> temp = new ArrayList<string>();
			while ((name = d.read_name()) != null) {
				temp.add(name);
			}
			return temp;
		}
		private ArrayList<string> ReadFileNamesFromXML(string XMLFile){
			ArrayList<string> temp = new ArrayList<string>();
			Parser.init();
			Xml.Doc* doc = Parser.parse_file(XMLFile);
			if(doc!=null){
				Context ctx = new Context(doc);
				if(ctx!=null){
					Xml.XPath.Object* obj = ctx.eval_expression("/asset/");
					if(obj!=null){
				                Xml.Node* node = null;
						if(obj->nodesetval != null && obj->nodesetval->item(0) != null){
							int t = 0;
							while(obj->nodesetval->item(t)!=null){
								node = obj->nodesetval->item(t);
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
			return temp;
		}
		public ArrayList<string> TilesPathList(){
			ArrayList<string> temp = new ArrayList<string>();
			foreach(string t in STileXMLD){
				temp.add_all(ReadFileNamesFromXML(t));
			}
			foreach(string v in UTileXMLD){
				temp.add_all(ReadFileNamesFromXML(v));
			}
			return temp;
		}
		public ArrayList<string> SpritesPathList(){
			ArrayList<string> temp = new ArrayList<string>();
			foreach(string t in SSpriteXMLD){
				temp.add_all(ReadFileNamesFromXML(t));
			}
			foreach(string v in USpriteXMLD){
				temp.add_all(ReadFileNamesFromXML(v));
			}
			return temp;
		}
		public ArrayList<string> DollPathList(){
			ArrayList<string> temp = new ArrayList<string>();
			foreach(string t in SDollXMLD){
				temp.add_all(ReadFileNamesFromXML(t));
			}
			foreach(string v in UDollXMLD){
				temp.add_all(ReadFileNamesFromXML(v));
			}
			return temp;
		}
		public ArrayList<string> SoundPathList(){
			ArrayList<string> temp = new ArrayList<string>();
			foreach(string t in SSoundXMLD){
				temp.add_all(ReadFileNamesFromXML(t));
			}
			foreach(string v in USoundXMLD){
				temp.add_all(ReadFileNamesFromXML(v));
			}
			return temp;
		}
		public ArrayList<string> FontPathList(){
			ArrayList<string> temp = new ArrayList<string>();
			foreach(string t in SFontXMLD){
				temp.add_all(ReadFileNamesFromXML(t));
			}
			foreach(string v in UFontXMLD){
				temp.add_all(ReadFileNamesFromXML(v));
			}
			return temp;
		}
	}
}