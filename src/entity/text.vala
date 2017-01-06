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
                public void RenderText(Video.Renderer* renderer){
                        if(showSkills){
                                for(int i = 0; i < Text.length(); i++){
                                        renderer->copyex(Text.nth_data(i), GetSource(), GetTextPosition(), 0.0, null, Video.RendererFlip.VERTICAL);
                                }
                        }
		}
	}
}
