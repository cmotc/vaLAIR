using Lua;

namespace LAIR{
	class LuaConf : Object{
                private LuaVM VM = new LuaVM ();
                protected List<string> lua_last_return = new List<string>();
                private string ScriptPath = "";
                public LuaConf(){
                        lua_last_return = new List<string>();
                        VM = new LuaVM();
                        VM.open_libs();
                }
                protected List<string> GetLuaLastReturn(){
                        //size_t sz = VM.strlen(-1);
                        size_t sz;
                        var word = VM.to_lstring(-1, out sz);
                        stdout.printf(word);
                        VM.pop (1);
                        return lua_last_return.copy();
                }
                protected void LuaRegister(string name, CallbackFunc f){
                        VM.register(name, f);
                }
                protected void LoadLuaFile(string path){
                        VM.do_file(path);
                        ScriptPath = path;
                }
                protected void LuaDoFunction(string function){
                        VM.do_string(function);
                }
                protected LuaVM* GetLuaVM(){
                        return VM;
                }
        }
}
