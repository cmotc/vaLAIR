namespace LAIR{
	class Type : Dice {
		private bool player = false;
                private bool floor = false;
                private bool wall = false;
                private bool mobile = false;
                private List<Tag> tags = new List<Tag>();
                public Type(string lua_ai_conf = "immobile"){
                        base(lua_ai_conf);
                        tags.append(new Tag(lua_ai_conf));
                }
                public Type.ParameterList(List<string> types, string lua_ai_conf = "immobile"){
                        base(lua_ai_conf);
                        tags.append(new Tag(lua_ai_conf));
                        foreach(string type in types){
                                tags.append(new Tag(type));
                        }
                }
                public Type.ParameterListBlocked(List<string> types, string lua_ai_conf = "immobile"){
                        base(lua_ai_conf);
                        tags.append(new Tag(lua_ai_conf));
                        foreach(string type in types){
                                tags.append(new Tag(type));
                        }
                }
                public Type.Player(List<string> types, string lua_ai_conf = "immobile"){
                        base(lua_ai_conf);
                        tags.append(new Tag(lua_ai_conf));
                        player = true;
                        foreach(string type in types){
                                tags.append(new Tag(type));
                        }
                }
                public Type.Mobile(List<string> types, string lua_ai_conf){
                        base(lua_ai_conf);
                        tags.append(new Tag(lua_ai_conf));
                        foreach(string type in types){
                                tags.append(new Tag(type));
                        }
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
                                r = tag.has_tag(new_type);
                        }
                        return r;
                }
                private void instant_type(List<string> new_type){
                        foreach(string s in new_type){
                                tags.append(new Tag(s));
                        }
                }
                protected void insert_type(string new_type){
                        if(check_new_type(new_type)){
                                tags.append(new Tag(new_type));
                                message("   Added tag: %s", new_type);
                                check_types();
                        }
                }
                protected void set_type(string new_type){
                        insert_type(new_type);
                }
                protected bool has_type(string hyp_type){
                        bool r = false;
                        foreach(Tag tag in tags){
                                if(tag.has_tag(hyp_type)){
                                        r = true;
                                }
                        }
                        return r;
                }
                protected bool check_type(string hyp_type){
                        return has_type(hyp_type);
                }
		protected bool get_block(){
                        bool r = true;
                        if( floor ){
                                r = false;
                        }
                        return r;
		}
		public bool is_player(){
			return player;
		}
                public unowned List<Tag> get_tags(){
                        unowned List<Tag> r = tags;
                        return r;
                }
                public List<string> get_tags_strings(){
                        List<string> r = new List<string>();
                        foreach(Tag tag in tags){
                                r.append(tag.get_tag_name());
                        }
                        return r;
                }
                protected string stringify_tags(){
                        string r = " tags:";
                        foreach(Tag i in tags.copy()){
                                r += i.get_tag_name();
                                r += " ";
                        }
//                        message(r);
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
        List<string> one_tag_to_list(string ip = ""){
                List<string> r = new List<string>();
                if( ip != "" ){
                        r.append(ip);
                }
                return r;

        }
}
