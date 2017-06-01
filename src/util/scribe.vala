using Log;

namespace LAIR{
	class Scribe : Object {
                GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_MASK;
                private static int instance_log_level = 2;
                private string name = "global log:";
                public Scribe(int local_log_level=2, string new_name="global log:"){
                        instance_log_level = 2;
                        instance_log_level = local_log_level;
                        name = name;

                }
                public Scribe.new_local_attributes(int local_log_level=2, string new_name="global log:"){
                        instance_log_level = 2;
                        instance_log_level = local_log_level;
                        name = new_name;

                }
                public static void set_log_level(int new_log_level){
                        instance_log_level = new_log_level;
                }
                public void set_name(string new_name){
                        name = new_name;
                }
                public string get_name(){
                        return name;
                }
        }
}
