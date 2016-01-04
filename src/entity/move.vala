using Gee;
using SDL;
namespace LAIR{
	class Move : Inventory{
		public Move(Video.Surface TheSurface, string FontPath, string SoundPath){
			base(TheSurface, FontPath, SoundPath);
		}
	}
}