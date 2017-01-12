using Lua;
using SDL;
namespace LAIR{
	class LuaConf : Scribe{
                private static LuaVM VM;
                private string ScriptPath;
                public LuaConf(string path, int lll, string name){
                        base.LLL(lll, name);
                        VM = new LuaVM();
                        VM.open_libs();
                        ScriptPath = path;
                        prints("Loading a dungeon generator script: %s\n", ScriptPath);
                        VM.do_file(ScriptPath);
                        printc(GetLuaLastReturn().nth_data(0), "\n");
                }
                private void LuaDoFile(string file){
                        VM.do_file(file);
                }
                protected List<string> GetLuaLastReturn(){
                        string tmp = "";
                        if(VM.is_number(-1)){
                                double number = VM.to_number(-1);
                                tmp += number.to_string();
                                VM.pop(1);
                        }else if(VM.is_string(-1)){
                                string word = VM.to_string(-1);
                                tmp += word;
                                VM.pop(1);
                        }else if(VM.is_boolean(-1)){
                                string word = VM.to_string(-1);
                                tmp += word;
                                VM.pop(1);
                        }
                        //prints(" %s \n", tmp);
                        string[] tl = tmp.split(" ", 0);
                        List<string> tr = new List<string>();
                        for(int i = 0; i < tl.length; i++){
                                if(tl[i] != null){
                                        printns(" %s ", tl[i]);
                                        tr.append(tl[i]);
                                }
                        }
                        return tr;
                }
                protected void LuaRegister(string name, CallbackFunc f){
                        VM.register(name, f);
                }
                protected void LuaDoFunction(string function){
                        //LuaDoFile(ScriptPath);
                        string tmp = "return ";
                        //string tmp = function;
                        tmp += function;
                        VM.do_string(tmp);
                }
                //This pushes a series of key-value pairs into a global Lua table.
                /*protected void PushNamedPairToLuaTable(string tableName, string[] membernames, int[] members){
                        int i = 0;
                        if(membernames.length == members.length){
                                //int max = membernames.length - 1;
                                VM.new_table ();
                                foreach(int member in members) {
                                        stdout.printf(" %s ", membernames[i]);
                                        stdout.printf(" %s \n", members[i].to_string());
                                        VM.push_string(membernames[i]);
                                        VM.push_number (member);
                                        i++;
                                }
                                VM.raw_set (((i-(i*2))*2)-1);
                                VM.set_global (tableName);
                        }
                }*/
                protected void NewLuaTable(){
                        VM.new_table();
                }
                protected void PushNamedPairToLuaTable(string key, int val = -2147483647){
                        if( key != null){
                                //prints("pushing values to lua table");
                                VM.push_string(key);
                                VM.push_number(val);
                                //prints("%s ", key);
                                //prints("%s \n", val.to_string());
                                VM.raw_set(-3);
                        }else{
                                key = "error";
                                string errval = "Error pushing entry to global Lua table. Key was null. Value was: ";
                                VM.push_string(key);
                                VM.push_string(errval);
                                //prints(key, errval);
                                //prints(val.to_string());
                                VM.raw_set(-3);
                        }
                }
                protected void PushStringPairToLuaTable(string key, string val = ""){
                        if( key != null){
                                //prints("pushing values to lua table");
                                VM.push_string(key);
                                VM.push_string(val);
                                //prints("%s ", key);
                                //prints("%s \n", val.to_string());
                                VM.raw_set(-3);
                        }else{
                                key = "error";
                                string errval = "Error pushing entry to global Lua table. Key was null. Value was: ";
                                VM.push_string(key);
                                VM.push_string(errval);
                                //prints(key, errval);
                                //prints(val.to_string());
                                VM.raw_set(-3);
                        }
                }
                protected void CloseLuaTable(string tableName){
                        if(tableName != null){
                                VM.set_global (tableName);
                        }else{
                                prints("something is wrong, table name cannot be null\n");
                        }
                }
                protected void PushUintToLuaTable(string tablename, string varname, uint varval){
                        NewLuaTable();
                        int tmp = (int) varval;
                        prints("Creating new Lua table: %s. ", tablename);
                        printns(" Containing field: %s. ", varname);
                        printns(" of value: %s. \n", varval.to_string());
                        PushNamedPairToLuaTable(varname,tmp);
                        CloseLuaTable(tablename);
                }
                protected void PushStringToLuaTable(string tablename, string varname, string varval){
                        NewLuaTable();
                        prints("Creating new Lua table: %s. ", tablename);
                        printns(" Containing field: %s. ", varname);
                        printns(" of value: %s. \n", varval);
                        PushStringPairToLuaTable(varname, varval);
                        CloseLuaTable(tablename);
                }
                protected void PushEntityDetailsToLuaTable(Entity requested){
                        string t = "";
                        foreach(string tag in requested.GetTags()){
                                t += " ";
                                t += tag;
                        }
                        PushStringToLuaTable("requested_data", "tags" , t);
                }
                protected void PushCoordsToLuaTable(Video.Point current, Video.Point simplecurrent){
                        NewLuaTable();
                        PushNamedPairToLuaTable("x", current.x);
                        CloseLuaTable("generator_x");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", current.y);
                        CloseLuaTable("generator_y");

                        NewLuaTable();
                        PushNamedPairToLuaTable("x", simplecurrent.x);
                        CloseLuaTable("generator_coarse_x");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", simplecurrent.y);
                        CloseLuaTable("generator_coarse_y");
                }
                protected void PushDimsToLuaTable(Video.Rect current){
                        NewLuaTable();
                        PushNamedPairToLuaTable("x", (int) current.x);
                        CloseLuaTable("room_x");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", (int) current.y);
                        CloseLuaTable("room_y");

                        NewLuaTable();
                        PushNamedPairToLuaTable("x", (int) current.x / 32);
                        CloseLuaTable("room_coarse_x");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", (int) current.y / 32);
                        CloseLuaTable("room_coarse_y");

                        NewLuaTable();
                        PushNamedPairToLuaTable("w", (int) current.w);
                        CloseLuaTable("generator_w");

                        NewLuaTable();
                        PushNamedPairToLuaTable("h", (int) current.h);
                        CloseLuaTable("generator_h");

                        NewLuaTable();
                        PushNamedPairToLuaTable("w", (int) current.w / 32);
                        CloseLuaTable("generator_coarse_w");

                        NewLuaTable();
                        PushNamedPairToLuaTable("h", (int) current.h / 32);
                        CloseLuaTable("generator_coarse_h");

                        NewLuaTable();
                        PushNamedPairToLuaTable("x", (int) ((current.x / 32) + (current.w / 32)));
                        CloseLuaTable("room_coarse_xw");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", (int) ((current.y / 32) + (current.y / 32)));
                        CloseLuaTable("room_coarse_yh");

                        NewLuaTable();
                        PushNamedPairToLuaTable("x", (int) (current.x + current.w));
                        CloseLuaTable("room_xw");

                        NewLuaTable();
                        PushNamedPairToLuaTable("y", (int) (current.y + current.y));
                        CloseLuaTable("room_yh");
                }
                protected LuaVM* GetLuaVM(){
                        return VM;
                }
        }
}
