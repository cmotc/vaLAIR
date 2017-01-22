namespace LAIR{
	class Type : LuaConf {
		private bool player = false;
                private int b = 0;
                private List<string> tags = new List<string>();
                public Type(string lconf=""){
                        base(((lconf == "") ? "immobile" : lconf),6,"entity");
                        tags = new List<string>();
                        set_type("default");
                }
                public Type.ParameterList(List<string> types, string lconf = ""){
                        base(((lconf == "") ? "immobile" : lconf),6,"entity");
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                        if (player) {
                                set_type("blocked");
                        }
                }
                public Type.ParameterListBlocked(List<string> types, string lconf = ""){
                        base(((lconf == "") ? "immobile" : lconf),6,"entity");
                        set_type("blocked");
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                }
                public Type.Player(List<string> types, string lconf = ""){
                        base(((lconf == "") ? "immobile" : lconf),6,"entity");
                        set_type("blocked");
                        set_type("player");
                        player = true;
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                }
		private bool set_type(string NewType){
                        bool t = true;
                        foreach(string i in tags){
                                if ( i == NewType ){
                                        t = false;
                                }
                        }
                        if (t){
                                tags.append(NewType);
                                print_withname("   Added tag: %s \n", NewType);
                                b = 0;
                        }
                        if ( NewType == "blocked" ){
                                b = 1;
                        }
                        if ( NewType == "player" ){
                                player = true;
                        }
                        return t;
		}
                private bool check_type(string Type){
                        bool r = false;
                        foreach(string i in tags.copy()){
                                if ( i == Type ){
                                        r = true;
                                }
                        }
                        return r;
                }
		protected bool get_block(){
                        bool r = false;
                        if ( b == 0 ){
                                r = check_type("blocked");
                                if ( r == true){
                                        b = 1;
                                }
                        }else if ( b == 1 ){
                                r = true;
                        }

			return r;
		}
		public bool is_player(){
			return player;
		}
                public unowned List<string> get_tags(){
                        unowned List<string> r = tags;
                        return r;
                }
                public string stringify_tags(){
                        string r = "";
                        foreach(string i in tags.copy()){
                                r += i;
                                r += " ";
                        }
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
	}
}
