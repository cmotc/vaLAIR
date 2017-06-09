using Lua;
using SDL;
namespace LAIR{
	class LuaConf : LuaGlobal{
                private string script_path = "immobile";
                public LuaConf(string lua_ai_path = "immobile", int lua_log_level=1, string name="Local lua VM: "){
                        base(lua_ai_path, lua_log_level, name);
                        script_path = lua_ai_path;
                        if(does_it_ai(script_path)){
                                message("Loading a script: %s", script_path);
                                lua_do_file();
                        }
                }
                private void lua_do_file(){ //(string file){
                        if(does_it_ai(script_path)){
                                if(script_path != "immobile"){
                                        global_vm_copy().do_file(script_path);
                                }
                        }
                }
                private void lua_new_table(){
                        if(does_it_ai(script_path)){
                                if(script_path != "immobile"){
                                        global_vm_copy().new_table();
                                }
                        }
                }
                private void lua_push_named_number(string key, int val = -2147483647){
                        if(val != -2147483647){
                                if(does_it_ai(script_path)){
                                        if( key != null){
                                                global_vm_copy().push_string(key);
                                                global_vm_copy().push_number(val);
                                                global_vm_copy().raw_set(-3);
                                        }else{
                                                key = "error";
                                                string errval = "Error pushing entry to global Lua table. Key was null. Value was: " + val.to_string();
                                                message(errval);
                                                global_vm_copy().push_string(key);
                                                global_vm_copy().push_string(errval);
                                                global_vm_copy().raw_set(-3);
                                        }
                                }
                        }
                }
                private void lua_push_named_strings(List<string> vals){
                        if(does_it_ai(script_path)){
                                int key = 0;
                                foreach(string val in vals){
                                        if( key >= 0 ){
                                                global_vm_copy().push_string(key.to_string());
                                                global_vm_copy().push_string(val);
                                                global_vm_copy().raw_set(-3);
                                        }else{
                                                global_vm_copy().push_string(key.to_string());
                                                //global_vm_copy().push_string("Error pushing entry to global Lua table. Key was null. Value was: " + val);
                                                string errval = "Error pushing entry to global Lua table. Key was null.";
                                                message(errval);
                                                //global_vm_copy().raw_set(-3);
                                        }
                                        key++;
                                }
                        }
                }
                private void lua_close_table(string tableName){
                        if(does_it_ai(script_path)){
                                if(tableName != null){
                                        global_vm_copy().set_global (tableName);
                                }else{
                                        message("something is wrong, table name cannot be null");
                                }
                        }
                }
                protected List<string> get_lua_last_return(){
                        string tmp = "";
                        List<string> tr = null;
                        if(does_it_ai(script_path)){
                                if(global_vm_copy().get_top() > 0){
                                        tr = new List<string>();
                                        if(global_vm_copy().is_number(-1)){
                                                double number = global_vm_copy().to_number(-1);
                                                tmp += number.to_string();
                                                global_vm_copy().pop(1);
                                        }else if(global_vm_copy().is_string(-1)){
                                                string word = global_vm_copy().to_string(-1);
                                                tmp += word;
                                                global_vm_copy().pop(1);
                                        }else if(global_vm_copy().is_boolean(-1)){
                                                bool word = global_vm_copy().to_boolean(-1);
                                                tmp += word.to_string();
                                                global_vm_copy().pop(1);
                                        }
                                }
                                message(" %s ", tmp);
                                string[] tl = tmp.split(" ", 0);
                                for(int i = 0; i < tl.length; i++){
                                        if(tl[i] != null){
                                                message(" %s ", tl[i]);
                                                tr.append(tl[i]);
                                        }
                                }
                        }
                        return tr;
                }
                /*protected void lua_register(string name, CallbackFunc f){                        global_vm_copy().register(name, f);                }*/
                protected void lua_do_function(string function){
                        if(does_it_ai(script_path)){
                                string tmp = "return " + function;
                                global_vm_copy().do_string(tmp);
                        }
                }
                protected void lua_push_uint_to_table(string tablename = "none", string varname = "none", int varval = -2147483647){
                        if(tablename != "none"){
                                if(tablename != "none"){
                                        if(does_it_ai(script_path)){
                                                lua_new_table();
                                                message("Creating new Lua table: %s.", tablename);
                                                message(" Containing field: %s.", varname);
                                                message(" of value: %s.", varval.to_string());
                                                lua_push_named_number(varname, varval);
                                                lua_close_table(tablename);
                                        }
                                }
                        }
                }
                protected void lua_push_coords(AutoPoint current, AutoPoint simplecurrent){
                        if(does_it_ai(script_path)){
                                lua_new_table();
                                lua_push_named_number("x", current.x());
                                lua_close_table("generator_x");

                                lua_new_table();
                                lua_push_named_number("y", current.y());
                                lua_close_table("generator_y");

                                lua_new_table();
                                lua_push_named_number("x", simplecurrent.x());
                                lua_close_table("generator_coarse_x");

                                lua_new_table();
                                lua_push_named_number("y", simplecurrent.y());
                                lua_close_table("generator_coarse_y");
                        }
                }
                protected void lua_push_string_to_table(string tablename, string val = "none"){
                        if(val != "none"){
                                if(does_it_ai(script_path)){
                                        lua_new_table();
                                        global_vm_copy().push_string(tablename);
                                        global_vm_copy().push_string(val);
                                        global_vm_copy().raw_set(-3);
                                        lua_close_table(tablename);
                                }
                        }
                }
                protected void lua_push_strings_to_table(string tablename = "none", List<string> varvals = null){
                        if(tablename != "none"){
                                if(varvals != null){
                                        if(does_it_ai(script_path)){
                                                lua_new_table();
                                                lua_push_named_strings(varvals);
                                                lua_close_table(tablename);
                                        }
                                }
                        }
                }
                protected void lua_push_dimensions(AutoRect current){
                        if(does_it_ai(script_path)){
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("x", (int) current.x());
                                lua_close_table("room_x");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("y", (int) current.y());
                                lua_close_table("room_y");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("x", (int) current.x() / 32);
                                lua_close_table("room_coarse_x");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("y", (int) current.y() / 32);
                                lua_close_table("room_coarse_y");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("w", (int) current.w());
                                lua_close_table("generator_w");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("h", (int) current.h());
                                lua_close_table("generator_h");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("w", (int) current.w() / 32);
                                lua_close_table("generator_coarse_w");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("h", (int) current.h() / 32);
                                lua_close_table("generator_coarse_h");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("x", (int) ((current.x() / 32) + (current.w() / 32)));
                                lua_close_table("room_coarse_xw");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("y", (int) ((current.y() / 32) + (current.h() / 32)));
                                lua_close_table("room_coarse_yh");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("x", (int) (current.x() + current.w()));
                                lua_close_table("room_xw");
                                /*
                                *///
                                lua_new_table();
                                lua_push_named_number("y", (int) (current.y() + current.h()));
                                lua_close_table("room_yh");
                        }
                }
                protected unowned LuaVM get_lua_vm(){
                        return global_vm_copy();
                }
        }
}
