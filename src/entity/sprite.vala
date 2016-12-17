using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
		private Video.Texture texture;
                public Sprite(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base(specs);
                        texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
                }
                public Sprite.Blocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.Blocked(specs);
                        texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
                }
		public Sprite.Parameter(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.Parameter(specs, tag);
			texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
		}
                public Sprite.ParameterBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterBlocked(specs, tag);
			texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
		}
                public Sprite.ParameterList(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterList(specs, tags);
			texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
		}
                public Sprite.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterListBlocked(specs, tags);
			texture = Video.Texture.create_from_surface(renderer, surface);
			assert(texture != null);
		}
		public void RenderCopy(Video.Renderer* renderer){
                        renderer->copyex(texture, GetSource(), GetPosition(), GetAngle(GetCenter()), GetCenter(), Video.RendererFlip.NONE);

		}
	}
}
