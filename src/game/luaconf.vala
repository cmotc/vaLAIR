using Lua;

namespace LAIR{
	class LuaConf : Object{
                private static LuaVM vm = new LuaVM ();
                protected static List<string> lua_last_return = new List<string>();
                private static string ScriptPath = "";
                protected static List<string> GetLuaLastReturn(){
                        var sum = vm.to_number (-1);

                        vm.pop (1);
                        return lua_last_return.copy();
                }
                public LuaConf(){
                        vm = new LuaVM();
                        vm.open_libs();
                }
                protected static void LuaRegister(string name, CallbackFunc f){
                        vm.register(name, f);
                }
                protected static void LoadLuaFile(string path){
                        vm.do_file(path);
                        ScriptPath = path;
                }
                protected static void LuaDoFunction(string function){
                        vm.do_string(function);
                }

        }
}
