namespace LAIR{
	class Scribe : Object{
                private static int LogLevel;// = 1;
                private string Name = "global log: ";
                private int LocalLogLevel = 6;
                public Scribe.LL(int ll){
                        LogLevel = 1;
                        LocalLogLevel = 2;
                }
                public Scribe.LLL(int lll, string name, int ll=-1){
                        LocalLogLevel = lll;
                        Name = name;
                        Name += " ";
                        int llcache = LogLevel;
                        if(ll != -1){
                                LogLevel = llcache;
                        }
                }
                public Scribe.LLLLL(int ll, int lll){
                        if ( ll != -1){
                                LogLevel = ll;
                        }
                        LocalLogLevel = lll;
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
        }
}
