using SDL;
using SDLGraphics;
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
                private void InsertLabel(List<string> Labels, Video.Renderer* renderer){
                        foreach(string label in Labels.copy()){
                                if(label != null){
                                        Text.append(Video.Texture.create_from_surface(renderer, Font.render(label, GetColor())));
                                }
                        }
                }
                public Text(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer){
                        base(corner, Surfaces, renderer);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                public Text.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, renderer);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                public Text.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, renderer, tag);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                public Text.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, renderer, tag);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                public Text.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, renderer, tags);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                public Text.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, SDLTTF.Font* font, List<string> Labels, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, renderer, tags);
                        Font = font;
                        InsertLabel(Labels, renderer);
                }
                protected void ShowStats(){
                        showStats = !showStats;
                }
                protected void ShowSkills(){
                        showSkills = !showSkills;
                }
                public void RenderText(Video.Renderer* renderer, Video.Point player_pos){
                        if(showStats){
                                prints("Showing Stats\n");
                                for(int i = 0; i < 5; i++){
                                        Video.Point tmp = Video.Point(){
                                                x = player_pos.x - 34,
                                                y = player_pos.y - 2 - (i*11)
                                        };
                                        renderer->copyex(Text.nth_data(i), GetTextSource(), GetTextPositionOffset(tmp), 0.0, null, Video.RendererFlip.NONE);
                                }
                        }
                        if(showSkills){
                                prints("Showing Skills\n");
                                for(int i = 5; i < 5 + Text.length(); i++){
                                        Video.Point tmp = Video.Point(){
                                                x = player_pos.x - 34,
                                                y = player_pos.y - 2 - (i*11)
                                        };
                                        renderer->copyex(Text.nth_data(i), GetTextSource(), GetTextPositionOffset(tmp), 0.0, null, Video.RendererFlip.NONE);
                                }
                        }
		}
	}
}
