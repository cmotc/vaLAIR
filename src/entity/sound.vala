using SDL;
using SDLMixer;

namespace LAIR{
	class Voice : Text{
        private unowned Music Footsteps;
        private unowned Music Bonk;
        private unowned Music Ambient;
        private void set_sounds(List<Music*> music){
            if(music.length() > 0){
                if ( music.nth_data(0) != null ){
                    Footsteps = music.nth_data(0);
                }
            }
            if(music.length() > 1){
                if ( music.nth_data(1) != null ){
                    Bonk = music.nth_data(1);
                }
            }
            if(music.length() > 2){
                if ( music.nth_data(2) != null ){
                    Ambient = music.nth_data(2);
                }
            }

        }
        public Voice.UnBlocked(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer renderer, string aiScript = "", List<string> tags = null){
            base.UnBlocked(corner, Surfaces, font, Labels, renderer, aiScript, tags);
            if (music != null){
                set_sounds(music);
            }
        }
        public Voice.IsBlocked(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer renderer, string aiScript = "", List<string> tags = null){
            base.IsBlocked(corner, Surfaces, font, Labels, renderer, aiScript, tags);
            if (music != null){
                set_sounds(music);
            }
        }
	}
}
