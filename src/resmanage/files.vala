namespace LAIR{
	public class LairFile : GLib.Object {
		private string Path = null;
		private List<string> Tags = new List<string>();
		public LairFile(){
			Path = null;
		}
		public LairFile.WithPath(string path){
			Path = SetPath(path);
		}
		public LairFile.WithPathandTags(string path, List<string> tags){
			Path = SetPath(path);
			SetTags(tags);
		}
		protected List<string>* SetTags(List<string> tags){
			foreach (string tag in tags){
				if (HasTag(tag) == false){
					Tags.append(tag);
				}
			}
			return Tags;
		}
		public List<string>* GetTags(){
			return Tags;
		}
		public bool HasTag(string query){
			bool tmp = false;
			foreach (string Tag in Tags){
				if ( query == Tag ) {
					tmp = true;
					break;
				}
			}
			return tmp;
		}
		public string GetPath(){
			return Path;
		}
		protected string SetPath(string path){
			if (FileUtils.test(path, FileTest.EXISTS)) {
				Path = path;
			}else{
				Path = null;
			}
			return path;
		}
		public bool CheckPath(){
			if (Path != null){
				return true;
			}else{
				return false;
			}
		}
		public List<string> LoadLineDelimitedConfig(){
			List<string> tmp = new List<string>();
			var file = File.new_for_path(Path);
			if (!file.query_exists ()) {
				stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
			}
			try {
				var dis = new DataInputStream (file.read());
				string line;
				while ((line = dis.read_line (null)) != null) {
					if (FileUtils.test(line, FileTest.EXISTS)) {
						tmp.append(line);
					}
				}
			} catch (Error e) {
				error ("%s", e.message);
			}
			return tmp;
		}
	}
}