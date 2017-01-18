
namespace LAIR{
        class TagCounter : Scribe{
                private string Name;
                private uint Count = 1;
                public TagCounter(string name){
                        base.LLL(3 ,"Tag Counter:");
                        Count = 1;
                        Name = name;
                }
                public void increment_count(){
                        Count++;
                }
                public uint get_count(){
                        print_noname(" %s .", Count.to_string());
                        return Count;
                }
                public string get_name(){
                        print_withname(Name);
                        return Name;
                }
                public bool check_name(string tocheck){
                        bool r = false;
                        if(tocheck == Name){
                                r = true;
                        }
                        return r;
                }
        }
}
