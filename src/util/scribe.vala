namespace LAIR{
	class Scribe : Object{
                private static int log_level = 1;
                private int instance_log_level = log_level;
                private string Name = "";
                private int class_log_level = 2;
                public Scribe.new_local_attributes(int local_log_level=2, string name="global log:", int base_log_level=-1){
                        instance_log_level=base_log_level;
                        class_log_level = local_log_level;
                        Name = name;

                }
                public static void print_static(string item, string item2 = ""){
                        if(log_level > 0){
                                stdout.printf("Void Main: %s", log_level.to_string());
                                stdout.printf(item, item2, " ");
                        }
                }
                public static void set_global_log_level(int newll){
                        log_level = newll;
                }
                private void print_name(){
                        if(log_level > class_log_level){
                                stdout.printf(Name);
                        }
                }
                public void print_withname(string item="", string item2 = ""){
                        if(log_level > class_log_level){
                                print_name();
                                stdout.printf(item, item2, " ");
                        }
                }
                public void print_noname(string item="", string item2 = ""){
                        if(log_level > class_log_level){
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
