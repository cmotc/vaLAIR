using Lua;

namespace LAIR{
	class LuaConf : Object{
                private static LuaVM vm = new LuaVM ();
                protected static List<string> lua_last_return = new List<string>();
                protected static List<string> GetLuaLastReturn(){
                        var sum = vm.to_number (-1);
                        List<string> r = new List<string>();
                        return r;
                }
                public LuaConf(){
                        vm.open_libs();
                }
                protected void LuaRegister(string name, CallbackFunc f){
                        vm.register(name, f);
                }
                protected void LoadLuaFile(string path){
                        vm.do_file(path);
                }
        }
}
