using SDL;
using SDLMixer;

namespace LAIR{
	class Sound : Text{
		public Sound(Graphics.Surface TheSurface, string FontPath, string SoundPath){
			base(TheSurface, FontPath);
		}
	}
}