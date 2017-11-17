using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private static LuaVM global_vm = new_lua_vm();
                private bool does_ai = false;
                protected string script_path = "immobile";
                private GLib.ThreadPool<LuaThread> lua_threads;
                protected class LuaThread{
                        private unowned LuaVM vm_pointer = null;
                        protected string last_function = "";
                        private bool run = false;
                        public LuaThread(LuaVM which_vm=null, string which_function=""){
                                vm_pointer=which_vm;
                                last_function=which_function;
                                run=false;
                        }
                        public void do_string(string function = ""){
                                if ( vm_pointer != null ){
                                        message("vm_pointer existed, so thread was created successfully.\n");
                                        if ( function != "" ){
                                                message("function was not an empty string\n");
                                                if (function != last_function){
                                                        message("function was not equal to the previous function\n");
                                                        vm_pointer.do_string(function);
                                                        GLib.Thread.usleep (4500);
                                                }else{
                                                        if ( run == false ){
                                                                message("function had not previously been run\n");
                                                                vm_pointer.do_string(last_function);
                                                                run=true;
                                                                GLib.Thread->usleep (4500);
                                                        }
                                                }
                                        }
                                }
                                message("function was %s\n", function );
                        }
                }
                public LuaGlobal(string lua_ai_path = "immobile", int lua_log_level = 1){
                        base(lua_log_level);
                        message(lua_ai_path);
                        global_vm = new_lua_vm();
                        script_path = lua_ai_path;
                        does_it_ai(script_path);
                        lua_do_file(script_path);
                        try {
                                lua_threads = new ThreadPool<LuaThread>.with_owned_data ((thread) => {
                                        thread.do_string();
                                }, 3, false);
                        } catch (ThreadError e) {
                                stdout.printf ("ThreadError: %s\n", e.message);
                        }
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
                protected void lua_do_string_thread(LuaThread thread, string std){
                        thread.do_string(std);
                }
                protected void lua_do_function(string function=""){
                        if(function != ""){
                                if(does_it_ai(script_path)){
                                        string tmp = "return " + function;
                                        try {
                                                lua_threads.add(new LuaThread(vm_thread(), tmp));
                                        }catch (ThreadError e) {
                                                stdout.printf ("ThreadError: %s\n", e.message);
                                        }
                                }
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
                public unowned LuaVM vm_thread(){
                        return global_vm.new_thread();
                }
        }
}
