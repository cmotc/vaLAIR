namespace LAIR{
	public class Scribe : Object{
                private static int LogLevel;
                private int LocalLogLevel = 2;
                public Scribe.LL(int ll){
                        LogLevel = 1;
                        LocalLogLevel = 2;
                }
                public Scribe.LLL(int lll){
                        LocalLogLevel = lll;
                }
                public Scribe.LLLLL(int ll, int lll){
                        if ( ll != -1){
                                LogLevel = ll;
                        }
                        LocalLogLevel = lll;
                }
                public static void printc(string item, string item2 = ""){
                        stdout.printf(item, item2);
                }
                public void prints(string item, string item2 = ""){
                        stdout.printf(item, item2);
                }
                public List<string> printas(string[] item){
                        List<string> r = new List<string>();
                        if(LogLevel > LocalLogLevel){
                                foreach(string s in item){
                                        stdout.printf(s);
                                        r.append(s);
                                }
                        }
                        return r.copy();
                }
                public void printls(List<string> item){
                        if(LogLevel > LocalLogLevel){
                                foreach(string s in item){
                                        stdout.printf(s);
                                }
                        }
                }
                public void printi(int item){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(item.to_string());
                        }
                }
                public void printai(int[] item){
                        if(LogLevel > LocalLogLevel){
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void printli(List<int> item){
                        if(LogLevel > LocalLogLevel){
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void pprinti(string prefix, int item){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(prefix, item.to_string());
                        }
                }
                public void pprintai(string prefix, int[] item){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(prefix);
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
                public void pprintli(string prefix, List<int> item){
                        if(LogLevel > LocalLogLevel){
                                stdout.printf(prefix);
                                foreach(int s in item){
                                        stdout.printf(s.to_string());
                                }
                        }
                }
        }
}
