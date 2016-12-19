using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Entity : Move{
                public Entity(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Entity.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Entity.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Entity.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
                public Entity.Player(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base.Parameter(corner, Surfaces, music, font, renderer, "player");
                }
                private void DoActions(Entity t){
                }
                public bool DetectCollision(Entity t){
                        bool test = false;
                        assert(t != null);
                        if(GetBlock()){
                                if(t.GetBlock()){
                                        bool leftsidebounceright = (t.GetHitBox().x + t.GetHitBox().w < GetHitBox().x)      ? true : false;
                                        bool rightsidebounceleft = (t.GetHitBox().x > GetHitBox().x + GetHitBox().w)        ? true : false;
                                        bool upsidebouncedown = (t.GetHitBox().y + t.GetHitBox().h < GetHitBox().y)      ? true : false;
                                        bool downsidebounceup = (t.GetHitBox().y > GetHitBox().y + GetHitBox().h)        ? true : false;
                                        test = leftsidebounceright ? true : false;
                                        test = rightsidebounceleft ? true : test;
                                        test = upsidebouncedown ? true : test;
                                        test = downsidebounceup ? true : test;
                                        if(test){
                                                Bounce(leftsidebounceright, rightsidebounceleft,
                                                        upsidebouncedown, downsidebounceup);
                                                DoActions(t);
                                        }
                                }
                        }
                        return test;
                }
	}
}
