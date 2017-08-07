using SDL;
using SDLImage;
using SDLGraphics;

namespace LAIR{
	class Sprite : Anim{
                private List<Video.Texture> body = new List<Video.Texture>();
                public Sprite(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer){
                        base(new AutoRect(corner.x(),corner.y(),32,32));
                        foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                message("Number of images in stack %s", body.length().to_string());
                        }
                }
                public Sprite.ParameterList(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Parameter(new AutoRect(corner.x(),corner.y(),32,32), tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                message("Number of images in stack %s", body.length().to_string());
                        }
		}
                public Sprite.Blocked(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Blocked(new AutoRect(corner.x(),corner.y(),32,32), tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                message("Number of images in stack %s", body.length().to_string());
                        }
		}
                public Sprite.Mobile(AutoPoint corner, string aiScript, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Mobile(new AutoRect(corner.x(),corner.y(),32,32), aiScript, tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                message("Number of images in stack %s", body.length().to_string());
                        }
		}
                public Sprite.Player(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer? renderer, List<string> tags){
                        base.Player(new AutoRect(corner.x(),corner.y(),32,32), tags);
			foreach (var surface in Surfaces){
                                body.append(Video.Texture.create_from_surface(renderer, surface));
                                if(body.length() > 0){
                                        assert(body.nth_data(body.length()-1) != null);
                                }
                                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                                message("Number of images in stack %s", body.length().to_string());
                        }
		}
                public void render_copy(Video.Renderer* renderer, AutoPoint player_pos){
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
