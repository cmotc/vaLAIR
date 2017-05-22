namespace LAIR{
	class Type : LuaConf {
		private bool player = false;
                private bool floor = false;
                private bool wall = false;
                private bool mobile = false;
                private List<Tag> tags = new List<Tag>();
                public Type(string lconf = "immobile"){
                        if ( lconf != "immobile"){
                                base.with_ai(
                                        ((lconf == "") ? "immobile" : lconf ),
                                        6,"entity");
                        }
                        player = false;
                        tags = new List<string>();
                        set_type("default");
                        int b = 0;
                }
                public Type.ParameterList(List<string> types, string lconf = "immobile"){
                        if ( lconf != "immobile"){
                                base.with_ai(
                                        ((lconf == "") ? "immobile" : lconf ),
                                        6,"entity");
                        }
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                        if (player) {
                                set_type("blocked");
                        }
                        int b = 0;
                }
                private void check_types(){
                        foreach(Tag tag in tags){
                                player = tag.has_tag("player");
                                floor = tag.has_tag("floor");
                                wall = tag.has_tag("wall");
                                mobile = tag.has_tag("mobile");
                        }
                }
                private bool check_new_type(string new_type){
                        bool r = false;
                        foreach(Tag tag in tags){
                                r = tag.has_tag(new_type)
                        }
                        return r;
                }
                protected void insert_type(string new_type){
                        if(check_new_type(new_type)){
                                tags.append(new_type);
                                print_withname("   Added tag: %s \n", new_type);
                                check_types();
                        }
                }
		protected bool get_block(){
                        if(){
                        }
		}
		public bool is_player(){
			return player;
		}
                public unowned List<string> get_tags(){
                        unowned List<string> r = tags;
                        return r;
                }
                protected string stringify_tags(){
                        string r = " tags:";
                        foreach(string i in tags.copy()){
                                r += i;
                                r += " ";
                        }
                        print_withname(r);
                        return r;
                }
                public List<string> one_tag_to_list(string ip){
                        List<string> r = new List<string>();
                        r.append(ip);
                        foreach(string s in r){
                                print_withname(s);
                        }
                        return r;

                }
                public string get_category(){
                        string r = "uncategorized";
                        if (mobile) {
                                r = "mobile ";
                        }else if (wall) {
                                r = "particle ";
                        }
                        return r;
                }
	}
}
