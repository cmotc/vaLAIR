using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private LuaVM globalVM = null;
                private bool does_ai = false;
                public LuaGlobal(string lua_ai_path,int lua_log_level = 1, string name = "Global Lua VM: "){
                        base.new_local_attributes(lua_log_level, name);
                        globalVM = new LuaVM();
                        globalVM.open_libs();
                        if(lua_ai_path != "immobile"){
                                does_ai = true;
                        }else{does_ai = false;}
                }
                public LuaVM* global_vm_pointer(){
                        return globalVM;
                }
                public unowned LuaVM global_vm_copy(){
                        return globalVM;
                }
                protected bool does_it_ai(){
                        return does_ai;
                }
        }
}
