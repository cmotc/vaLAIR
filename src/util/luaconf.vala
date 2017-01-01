using Lua;

namespace LAIR{
	public class LuaConf : Scribe{
                private LuaVM VM;
                private string ScriptPath;
                public LuaConf(string path, int lll, string name){
                        base.LLL(lll, name);
                        VM = new LuaVM();
                        VM.open_libs();
                        ScriptPath = path;
                        prints("Loading a dungeon generator script: %s\n", ScriptPath);
                        VM.do_file(ScriptPath);
                        printas(GetLuaLastReturn());
                        prints("\n");
                }
                private void LuaDoFile(string file){
                        VM.do_file(file);
                }
                protected string[] GetLuaLastReturn(){
                        string tmp = "";
                        if(VM.is_number(-1)){
                                double number = VM.to_number(-1);
                                tmp += number.to_string();
                        }else if(VM.is_string(-1)){
                                string word = VM.to_string(-1);
                                tmp += word;
                        }
                        string[] tl = tmp.split(" ", -1);
                        return tl;
                }
                protected void LuaRegister(string name, CallbackFunc f){
                        VM.register(name, f);
                }
                protected void LuaDoFunction(string function){
                        LuaDoFile(ScriptPath);
                        string tmp = "return ";
                        tmp += function;
                        VM.do_string(tmp);
                }
                //This creates a new global Lua table containing a pair of
                //parameters, such as X, Y or Width, Height. As such it's kind
                //of specific and might end up getting superceded, but it's at
                //a helpful shortfut for now.
                //I think maybe a 1 dimentionsional array with one member might
                //be the same as a single parameter.
                protected void PushNamedPairToLuaTable(string tableName, string[] membernames, int[] members){
                        int i = 0;
                        if(membernames.length == members.length){
                                VM.new_table ();
                                foreach(int member in members) {
                                        prints("index: %s", membernames[i]);
                                        prints("member: %s \n", member.to_string());
                                        VM.push_string(membernames[i]);
                                        VM.push_number (member);

                                        i++;
                                }
                                VM.raw_set (((i-(i*2))*2)-1);
                                VM.set_global (tableName);
                        }
                }
                protected LuaVM* GetLuaVM(){
                        return VM;
                }
        }
}
