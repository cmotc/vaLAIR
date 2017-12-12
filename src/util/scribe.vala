using Log;

namespace LAIR{
	class Scribe {
        private static GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_WARNING;
        private string name = "global log:";
        public Scribe(int local_log_level=2){
            GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_WARNING;
            GLib.Log.set_handler(null,glib_level,GLib.Log.default_handler);
        }
        public static void set_log_level(int swit_ch){
            GLib.LogLevelFlags glib_level       = GLib.LogLevelFlags.LEVEL_WARNING;
            GLib.Log.set_handler(null,glib_level,GLib.Log.default_handler);
        }
        public void set_name(string new_name){
            name = new_name;
        }
        public string get_name(){
            return name;
        }
    }
}
