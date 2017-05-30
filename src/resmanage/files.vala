namespace LAIR{
	class LairFile : Scribe {
		private string Path = null;
		private string Name = null;
		private List<string> Tags = null;//new List<string>();
		public LairFile.WithPath(string path){
                        base.new_local_attributes(4, "file:");
			Path = set_path(path);
		}
                public LairFile.WithAttList(List<string> atts){
                        base.new_local_attributes(4, "file:");
                        string path = null;
                        List<string> tags = new List<string>();
                        int x = 0;
                        foreach (string attribute in atts){
                                if (x == 0){
                                        path = atts.nth_data(x);
                                        Path = set_path(path);
                                }else if(x == 1){
                                        Name = atts.nth_data(x);
                                }else{
                                        tags.append(atts.nth_data(x));
                                }
                                x++;
                        }
                        set_tags(tags);
                }
		protected List<string*> set_tags(List<string> tags){
                        if(Tags == null){Tags = new List<string>();}
			foreach (string tag in tags){
				if (has_tag(tag) == false){
					Tags.append(tag);
				}
			}
			return Tags.copy();
		}
                protected string set_path(string path){
                        string []tmp = path.split(" ", 2);
                        string tmp2 = tmp[0].replace("/usr/share/", Environment.get_user_config_dir());
                        tmp2 = tmp2.replace("/", "\\");
			if (FileUtils.test(tmp[0], FileTest.EXISTS)) {
				Path = tmp[0];
				message("Setting Path: %s\n", Path);
			}else if(FileUtils.test(tmp2, FileTest.EXISTS)) {
                                Path = tmp2;
				message("Setting Path: %s\n", Path);
                        }else{
				Path = null;
				message("Setting Path failed: %s doesn't exist\n", Path);
			}
			return path;
		}
		/*public List<string*> get_tags(){
			return Tags.copy();
		}*/
                public bool has_name(string query){
			bool tmp = false;
                        bool ptd = false;
			if ( query == Name ) {
				tmp = true;
                                if (!ptd){
                                        message("Name found in FileDB: %s", query);
                                        ptd = true;
                                }
			}
			return tmp;
		}
		public bool has_tag(string query){
			bool tmp = false;
			foreach (string Tag in Tags.copy()){
				if ( query == Tag ) {
					tmp = true;
					break;
				}
			}
			return tmp;
		}
                public bool has_tag_list(List<string> queryList){
                        bool rtmp = true;
                        int i = 0, j = 0;
                        //for(i = 0; i < queryList.length(); i++){
                        foreach(string query in queryList.copy()){
                                //for(j = 0; j < Tags.length(); j++){
                                foreach(string tag in Tags.copy()){
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
                                message("Found taglist: ");
                                foreach(string t in Tags){
                                        message("%s ", t);
                                }
                                message("\n");
                        }
			return rtmp;
		}
		public string get_path(){
                        message("Getting Path: %s\n", Path);
                        return Path;
		}
		public bool check_path(){
			if (Path != null){
				message("Validating Path: %s\n", Path);
				return true;
			}else{
				message("Validating Path failed: %s doesn't exist.\n", Path);
				return false;
			}
		}
                public int len_of_config(){
                        int Length = 0;
			var file = File.new_for_path(Path);
                        int r = 0;
			if (!file.query_exists ()) {
				message("File '%s' doesn't exist.\n", file.get_path ());
			}
                        if (Length == 0){
                                try {
                                        var dis = new DataInputStream (file.read());
                                        string line;
                                        while ((line = dis.read_line (null)) != null) {
                                                r++;
                                        }
                                        message("Configuration File Length %s\n", r.to_string());
                                } catch (Error e) {
                                        error ("%s", e.message);
                                }
                                Length = r;
                        }
                        r = Length;
			return r;
		}
                public List<string> get_config_line(int lineNum){
                        List<string> tmp = new List<string>();
                        var file = File.new_for_path(Path);
                        message("line %s\n", lineNum.to_string());
			if (!file.query_exists ()) {
				message("File '%s' doesn't exist.\n", file.get_path ());
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
                                                        message("Loaded Resource: %s\n", tl[0]);
                                                }else{
                                                        message("Failed to load Resource: %s\n", tl[0]);
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
