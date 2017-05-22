using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private LuaVM globalVM = null;
                private bool does_ai = false;
                public LuaGlobal(int lll = 1, string name = "Global Lua VM: "){
                        base.new_local_attributes(lll, name);
                        globalVM = new LuaVM();
                        //globalVM.open_libs();
                        does_ai = true;
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
