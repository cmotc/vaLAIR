
namespace LAIR{
        class TagCounter : Scribe{
                private uint Count = 1;
                public TagCounter(string new_name){
                        base(3);
                        Count = 1;
                }
                public void increment_count(){
                        Count++;
                }
                public uint get_count(){
                        debug(" %s .", Count.to_string());
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
