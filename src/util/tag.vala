namespace LAIR{
	class Tag {
        private string tag_name = "";
        private bool lose_tag = false;
        public Tag(string init_tag){
            tag_name = init_tag;
        }
        public bool has_tag(string test){
            bool t = false;
            if (test == tag_name){
                t = true;
            }
            if (lose_tag){
                t = false;
            }
            return t;
        }
        public string get_tag_name(){
            return tag_name;
        }
    }
    /*List<Tag> create_tag_list(List<string> todo_list){
        List<Tag> created_list = new List<Tag>();
        foreach(string s in todo_list){
            created_list.append(new Tag(s));
        }
        return created_list;
    }*/
}
