using Log;

namespace LAIR{
	class Scribe {
                private static GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_ERROR;
                private string name = "global log:";
                public Scribe(int local_log_level=2, string new_name="global log:"){
                        GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_MASK;
                        GLib.Log.set_handler("",glib_level,GLib.Log.default_handler);
                        name = new_name;
                }
                public Scribe.new_local_attributes(int local_log_level=2, string new_name="global log:"){
                        GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_MASK;
                        GLib.Log.set_handler("",glib_level,GLib.Log.default_handler);
                        name = new_name;
                }
                public static void set_log_level(int swit_ch){
                        GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_MASK;
                }
                public void set_name(string new_name){
                        name = new_name;
                }
                public string get_name(){
                        return name;
                }
        }
}
