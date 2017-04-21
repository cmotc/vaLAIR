namespace LAIR{
	class Scribe : Object{
                private static int LogLevel = 1;
                private int InstanceLogLevel = LogLevel;
                private string Name = "";
                private int LocalLogLevel = 2;
                public Scribe.new_local_attributes(int lll=2, string name="global log:", int ll=-1){
                        if(ll != -1){
                                LogLevel=ll;
                        }
                        InstanceLogLevel = LogLevel;
                        LocalLogLevel = lll;
                        for(int s = 0; s < lll; s++){
                                Name += " ";
                        }
                        Name = name;

                }
                public static void print_static(string item, string item2 = ""){
                        if(LogLevel > 0){
                                stdout.printf("Void Main: %s", LogLevel.to_string());
                                stdout.printf(item, item2, " ");
                        }
                }
                public static void set_global_loglevel(int newll){
                        LogLevel = newll;
                }
                private void print_name(){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(Name);
                        }
                }
                public void print_withname(string item="", string item2 = ""){
                        if(LogLevel > LocalLogLevel){
                                print_name();
                                stdout.printf(item, item2, " ");
                        }
                }
                public void print_noname(string item="", string item2 = ""){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(item, item2, " ");
                        }
                }
                public void print_force(string item, string item2 = ""){
                        stdout.printf(item, item2, " ");
                }
                public void set_name(string name){
                        Name = name;
                }
                public string get_name(){
                        return Name;
                }
        }
}
