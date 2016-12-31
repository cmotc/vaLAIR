namespace LAIR{
	public class Scribe : Object{
                private static int LogLevel = 0;
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
                        if(ll != -1){
                                LogLevel = LogLevel;
                        }
                }
                public Scribe.LLLLL(int ll, int lll){
                        if ( ll != -1){
                                LogLevel = ll;
                        }
                        LocalLogLevel = lll;
                }
                public static void printsnl(){
                        if(LogLevel > 0){
                                stdout.printf("Void Main: %s", LogLevel.to_string());
                        }
                }
                public static void printc(string item, string item2 = ""){
                        if(LogLevel > 0){
                                printsnl();
                                stdout.printf(item, item2);
                        }
                }
                public static void setll(int newll){
                        LogLevel = newll;
                }
                public void printnl(){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(Name);
                                stdout.printf(LogLevel.to_string());
                        }
                }
                public void prints(string item, string item2 = ""){
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
                                foreach(string s in item){
                                        stdout.printf(s);
                                        r.append(s);
                                }
                        }
                        return r.copy();
                }
                public void printls(List<string> item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                foreach(string s in item){
                                        stdout.printf(s);
                                }
                        }
                }
                public void printi(int item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                stdout.printf(item.to_string());
                        }
                }
                public void printai(int[] item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void printli(List<int> item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void pprinti(string prefix, int item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                stdout.printf(prefix, item.to_string());
                        }
                }
                public void pprintai(string prefix, int[] item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                stdout.printf(prefix);
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void pprintli(string prefix, List<int> item){
                        if(LogLevel > LocalLogLevel){
                                printnl();
                                stdout.printf(prefix);
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
        }
}
