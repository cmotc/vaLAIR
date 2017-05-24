using Lua;
using SDL;
namespace LAIR{
	class LuaConf : LuaGlobal{
                private string ScriptPath = "";
                public LuaConf(string lua_ai_path, int lua_log_level, string name){
                        base(lua_ai_path, lua_log_level, name);
                        ScriptPath = lua_ai_path;
                        print_withname("Loading a dungeon generator script: %s\n", ScriptPath);
                        lua_do_file();//ScriptPath);
                }
                private void lua_do_file(){ //(string file){
                        if(does_it_ai()){
                                if(ScriptPath != "immobile"){
                                        global_vm_pointer()->do_file(ScriptPath);
                                }
                        }
                }
                private void lua_new_table(){
                        if(does_it_ai()){
                                if(ScriptPath != "immobile"){
                                        global_vm_pointer()->new_table();
                                }
                        }
                }
                private void lua_push_named_number(string key, int val = -2147483647){
                        if(does_it_ai()){
                                if( key != null){
                                        global_vm_pointer()->push_string(key);
                                        global_vm_pointer()->push_number(val);
                                        global_vm_pointer()->raw_set(-3);
                                }else{
                                        key = "error";
                                        string errval = "Error pushing entry to global Lua table. Key was null. Value was: " + val.to_string();
                                        print_withname(errval);
                                        global_vm_pointer()->push_string(key);
                                        global_vm_pointer()->push_string(errval);
                                        global_vm_pointer()->raw_set(-3);
                                }
                        }
                }
                private void lua_push_named_strings(List<string> vals){
                        if(does_it_ai()){
                                int key = 0;
                                foreach(string val in vals){
                                        if( key > -1){
                                                global_vm_pointer()->push_string(key.to_string());
                                                global_vm_pointer()->push_string(val);
                                                global_vm_pointer()->raw_set(-3);
                                        }else{
                                                global_vm_pointer()->push_string(key.to_string());
                                                //global_vm_pointer()->push_string("Error pushing entry to global Lua table. Key was null. Value was: " + val);
                                                string errval = "Error pushing entry to global Lua table. Key was null.";
                                                print_withname(errval);
                                                //global_vm_pointer()->raw_set(-2);
                                        }
                                        key++;
                                }
                        }
                        /*if( key > 0 ){
                                global_vm_pointer()->raw_set(-3);
                        }*/
                        //int key2 = (int) ( (vals.length() * 2) + 1 ) * -1;
                        //int key2 = -2;
                        //global_vm_pointer()->raw_set(key2);
                }
                private void lua_close_table(string tableName){
                        if(does_it_ai()){
                                if(tableName != null){
                                        global_vm_pointer()->set_global (tableName);
                                }else{
                                        print_withname("something is wrong, table name cannot be null\n");
                                }
                        }
                }
                protected List<string> get_lua_last_return(){
                        string tmp = "";
                        List<string> tr = new List<string>();
                        if(does_it_ai()){
                                if(global_vm_pointer()->get_top() > 0){
                                        if(global_vm_pointer()->is_number(-1)){
                                                double number = global_vm_pointer()->to_number(-1);
                                                tmp += number.to_string();
                                                global_vm_pointer()->pop(1);
                                        }else if(global_vm_pointer()->is_string(-1)){
                                                string word = global_vm_pointer()->to_string(-1);
                                                tmp += word;
                                                global_vm_pointer()->pop(1);
                                        }else if(global_vm_pointer()->is_boolean(-1)){
                                                bool word = global_vm_pointer()->to_boolean(-1);
                                                tmp += word.to_string();
                                                global_vm_pointer()->pop(1);
                                        }
                                }
                                //print_withname(" %s \n", tmp);
                                string[] tl = tmp.split(" ", 0);
                                for(int i = 0; i < tl.length; i++){
                                        if(tl[i] != null){
                                                print_noname(" %s ", tl[i]);
                                                tr.append(tl[i]);
                                        }
                                }
                        }
                        return tr;
                }
                /*protected void lua_register(string name, CallbackFunc f){                        global_vm_pointer()->register(name, f);                }*/
                protected void lua_do_function(string function){
                        if(does_it_ai()){
                                string tmp = "return " + function;
                                global_vm_pointer()->do_string(tmp);
                        }
                }
                protected void lua_push_uint_to_table(string tablename, string varname, uint varval){
                        if(does_it_ai()){
                                lua_new_table();
                                int tmp = (int) varval;
                                print_withname("Creating new Lua table: %s. ", tablename);
                                print_noname(" Containing field: %s. ", varname);
                                print_noname(" of value: %s. \n", varval.to_string());
                                lua_push_named_number(varname,tmp);
                                lua_close_table(tablename);
                        }
                }
                protected void lua_push_coords(Video.Point current, Video.Point simplecurrent){
                        if(does_it_ai()){
                                lua_new_table();
                                lua_push_named_number("x", current.x);
                                lua_close_table("generator_x");

                                lua_new_table();
                                lua_push_named_number("y", current.y);
                                lua_close_table("generator_y");

                                lua_new_table();
                                lua_push_named_number("x", simplecurrent.x);
                                lua_close_table("generator_coarse_x");

                                lua_new_table();
                                lua_push_named_number("y", simplecurrent.y);
                                lua_close_table("generator_coarse_y");
                        }
                }
                protected void lua_push_string_to_table(string tablename, string val){
                        if(does_it_ai()){
                                lua_new_table();
                                global_vm_pointer()->push_string(tablename);
                                global_vm_pointer()->push_string(val);
                                global_vm_pointer()->raw_set(-3);
                                lua_close_table(tablename);
                        }
                }
                protected void lua_push_strings_to_table(string tablename, List<string> varvals){
                        if(does_it_ai()){
                                lua_new_table();
                                //string tmp = varval;
                                lua_push_named_strings(varvals);
                                lua_close_table(tablename);
                        }
                }
                protected void lua_push_dimensions(Video.Rect current){
                        if(does_it_ai()){
                                lua_new_table();
                                lua_push_named_number("x", (int) current.x);
                                lua_close_table("room_x");

                                lua_new_table();
                                lua_push_named_number("y", (int) current.y);
                                lua_close_table("room_y");

                                lua_new_table();
                                lua_push_named_number("x", (int) current.x / 32);
                                lua_close_table("room_coarse_x");

                                lua_new_table();
                                lua_push_named_number("y", (int) current.y / 32);
                                lua_close_table("room_coarse_y");

                                lua_new_table();
                                lua_push_named_number("w", (int) current.w);
                                lua_close_table("generator_w");

                                lua_new_table();
                                lua_push_named_number("h", (int) current.h);
                                lua_close_table("generator_h");

                                lua_new_table();
                                lua_push_named_number("w", (int) current.w / 32);
                                lua_close_table("generator_coarse_w");

                                lua_new_table();
                                lua_push_named_number("h", (int) current.h / 32);
                                lua_close_table("generator_coarse_h");

                                lua_new_table();
                                lua_push_named_number("x", (int) ((current.x / 32) + (current.w / 32)));
                                lua_close_table("room_coarse_xw");

                                lua_new_table();
                                lua_push_named_number("y", (int) ((current.y / 32) + (current.y / 32)));
                                lua_close_table("room_coarse_yh");

                                lua_new_table();
                                lua_push_named_number("x", (int) (current.x + current.w));
                                lua_close_table("room_xw");

                                lua_new_table();
                                lua_push_named_number("y", (int) (current.y + current.y));
                                lua_close_table("room_yh");
                        }
                }
                protected unowned LuaVM get_lua_vm(){
                        return global_vm_copy();
                }
        }
}
