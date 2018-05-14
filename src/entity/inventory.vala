using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Inventory : Stats{
        //private List<Entity> Storage = new List<Entity>();
        //class BodyWear{
            //Entity head;
            //Entity eyes;
            //Entity neck;
            //Entity shirt;
            //Entity chest;
            //Entity arms;
            //Entity hand1;
            //Entity hand2;
            //Entity fing1;
            //Entity fing2;
            //Entity pants;
            //Entity belt;
            //List<Entity> quiver;
            //Entity ankle1;
            //Entity ankle2;
            //Entity socks;
            //Entity shoes;
            //Entity toes;

            //Entity cache;
        //}
        public Inventory(AutoPoint corner, List<Video.Surface*> Surfaces, List<Music*> music, SDLTTF.Font* font, Video.Renderer renderer, string aiscript="", List<string> tags=null){
            base(corner, Surfaces, music, font, renderer, aiscript, tags);
        }
	}
}
