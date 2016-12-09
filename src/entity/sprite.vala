using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
		private Video.Texture texture;
                public Sprite(int x, int y, Video.Surface* surface, Video.Renderer? renderer){
                        base(x, y, surface->w, surface->h);
                        texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
                }
		public Sprite.Parameters(Video.Surface* surface, Video.Renderer? renderer){
                        base(64,64, surface->w, surface->h);
			texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
		}
		public void RenderCopy(Video.Renderer* renderer){
			renderer->copy(texture, GetSource(), GetPosition());
		}
	}
}