using SDL;

namespace LAIR{
	class AutoTimer : Scribe{
                private uint start_time = SDL.Timer.get_ticks();
                public AutoTimer(){
                        start_time = SDL.Timer.get_ticks();
                }
                public uint get_ticks(){
                        uint return_ticks = SDL.Timer.get_ticks() - start_time;
                        message("time passed: %s", return_ticks.to_string());
                        return return_ticks;

                }
        }
}
