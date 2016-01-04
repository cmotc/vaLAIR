using Gee;
using SDL;
namespace LAIR{
	class Inventory : Stats{
//		ArrayList<Entity> mInventory = new ArrayList<Entity>();
		public Inventory(Video.Surface TheSurface, string FontPath, string SoundPath){
			base(TheSurface, FontPath, SoundPath);			
		}
	}
}