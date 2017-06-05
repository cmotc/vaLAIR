using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private LuaVM global_vm = null;//new_lua_vm();
                private bool does_ai = false;
                public LuaGlobal(string lua_ai_path,int lua_log_level = 1, string name = "Global Lua VM: "){
                        base.new_local_attributes(lua_log_level, name);
                        if(lua_ai_path != "immobile"){
                                does_ai = true;
                                global_vm = new_lua_vm();
                        }else{does_ai = false;}
                }
                private static LuaVM new_lua_vm(){
                        LuaVM tmp = new LuaVM();
                        tmp.open_libs();
                        return tmp;
                }
                public unowned LuaVM global_vm_copy(){
                        return global_vm;
                }
                protected bool does_it_ai(string script_path){
                        if(script_path == "immobile"){
                                does_ai = false;
                        }
                        return does_ai;
                }
        }
}
