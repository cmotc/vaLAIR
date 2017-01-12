
namespace LAIR{
        class TagCounter : Scribe{
                private string Name;
                private uint Count = 1;
                public TagCounter(string name){
                        base.LLL(3 ,"Tag Counter:");
                        Count = 1;
                        Name = name;
                }
                public void Inc(){
                        Count++;
                }
                public uint GetCount(){
                        printns(" %s .", Count.to_string());
                        return Count;
                }
                public string GetName(){
                        prints(Name);
                        return Name;
                }
                public bool CheckName(string tocheck){
                        bool r = false;
                        if(tocheck == Name){
                                r = true;
                        }
                        return r;
                }
        }
}
