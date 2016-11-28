using SDL;
namespace LAIR{
	class Stats : Net{
		private int Strength = 10;
		private int Agility = 10;
		private int Toughness = 10;
		private int Intelligence = 10;
		private int Special = 10;
		private int speed = 0;
		private int exert = 0;
		private int dodge = 0;
		private int aim = 0;
		private int will = 0;
		private int resist = 0;
		private int magic = 0;
		private int tech = 0;
		public int Speed(){
			int tmp = (Strength + Agility) / 4;
			return tmp + speed;
		}
		public int Exert(){
			int tmp = (Strength + Toughness) / 4;
			return tmp + exert;
		}
		public int Dodge(){
			int tmp = (Agility + Toughness) / 4;
			return tmp + dodge;
		}
		public int Aim(){
			int tmp = (Agility + Intelligence) / 4;
			return tmp + aim;
		}
		public int Will(){
			int tmp = (Toughness + Intelligence) / 4;
			return tmp + will;
		}
		public int Resist(){
			int tmp = (Toughness + Special) / 4;
			return tmp + resist;
		}
		public int Magic(){
			int tmp = (Intelligence + Special) / 4;
			return tmp + magic;
		}
		public int Tech(){
			int tmp = (Intelligence + Agility) / 4;
			return tmp + tech;
		}
	}
}