namespace LAIR{
	public class LairFile : GLib.Object {
		private string Path = null;
		private string Name = null;
		private List<string> Tags = null;//new List<string>();
		public LairFile.WithPath(string path){
			Path = SetPath(path);
		}
                public LairFile.WithAttList(List<string> atts){
                        string path = null;
                        List<string> tags = new List<string>();
                        int x = 0;
                        foreach (string attribute in atts){
                                if (x == 0){
                                        path = atts.nth_data(x);
                                        Path = SetPath(path);
                                }else if(x == 1){
                                        Name = atts.nth_data(x);
                                }else{
                                        tags.append(atts.nth_data(x));
                                }
                                x++;
                        }
                        SetTags(tags);
                }
		protected List<string>* SetTags(List<string> tags){
                        if(Tags == null){Tags = new List<string>();}
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
                public bool HasName(string query){
			bool tmp = false;
                        bool ptd = false;
			if ( query == Name ) {
				tmp = true;
                                if (!ptd){
                                        stdout.printf("Name found in FileDB: %s", query);
                                        ptd = true;
                                }
			}
			return tmp;
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
                public bool HasTagList(List<string> queryList){
                        bool rtmp = true;
                        int i = 0, j = 0;
                        //for(i = 0; i < queryList.length(); i++){
                        foreach(string query in queryList){
                                //for(j = 0; j < Tags.length(); j++){
                                foreach(string tag in Tags){
                                        //if(queryList.nth_data(i) == Tags.nth_data(j)){
                                        if(query == tag){
                                                break;
                                        }else{
                                                j++;
                                        }
                                }
                                i++;
                                if(j == Tags.length()){
                                        rtmp = false;
                                }
                        }
                        if(rtmp){
                                stdout.printf("Found taglist: ");
                                foreach(string t in Tags){
                                        stdout.printf("%s ", t);
                                }
                                stdout.printf("\n");
                        }
			return rtmp;
		}
		public string GetPath(){
                        stdout.printf("Getting Path: %s\n", Path);
                        return Path;
		}
		protected string SetPath(string path){
                        string []tmp = path.split(" ", 2);
			if (FileUtils.test(tmp[0], FileTest.EXISTS)) {
				Path = tmp[0];
				stdout.printf("Setting Path: %s\n", Path);
			}else{
				Path = null;
				stdout.printf("Setting Path failed: %s doesn't exist\n", Path);
			}
			return path;
		}
		public bool CheckPath(){
			if (Path != null){
				stdout.printf("Validating Path: %s\n", Path);
				return true;
			}else{
				stdout.printf("Validating Path failed: %s doesn't exist.\n", Path);
				return false;
			}
		}
		public List<string> LoadLineDelimitedConfig(){
			List<string> tmp = new List<string>();
			var file = File.new_for_path(Path);
			stdout.printf("Loading configuration file %s\n", Path);
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
						stdout.printf("Loaded Resource: %s\n", tl[0]);
					}else{
						stderr.printf("Failed to load Resource: %s\n", tl[0]);
					}
				}
				stdout.printf("Loaded configuration file %s\n", Path);
			} catch (Error e) {
				error ("%s", e.message);
			}
			return tmp;
		}
                public int LenLineDelimitedConfig(){
                        int Length = 0;
			var file = File.new_for_path(Path);
                        int r = 0;
			if (!file.query_exists ()) {
				stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
			}
                        if (Length == 0){
                                try {
                                        var dis = new DataInputStream (file.read());
                                        string line;
                                        while ((line = dis.read_line (null)) != null) {
                                                r++;
                                        }
                                        stdout.printf("Configuration File Length %s\n", r.to_string());
                                } catch (Error e) {
                                        error ("%s", e.message);
                                }
                                Length = r;
                        }
                        r = Length;
			return r;
		}
                public List<string> GetConfigLine(int lineNum){
                        List<string> tmp = new List<string>();
                        var file = File.new_for_path(Path);
                        stdout.printf("line %s\n", lineNum.to_string());
			if (!file.query_exists ()) {
				stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
			}
                        try {
				var dis = new DataInputStream (file.read());
				string line;
                                int x = 0;
				while ((line = dis.read_line (null)) != null) {
                                        if ( x == lineNum ){
                                                string []tl = line.split(" ", 0);
                                                if (FileUtils.test(tl[0], FileTest.EXISTS)) {
                                                        foreach(string token in tl){
                                                                tmp.append(token);
                                                        }
                                                        //tmp.append(line);
                                                        stdout.printf("Loaded Resource: %s\n", tl[0]);
                                                }else{
                                                        stderr.printf("Failed to load Resource: %s\n", tl[0]);
                                                }
                                        }
                                        x++;
				}
			} catch (Error e) {
				error ("%s", e.message);
			}
                        return tmp;
                }
	}
}
