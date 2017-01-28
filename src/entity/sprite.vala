using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	class Sprite : Anim{
                private List<Video.Texture> body = new List<Video.Texture>();
                public Sprite(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer){
                        base(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32});
                        foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                print_withname("Number of images in stack %s \n", body.length().to_string());
                        }
                }
                public Sprite.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Parameter(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                print_withname("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public Sprite.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Blocked(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                print_withname("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public Sprite.Player(Video.Point corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Player(Video.Rect(){x=corner.x, y=corner.y, w=32, h=32}, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                print_withname("Number of images in stack %s \n", body.length().to_string());
                        }
		}
                public void render_copy(Video.Renderer* renderer, Video.Point player_pos){
                        if(is_player()){
                                foreach(var texture in body.copy()){
                                        renderer->copyex(texture, get_source(), get_position(player_pos), get_angle(), null, Video.RendererFlip.VERTICAL);
                                }
                        }else{
                                foreach(var texture in body.copy()){
                                        renderer->copyex(texture, get_source(), get_position(player_pos), 0.0, null, Video.RendererFlip.VERTICAL);
                                }
                        }
                        toggle_wobble_off();
		}
	}
}
