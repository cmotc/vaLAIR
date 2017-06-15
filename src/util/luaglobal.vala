using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private static LuaVM global_vm = new_lua_vm();
                private LuaVM ai_vm = null;
                private bool does_ai = false;
                public LuaGlobal(string lua_ai_path, int lua_log_level = 1){
                        base(lua_log_level);
                        global_vm = new_lua_vm();
                        if(lua_ai_path != "immobile"){
                                does_ai = true;
                                ai_vm = new_lua_vm();
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
                public unowned LuaVM ai_vm_copy(){
                        return ai_vm;
                }
                public unowned LuaVM vm_copy(){
                        if(does_ai){
                                if (ai_vm != null){
                                        return ai_vm_copy();
                                }else{
                                        return global_vm_copy();
                                }
                        }else{
                                        return global_vm_copy();
                        }
                }
                protected bool does_it_ai(string script_path = "immobile"){
                        if(script_path == "immobile"){
                                does_ai = false;
                        }
                        return does_ai;
                }
        }
}
