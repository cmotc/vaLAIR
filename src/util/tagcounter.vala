
namespace LAIR{
        class TagCounter : Scribe{
                private uint Count = 1;
                public TagCounter(string name){
                        base.LLL(3 ,"Tag Counter:");
                        Count = 1;
                }
                public void increment_count(){
                        Count++;
                }
                public uint get_count(){
                        print_noname(" %s .", Count.to_string());
                        return Count;
                }
                public bool check_name(string tocheck){
                        bool r = false;
                        if(tocheck == get_name()){
                                r = true;
                        }
                        return r;
                }
        }
}
