namespace LAIR{
	public class LairFile : GLib.Object {
		private string Path = null;
		private string Name = null;
		private List<string> Tags = new List<string>();
		public LairFile(){
			Path = null;
		}
		public LairFile.WithPath(string path){
			Path = SetPath(path);
		}
		public LairFile.WithPathandName(string path, string name){
			Path = SetPath(path);
			Name = name;
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
			string []tmp = Path.split(" ", 2);
			return tmp[0];
		}
		protected string SetPath(string path){
			if (FileUtils.test(path, FileTest.EXISTS)) {
				Path = path;
				stdout.printf("Setting Path: %s \n", Path);
			}else{
				Path = null;
				stdout.printf("Setting Path failed: %s doesn't exist \n", Path);
			}
			return path;
		}
		public bool CheckPath(){
			if (Path != null){
				stdout.printf("Validating Path: %s \n", Path);
				return true;
			}else{
				stdout.printf("Validating Path failed: %s doesn't exist. \n", Path);
				return false;
			}
		}
		public List<string> LoadLineDelimitedConfig(){
			List<string> tmp = new List<string>();
			var file = File.new_for_path(Path);
			stdout.printf("Loading configuration file %s \n", Path);
			if (!file.query_exists ()) {
				stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
			}
			try {
				var dis = new DataInputStream (file.read());
				string line;
				while ((line = dis.read_line (null)) != null) {
					string []tl = line.split(" ", 2);
					if (FileUtils.test(tl[0], FileTest.EXISTS)) {
						tmp.append(tl[0]);
						stdout.printf("Loaded Resource: %s \n", tl[0]);
					}else{
						stderr.printf("Failed to load Resource: %s \n", tl[0]);
					}
				}
				stdout.printf("Loaded configuration file %s \n", Path);
			} catch (Error e) {
				error ("%s", e.message);
			}
			return tmp;
		}
	}
}