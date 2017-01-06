using SDL;
using SDLMixer;

namespace LAIR{
	class Voice : Text{
                private unowned Music Footsteps;
                private unowned Music Bonk;
                private unowned Music Ambient;
                private void SetSounds(List<Music*> music){
                        if ( music.nth_data(0) != null ){
                                Footsteps = music.nth_data(0);
                        }
                        if ( music.nth_data(1) != null ){
                                Bonk = music.nth_data(1);
                        }
                        if ( music.nth_data(2) != null ){
                                Ambient = music.nth_data(2);
                        }
                }
                public Voice(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer ){
                        base(corner, Surfaces, font, Labels, renderer);
                        SetSounds(music);
                }
                public Voice.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, font, Labels, renderer);
                        SetSounds(music);
                }
                public Voice.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, font, Labels, renderer, tag);
                        SetSounds(music);
                }
                public Voice.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, font, Labels, renderer, tag);
                        SetSounds(music);
                }
                public Voice.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, font, Labels, renderer, tags);
                        SetSounds(music);
                }
                public Voice.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, font, Labels, renderer, tags);
                        SetSounds(music);
                }
	}
}
