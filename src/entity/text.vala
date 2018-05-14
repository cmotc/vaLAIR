using SDL;
//using SDLGraphics;
using SDLImage;
using SDLTTF;

namespace LAIR{
	class Text : Sprite{
        private unowned SDLTTF.Font Font;
        private List<Video.Texture> Text = new List<Video.Texture>();
        private bool showStats = false;
        private bool showSkills = false;
        private Video.Color GetColor(){
            Video.Color r = {0, 0, 0};
            return r;
        }
        private void insert_label(List<string> Labels, Video.Renderer renderer){
            foreach(string label in Labels.copy()){
                if(label != null){
                    if(renderer != null){
                        Text.append(Video.Texture.create_from_surface(renderer, Font.render(label, GetColor())));
                    }
                }
            }
        }
        public Text.UnBlocked(AutoPoint corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer renderer, string aiScript="", List<string> tags=null){
            base.UnBlocked(corner, Surfaces, renderer, aiScript, tags);
            Font = font;
            insert_label(Labels, renderer);
        }
        public Text.IsBlocked(AutoPoint corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer renderer, string aiScript="", List<string> tags=null){
            base.IsBlocked(corner, Surfaces, renderer, aiScript, tags);
            Font = font;
            insert_label(Labels, renderer);
        }
        protected void show_stats(){
            showStats = !showStats;
        }
        protected void show_skills(){
            showSkills = !showSkills;
        }
        public void render_text(Video.Renderer* renderer, AutoPoint player_pos){
            if(showStats){
                message("Showing Stats");
                for(int i = 0; i < 5; i++){
                    AutoPoint tmp = new AutoPoint(
                        player_pos.x() - 34,
                        player_pos.y() - 2 - (i*11)
                    );
                    renderer->copyex(Text.nth_data(i), get_text_source(), get_text_position(tmp), 0.0, null, Video.RendererFlip.NONE);
                }
            }
            if(showSkills){
                message("Showing Skills");
                for(int i = 5; i < 5 + Text.length(); i++){
                    AutoPoint tmp = new AutoPoint(
                        player_pos.x() - 34,
                        player_pos.y() - 2 - (i*11)
                    );
                    renderer->copyex(Text.nth_data(i), get_text_source(), get_text_position(tmp), 0.0, null, Video.RendererFlip.NONE);
                }
            }
		}
	}
}
