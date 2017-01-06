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
                public static void printc(string item, string item2 = ""){
                        if(LogLevel > 0){
                                stdout.printf("Void Main: %s", LogLevel.to_string());
                                stdout.printf(item, item2);
                        }
                }
                public static void setll(int newll){
                        LogLevel = newll;
                }
                public void printnl(){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(Name);
                                stdout.printf(" %s", LogLevel.to_string());
                        }
                }
                public void prints(string item="", string item2 = ""){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                stdout.printf(item, item2);
                        }
                }
                public void printncs(string item, string item2 = ""){
                        stdout.printf(item, item2);
                }
                public List<string> printas(string[] item){
                        List<string> r = new List<string>();
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                //foreach(string s in item){
                                for(int i = 0; i < item.length - 1; i++){
                                        stdout.printf(" %s ", item[i].to_string());
                                        r.append(item[i].to_string());
                                }
                        }
                        return r.copy();
                }
        }
}
