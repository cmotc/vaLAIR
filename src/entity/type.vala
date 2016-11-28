namespace LAIR{
	public class Type : Object{
		string TYPES[3]; 
		int TYPE = 0;
		int BLOCKED = 0;
		public Type(){
			TYPES[0] = "TILE";
			TYPES[1] = "PLAYER";
			TYPES[2] = "MOBILE";
		}
		public int SetType(int NewType){
			int temp = -1;
			if(NewType > 2){
				temp = NewType;
			}else if(NewType<0){
				temp = NewType;
			}else{
				TYPE = NewType;
				temp = NewType;
			}
			return temp;
		}
		public string GetType(){
			return TYPES[TYPE];
		}
		public int Block(){
			BLOCKED = 1;
			return BLOCKED;
		}
		public int UnBlock(){
			BLOCKED = 0;
			return BLOCKED;
		}
		public int GetBlock(){
			return BLOCKED;
		}
		public bool IsPlayer(){
			bool tmp = false;
			if (TYPE == 1){
				tmp = true;
			}
			return tmp;
		}
	}
}