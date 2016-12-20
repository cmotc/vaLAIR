using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	public class Sprite : Anim{
                private List<Video.Texture> body = new List<Video.Texture>();
                public Sprite(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer){
                        base(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32});
                        foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
                }
                public Sprite.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer){
                        base.Blocked(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32});
                        foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
                }
                public Sprite.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, string tag){
                        base.Parameter(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tag);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public Sprite.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tag);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public Sprite.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public Sprite.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                assert(body.nth_data(body.length()-1) != null);
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                stdout.printf("Number of images in stack %s \n", body.length().to_string());
                        }
		}
		public void RenderCopy(Video.Renderer* renderer){
                        int c = 0;
                        foreach(var texture in body.copy()){
                                stdout.printf("Rendering a layered texture: %s\n",c.to_string());
                                renderer->copyex(texture, GetSource(), GetPosition(), GetAngle(), null, Video.RendererFlip.HORIZONTAL);
                                c++;
                        }

		}
	}
}
