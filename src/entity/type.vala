namespace LAIR{
	class Type : LuaConf {
		private bool player = false;
                private bool floor = false;
                private bool wall = false;
                private bool mobile = false;
                private int b = 0;
                private List<string> tags = new List<string>();
                private GLib.Rand dice_bag = new GLib.Rand();
                public Type(string lconf=""){
                        base(
                                ((lconf == "") ? "immobile" : lconf ),
                                6,"entity");
                        tags = new List<string>();
                        set_type("default");
                }
                public Type.ParameterList(List<string> types, string lconf = ""){
                        base(
                                ((lconf == "") ? "immobile" : lconf),
                                6,"entity");
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                        if (player) {
                                set_type("blocked");
                        }
                }
                public Type.ParameterListBlocked(List<string> types, string lconf = ""){
                        base(
                                ((lconf == "") ? "immobile" : lconf),
                                6,"entity");
                        set_type("blocked");
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                }
                public Type.Mobile(List<string> types, string lconf){
                        base.Mobile(lconf, 6,"entity");
                        set_type("blocked");
                        foreach(string type in types){
                                set_type(type);
                        }
                        player = check_type("player");
                }
                public Type.Player(List<string> types, string lconf = ""){
                        base(
                                ((lconf == "") ? "immobile" : lconf),
                                6,"entity");
                        set_type("blocked");
                        set_type("player");
                        player = true;
                        foreach(string type in types){
                                set_type(type);
                        }
                        print_withname("Generating a player\n");
                }
                protected int roll_dice(int min, int max){
                        return dice_bag.int_range(-1,1);
                }
		protected bool set_type(string NewType){
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
                        if ( NewType == "mobile" ){
                                mobile = true;
                        }
                        if ( NewType == "wall" ){
                                wall = true;
                        }
                        if ( NewType == "floor" ){
                                floor = true;
                        }
                        if ( NewType == "player" ){
                                player = true;
                        }
                        return t;
		}
                protected bool check_type(string hyp_type){
                        bool r = false;
                        if (hyp_type != "player"){
                                foreach(string i in tags.copy()){
                                        if ( i == hyp_type ){
                                                r = true;
                                                break;
                                        }
                                }
                        }else{
                                if (player != true){
                                        foreach(string i in tags.copy()){
                                                if ( i == hyp_type ){
                                                        r = true;
                                                        player = true;
                                                        break;
                                                }
                                        }
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
