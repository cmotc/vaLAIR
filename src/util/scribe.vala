using Log;

namespace LAIR{
	class Scribe : Object{
                private static int log_level = 1;
                GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_MASK;
                private int instance_log_level = log_level;
                private string Name = "global log:";
                private int class_log_level = 2;
                public Scribe(int local_log_level=2, string name="global log:", int base_log_level=-1){
                        instance_log_level = base_log_level;
                        class_log_level = local_log_level;
                        Name = name;

                }
                public Scribe.new_local_attributes(int local_log_level=2, string name="global log:", int base_log_level=-1){
                        instance_log_level = base_log_level;
                        class_log_level = local_log_level;
                        Name = name;

                }
                public static void set_global_log_level(int newll){
                        log_level = newll;
                }
                public void set_name(string name){
                        Name = name;
                }
                public string get_name(){
                        return Name;
                }
        }
}
