using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
		private Video.Texture texture;
		public Sprite.Parameters(Video.Surface* surface, Video.Renderer? renderer){
			texture = Video.Texture.create_from_surface(renderer, surface);
			SetWidth(surface->w);
			SetHeight(surface->h);
			assert(texture != null);
		}
		public void RenderCopy(Video.Renderer* renderer){
			renderer->copy(texture, GetSource(), GetPosition());
		}
	}
}