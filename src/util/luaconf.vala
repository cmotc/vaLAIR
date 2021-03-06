using Lua;
using SDL;
namespace LAIR{
	class LuaConf : LuaGlobal{
        public LuaConf(string lua_ai_path){
            base(lua_ai_path);
        }
        private void lua_new_table(){
            if(does_it_ai(script_path)){
                if(script_path != "immobile"){
                    vm_copy().new_table();
                }
            }
        }
        private void lua_push_named_number(string key, int val = -2147483647){
            if(val != -2147483647){
                if(does_it_ai(script_path)){
                    if( key != null){
                        vm_copy().push_string(key);
                        vm_copy().push_number(val);
                        vm_copy().raw_set(-3);
                    }else{
                        key = "error";
                        string errval = "Error pushing entry to global Lua table. Key was null. Value was: " + val.to_string();
                        message(errval);
                        vm_copy().push_string(key);
                        vm_copy().push_string(errval);
                        vm_copy().raw_set(-3);
                    }
                }
            }
        }
        private void lua_push_named_strings(List<string> vals){
            if(does_it_ai(script_path)){
                int key = 0;
                foreach(string val in vals){
                    if( key >= 0 ){
                        vm_copy().push_string(key.to_string());
                        vm_copy().push_string(val);
                        vm_copy().raw_set(-3);
                    }else{
                        vm_copy().push_string(key.to_string());
                        string errval = "Error pushing entry to global Lua table. Key was null.";
                        message(errval);
                    }
                    key++;
                }
            }
        }
        private void lua_close_table(string tableName){
            if(does_it_ai(script_path)){
                if(tableName != null){
                    vm_copy().set_global (tableName);
                }else{
                    message("something is wrong, table name cannot be null");
                }
            }
        }
        protected void lua_push_uint_to_table(string tablename = "none", string varname = "none", int varval = -2147483647){
            if(tablename != "none"){
                if(tablename != "none"){
                    if(does_it_ai(script_path)){
                        lua_new_table();
                        lua_push_named_number(varname, varval);
                        lua_close_table(tablename);
                    }
                }
            }
        }
        protected void lua_push_coords(AutoPoint current, AutoPoint simplecurrent){
            if(does_it_ai(script_path)){
                lua_push_uint_to_table("generator_x", "x", simplecurrent.x());
                lua_push_uint_to_table("generator_y", "y", simplecurrent.y());
                lua_push_uint_to_table("generator_coarse_x", "x", current.x());
                lua_push_uint_to_table("generator_coarse_y", "y", current.y());
            }
        }
        protected void lua_push_generator_coords(AutoPoint pixel_coords, AutoPoint coarse_coords){
            message("Coordinates pushed to lua table.");
            lua_push_coords(pixel_coords, coarse_coords);
        }
        protected void lua_push_string_to_table(string tablename, string val = "none"){
            if(val != "none"){
                if(does_it_ai(script_path)){
                    lua_new_table();
                    vm_copy().push_string(tablename);
                    vm_copy().push_string(val);
                    vm_copy().raw_set(-3);
                    lua_close_table(tablename);
                }
            }
        }
        protected void lua_push_strings_to_table(string tablename = "none", List<string>? varvals = null){
            if(tablename != "none"){
                if(varvals != null){
                    if(does_it_ai(script_path)){
                        lua_new_table();
                        lua_push_named_strings(varvals);
                        lua_close_table(tablename);
                    }
                }
            }
        }
        protected void lua_push_dimensions_generator_phase(AutoRect current_room, AutoRect current_floor){
            if(does_it_ai(script_path)){
                /**///
                lua_push_uint_to_table("floor_w", "w", (int)current_floor.w() );
                lua_push_uint_to_table("floor_width", "w", (int)current_floor.w() );
                /**///
                lua_push_uint_to_table("floor_h", "h", (int)current_floor.h() );
                lua_push_uint_to_table("floor_height", "h", (int)current_floor.h() );
                /**///
                lua_push_uint_to_table("floor_coarse_w", "w", (int)(current_floor.w() / 32) );
                lua_push_uint_to_table("floor_coarse_width", "w", (int)(current_floor.w() / 32) );
                /**///
                lua_push_uint_to_table("floor_coarse_h", "h", (int)(current_floor.h() / 32) );
                lua_push_uint_to_table("floor_coarse_height", "h", (int)(current_floor.h() / 32) );
                /**///
                lua_push_uint_to_table("room_x","x",current_room.x());
                lua_push_uint_to_table("room_corner_x","x",current_room.x());
                /**///
                lua_push_uint_to_table("room_y","y",current_room.y());
                lua_push_uint_to_table("room_corner_y","y",current_room.y());
                /**///
                lua_push_uint_to_table("room_coarse_x","x",current_room.x()/32);
                lua_push_uint_to_table("room_corner_coarse_x","x",current_room.x()/32);
                /**///
                lua_push_uint_to_table("room_coarse_y","y",current_room.y()/32);
                lua_push_uint_to_table("room_corner_coarse_y","y",current_room.y()/32);
                /**///
                lua_push_uint_to_table("generator_w","w",(int)current_room.w());
                lua_push_uint_to_table("current_room_width","w",(int)current_room.w());
                /**///
                lua_push_uint_to_table("generator_h","h",(int)current_room.h());
                lua_push_uint_to_table("current_room_height","h",(int)current_room.h());
                /**///
                lua_push_uint_to_table("generator_coarse_w","w",(int)current_room.w()/32);
                lua_push_uint_to_table("current_room_coarse_width","w",(int)current_room.w()/32);
                /**///
                lua_push_uint_to_table("generator_coarse_h","h",(int)current_room.h()/32);
                lua_push_uint_to_table("current_room_coarse_height","h",(int)current_room.h()/32);
                /**///
                lua_push_uint_to_table("room_xw","x",current_room.x() + (int)current_room.w());
                lua_push_uint_to_table("room_faredge_x","x",current_room.x() + (int)current_room.w());
                /**///
                lua_push_uint_to_table("room_yh","y",current_room.y() + (int)current_room.h());
                lua_push_uint_to_table("room_faredge_y","y",current_room.y() + (int)current_room.h());
                /**///
                lua_push_uint_to_table("room_coarse_xw","x",((current_room.x() / 32) + ((int)current_room.w() / 32)));
                lua_push_uint_to_table("room_faredge_coarse_x","x",((current_room.x() / 32) + ((int)current_room.w() / 32)));
                /**///
                lua_push_uint_to_table("room_coarse_yh","y",((current_room.y() / 32) + ((int)current_room.h() / 32)));
                lua_push_uint_to_table("room_faredge_coarse_y","y",((current_room.y() / 32) + ((int)current_room.h() / 32)));
            }
        }
    }
}
