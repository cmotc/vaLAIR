using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
                private List<Video.Texture> body = new List<Video.Texture>();
		private Video.Texture texture;
                public Sprite(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base(specs);
                        body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
                }
                public Sprite.Blocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.Blocked(specs);
                        body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
                }
		public Sprite.Parameter(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.Parameter(specs, tag);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterBlocked(specs, tag);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterList(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterList(specs, tags);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        Video.Rect specs = {corner.x, corner.y, surface->w, surface->h};
                        base.ParameterListBlocked(specs, tags);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
		public void RenderCopy(Video.Renderer* renderer){
                        foreach(var texture in body.copy()){
                                renderer->copyex(texture, GetSource(), GetPosition(), GetAngle(GetCenter()), GetCenter(), Video.RendererFlip.NONE);
                        }

		}
	}
}
