using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private LuaVM global_vm = new_lua_vm();
                private bool does_ai = false;
                protected string script_path = "immobile";
                public LuaGlobal(string lua_ai_path = "immobile", int lua_log_level = 1){
                        base(lua_log_level);
                        message(lua_ai_path);
                        global_vm = new_lua_vm();
                        script_path = lua_ai_path;
                        does_it_ai(script_path);
                        lua_do_file(script_path);
                        if(lua_ai_path != "immobile"){
                                does_ai = true;
                        }else{
                                does_ai = false;
                        }
                }
                private static LuaVM new_lua_vm(){
                        LuaVM tmp = new LuaVM();
                        tmp.open_libs();
                        return tmp;
                }
                protected void lua_do_file(string file_path = "immobile"){
                        if(file_path != "immobile"){
                                global_vm.do_file(file_path);
                        }
                }
                protected void lua_register(string name, CallbackFunc f){
                        global_vm.register(name, f);
                }
                protected bool does_it_ai(string file_path = script_path){
                        script_path = file_path;
                        if(script_path == "immobile"){
                                does_ai = false;
                        }
                        return does_ai;
                }
                public unowned LuaVM vm_copy(){
                        return global_vm;
                }
        }
}
