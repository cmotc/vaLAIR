using Lua;
using SDL;
namespace LAIR{
	class LuaGlobal : Scribe{
                private LuaVM global_vm = new_lua_vm();
                private bool does_ai = false;
                protected string script_path = "immobile";
                private GLib.ThreadPool<LuaThread> lua_threads;
                private List<string> last_return = new List<string>();
                protected class LuaThread{
                        private unowned LuaVM vm_pointer = null;
                        protected string last_function = "";
                        private bool run = false;
                        public LuaThread(LuaVM which_vm, out List<string> store_value, string which_function=""){
                                vm_pointer=which_vm;
                                last_function=which_function;
                                run=false;
                                do_string(last_function);
                                store_value = get_lua_last_return();
                        }
                        public void do_string(string function = ""){
                                if ( vm_pointer != null ){
                                        message("vm_pointer existed, so thread was created successfully.");
                                        if ( function != "" ){
                                                message("function was not an empty string");
                                                if (function != last_function){
                                                        message("function was not equal to the previous function");
                                                        vm_pointer.do_string(function);
                                                }else{
                                                        if ( run == false ){
                                                                message("function had not previously been run");
                                                                vm_pointer.do_string(last_function);
                                                                run=true;
                                                        }
                                                }
                                        }
                                }
                                message("function was %s", function );
                        }
                        public List<string> get_lua_last_return(){
                                string tmp = "";
                                List<string> tr = null;
                                if(vm_pointer.get_top() > 0){
                                        tr = new List<string>();
                                        if(vm_pointer.is_number(-1)){
                                                double number = vm_pointer.to_number(-1);
                                                tmp += number.to_string();
                                                vm_pointer.pop(1);
                                        }else if(vm_pointer.is_string(-1)){
                                                string word = vm_pointer.to_string(-1);
                                                tmp += word;
                                                vm_pointer.pop(1);
                                        }else if(vm_pointer.is_boolean(-1)){
                                                bool word = vm_pointer.to_boolean(-1);
                                                tmp += word.to_string();
                                                vm_pointer.pop(1);
                                        }
                                }
                                string[] tl = tmp.split(" ", 0);
                                for(int i = 0; i < tl.length; i++){
                                        if(tl[i] != null){
                                                tr.append(tl[i]);
                                        }
                                }
                                foreach(string f in tr){
                                        message("Return value members %s", f);
                                }
                                return tr;
                        }
                }
                public LuaGlobal(string lua_ai_path, int lua_log_level = 1){
                        base(lua_log_level);
                        message(lua_ai_path);
                        global_vm = new_lua_vm();
                        script_path = lua_ai_path;
                        does_it_ai(script_path);
                        lua_do_file(script_path);
                        try {
                                lua_threads = new ThreadPool<LuaThread>.with_owned_data ((thread) => {
                                        thread.do_string();
                                }, 1, false);
                        } catch (ThreadError e) {
                                message("ThreadError: %s\n", e.message);
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
                protected void lua_do_file(string file_path = script_path){
                        if(file_path != "immobile"){
                                global_vm.do_file(file_path);
                        }else{
                                message("File path not set, no do_file action taken %s", file_path);
                        }

                }
                protected void lua_do_function(string function){
                        if(function != ""){
                                if(does_it_ai(script_path)){
                                        string tmp = "return " + function;
                                        try {
                                                lua_threads.add(new LuaThread(vm_thread(), out last_return, tmp));
                                        }catch (ThreadError e) {
                                                message("ThreadError: %s\n", e.message);
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
                protected List<string> get_lua_last_return(){
                        return last_return.copy();
                }
                ///*
                public unowned LuaVM vm_copy(){
                        return global_vm;
                }
                //*/
                public unowned LuaVM vm_thread(){
                        return global_vm.new_thread();
                }
        }
}
