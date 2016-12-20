using SDL;
using SDLMixer;
using SDLTTF;
namespace LAIR{
	class Stats : Net{
		private int Strength = 10;
		private int Agility = 10;
		/*private int Toughness = 10;
		private int Intelligence = 10;
		private int Special = 10;*/
		private int speed = 0;/*
		private int exert = 0;
		private int dodge = 0;
		private int aim = 0;
		private int will = 0;
		private int resist = 0;
		private int magic = 0;
		private int tech = 0;*/
                public Stats(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer ){
                        base(corner, Surfaces, music, font, renderer);
                }
                public Stats.Blocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer){
                        base.Blocked(corner, Surfaces, music, font, renderer);
                }
                public Stats.Parameter(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.Parameter(corner, Surfaces, music, font, renderer, tag);
                }
                public Stats.ParameterBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, string tag){
                        base.ParameterBlocked(corner, Surfaces, music, font, renderer, tag);
                }
                public Stats.ParameterList(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterList(corner, Surfaces, music, font, renderer, tags);
                }
                public Stats.ParameterListBlocked(Video.Point corner, List<Video.Surface*> Surfaces, Music* music, SDLTTF.Font* font, Video.Renderer? renderer, List<string> tags){
                        base.ParameterListBlocked(corner, Surfaces, music, font, renderer, tags);
                }
		public int Speed(){
			int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + speed;
		}/*
		public int Exert(){
			int tmp = (Strength + Toughness) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + exert;
		}
		public int Dodge(){
			int tmp = (Agility + Toughness) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + dodge;
		}
		public int Aim(){
			int tmp = (Agility + Intelligence) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + aim;
		}
		public int Will(){
			int tmp = (Toughness + Intelligence) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + will;
		}
		public int Resist(){
			int tmp = (Toughness + Special) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + resist;
		}
		public int Magic(){
			int tmp = (Intelligence + Special) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + magic;
		}
		public int Tech(){
			int tmp = (Intelligence + Agility) / 4;
                        int tmp = ( ( (Strength / 5) + (Agility / 2) ) / 2 ) ;
			return tmp + tech;
		}*/
	}
}
