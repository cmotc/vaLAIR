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
                protected void set_lose_tag(){
                        lose_tag = true;
                }
        }
}
