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
                public Voice(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer ){
                        base(corner, Surfaces, font, Labels, renderer);
                        set_sounds(music);
                }
                public Voice.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.Parameter(corner, Surfaces, font, Labels, renderer, tags);
                        set_sounds(music);
                }
                public Voice.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.Blocked(corner, Surfaces, font, Labels, renderer, tags);
                        set_sounds(music);
                }
                public Voice.Player(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.Player(corner, Surfaces, font, Labels, renderer, tags);
                        set_sounds(music);
                }
	}
}
