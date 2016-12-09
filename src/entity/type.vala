namespace LAIR{
	public class Type : Object{
		private string TYPES[3]; 
		private int TYPE = 0;
		private int BLOCKED = 0;
		public Type(){
			TYPES[0] = "TILE";
			TYPES[1] = "PLAYER";
			TYPES[2] = "MOBILE";
                        SetType(0);
		}
                public Type.Parameter(int type){
                        TYPES[0] = "TILE";
			TYPES[1] = "PLAYER";
			TYPES[2] = "MOBILE";
                        SetType(type);
                }
		public int SetType(int NewType){
			int temp = 0;
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