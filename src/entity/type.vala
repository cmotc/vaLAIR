namespace LAIR{
	public class Type : Scribe{
		private bool player = false;
                private int b = 0;
                private List<string> tags = new List<string>();
                public Type(){
                        player = false;
                        b = 0;
                        tags = new List<string>();
                        SetType("default");
                }
                public Type.Blocked(){
                        SetType("blocked");
		}
                public Type.Player(string name){
                        base.LLL(1, name);
                        SetType("blocked");
                        SetType("player");
		}
                public Type.Parameter(string type){
                        SetType(type);
                        player = CheckType("player");
                        if (player) {
                                SetType("blocked");
                        }
                }
                public Type.ParameterList(List<string> types){
                        foreach(string type in types.copy()){
                                SetType(type);
                        }
                        player = CheckType("player");
                        if (player) {
                                SetType("blocked");
                        }
                }
                public Type.ParameterBlocked(string type){
                        SetType("blocked");
                        SetType(type);
                        player = CheckType("player");
                }
                public Type.ParameterListBlocked(List<string> types){
                        SetType("blocked");
                        foreach(string type in types.copy()){
                                SetType(type);
                        }
                        player = CheckType("player");
                }
		public bool SetType(string NewType){
                        bool t = true;
                        foreach(string i in tags.copy()){
                                if ( i == NewType ){
                                        t = false;
                                }
                        }
                        if (t){
                                tags.append(NewType);
                                prints("   Added tag: %s \n", NewType);
                                b = 0;
                        }
                        if ( NewType == "blocked" ){
                                b = 1;
                        }
                        if ( NewType == "player" ){
                                player = true;
                        }
                        return t;
		}
                public bool CheckType(string Type){
                        bool r = false;
                        foreach(string i in tags.copy()){
                                if ( i == Type ){
                                        r = true;
                                }
                        }
                        return r;
                }
		public bool GetBlock(){
                        bool r = false;
                        if ( b == 0 ){
                                r = CheckType("blocked");
                                if ( r == true){
                                        b = 1;
                                }
                        }else if ( b == 1 ){
                                r = true;
                        }

			return r;
		}
		public bool IsPlayer(){
			return player;
		}
	}
}
