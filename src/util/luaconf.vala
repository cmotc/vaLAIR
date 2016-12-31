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
                        //var test = GetLuaLastReturn();
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
                protected LuaVM* GetLuaVM(){
                        return VM;
                }
        }
}
