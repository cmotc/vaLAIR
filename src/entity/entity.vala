using SDL;
namespace LAIR{
	class Entity : Move{
		public Entity(Graphics.Surface TheSurface, string FontPath, string SoundPath){
			base(TheSurface, FontPath, SoundPath);
		}		
	}
}