using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
                private List<Video.Texture> body = new List<Video.Texture>();
		//private Video.Texture texture;
                public Sprite(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        base(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h});
                        body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
                }
                public Sprite.Blocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer){
                        base.Blocked(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h});
                        body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
                }
		public Sprite.Parameter(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        base.Parameter(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h}, tag);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h}, tag);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterList(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h}, tags);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
                public Sprite.ParameterListBlocked(Video.Point corner, Video.Surface* surface, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(Video.Rect(){x=corner.x, y=corner.y, w=surface->w, h=surface->h}, tags);
			body.append(Video.Texture.create_from_surface(renderer, surface));
			assert(body.nth_data(0) != null);
		}
		public void RenderCopy(Video.Renderer* renderer){
                        foreach(var texture in body.copy()){
                                renderer->copy(texture, GetSource(), GetPosition());
                                //renderer->copyex(texture, GetSource(), GetPosition(), GetAngle(GetCenter()), GetCenter(), Video.RendererFlip.NONE);
                        }

		}
	}
}
