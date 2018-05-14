using SDL;
using SDLImage;
//using SDLGraphics;

namespace LAIR{
	class Sprite : Anim{
        private List<Video.Texture> body = new List<Video.Texture>();
        public Sprite(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer renderer, string aiScript="", List<string> tags=null){
            base(new AutoRect(corner.x(),corner.y(),32,32), aiScript, tags);
			foreach (var surface in Surfaces){
                body.append(Video.Texture.create_from_surface(renderer, surface));
                if(body.length() > 0){
                    assert(body.nth_data(body.length()-1) != null);
                }
                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                message("Number of images in stack %s", body.length().to_string());
            }
		}
        /*public Sprite.IsBlocked(AutoPoint corner, List<Video.Surface*> Surfaces, Video.Renderer renderer, string aiScript="", List<string> tags=null){
            base.IsBlocked(new AutoRect(corner.x(),corner.y(),32,32), aiScript, tags);
			foreach (var surface in Surfaces){
                body.append(Video.Texture.create_from_surface(renderer, surface));
                if(body.length() > 0){
                    assert(body.nth_data(body.length()-1) != null);
                }
                body.nth_data(body.length()-1).set_blend_mode(Video.BlendMode.BLEND);
                message("Number of images in stack %s", body.length().to_string());
            }
		}*/
        public void render_copy(Video.Renderer* renderer, AutoPoint player_pos){
            if(is_player()){
                int i = 0;
                foreach(var texture in body.copy()){
                    message(i.to_string());
                    if (renderer != null) {
                        renderer->copyex(texture, get_source(), get_position(player_pos), get_angle(), null, Video.RendererFlip.VERTICAL);
                    }
                    i++;
                }
            }else{
                int i = 0;
                foreach(var texture in body.copy()){
                    message(i.to_string());
                    if (renderer != null) {
                        renderer->copyex(texture, get_source(), get_position(player_pos), 0.0, null, Video.RendererFlip.VERTICAL);
                    }
                    i++;
                }
            }
            toggle_wobble_off();
		}
	}
}
