using SDL;
using Lua;

namespace LAIR{
	class Room : LuaConf{
		private bool visited = false;
                private Video.Rect Border = Video.Rect(){ x = 0, y = 0, w = 0, h = 0 };
		private List<Entity> Particles = new List<Entity>();
		private List<Entity> Mobs = new List<Entity>();
                private Entity Player = null;
                private static FileDB GameMaster = null;
                public Room(int width, int height, string[] scripts, FileDB DM, Video.Renderer? renderer, int[] xyoffset){
                        GameMaster = DM;
                        RegisterLuaFunctions(scripts[0]);
                        SetDimensions(xyoffset[0], xyoffset[1], width, height);
                        GenerateStructure(0, xyoffset, renderer);
		}
                public Room.WithPlayer(int width, int height, string[] scripts, FileDB DM, Video.Renderer? renderer, int[] xyoffset){
                        GameMaster = DM;
                        RegisterLuaFunctions(scripts[0]);
                        SetDimensions(xyoffset[0], xyoffset[1], width, height);
                        GenerateStructure(0, xyoffset, renderer);
                        //EnterRoom(new Entity.Player(Video.Point(){x = 128, y = 128}, GameMaster.BodyByTone("med"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        EnterRoom(new Entity.Player(Video.Point(){x = 128, y = 128}, GameMaster.ImageByName("human"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
		}
                private void SetDimensions(int x, int y, int w, int h){
                        Border.x = x;
                        Border.y = y;
                        Border.w = w;
                        Border.h = h;
                }
                private int GetX(){     return (int) Border.x;}
                private int GetY(){     return (int) Border.y;}
                private int GetW(){     return (int) Border.w;}
                private int GetH(){     return (int) Border.h;}
                private static void RegisterLuaFunctions(string MapGenScriptPath){
                        LoadLuaFile(MapGenScriptPath);
                        LuaRegister("particle_count", particle_count);
                        LuaRegister("mobile_count", mobile_count);
                }
                private static int particle_count(LuaVM vm){
                        return 1;
                }
                private static int mobile_count(LuaVM vm){
                        return 1;
                }
                private void DecideBlockTile(int x, int y, int WT, int HT, Video.Renderer* renderer){
                        //int XO = (x * 32) + GetX(); int YO = (y * 32) + GetY();
                        LuaDoFunction("map_image_decide");
                        List<string> imgtags = GetLuaLastReturn();
                        LuaDoFunction("map_sound_decide");
                        List<string> sndtags = GetLuaLastReturn();
                        LuaDoFunction("map_font_decide");
                        List<string> fnttags = GetLuaLastReturn();
                        //Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName(imgtags), GameMaster.GetRandSound(sndtags), GameMaster.GetRandFont(fnttags), renderer));
                        //inject_particle
                        foreach(string i in imgtags){
                                stdout.printf("%s, ", i);
                        }
                        stdout.printf("\n");
                        foreach(string s in sndtags){
                                stdout.printf("%s, ", s);
                        }
                        stdout.printf("\n");
                        foreach(string t in fnttags){
                                stdout.printf("%s, ", t);
                        }
                        stdout.printf("\n");
                }
                private void DecideMobileTile(int x, int y, int WT, int HT, Video.Renderer* renderer){
                        //int XO = (x * 32) + GetX(); int YO = (y * 32) + GetY();
                        LuaDoFunction("map_image_decide");
                        List<string> imgtags = GetLuaLastReturn();
                        LuaDoFunction("map_sound_decide");
                        List<string> sndtags = GetLuaLastReturn();
                        LuaDoFunction("map_font_decide");
                        List<string> fnttags = GetLuaLastReturn();
                        //Mobiles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName(imgtags), GameMaster.GetRandSound(sndtags), GameMaster.GetRandFont(fnttags), renderer));
                        //inject_mobile
                        foreach(string i in imgtags){
                                stdout.printf("%s, ", i);
                        }
                        stdout.printf("\n");
                        foreach(string s in sndtags){
                                stdout.printf("%s, ", s);
                        }
                        stdout.printf("\n");
                        foreach(string t in fnttags){
                                stdout.printf("%s, ", t);
                        }
                        stdout.printf("\n");
                }
                //Only coarse generation of the dungeon structure is done in the native code, most of the logic will be handed to scripts eventually.
                private void GenerateStructure( int CR, int[] xyoffset, Video.Renderer* renderer){
                        int WT = (int)(GetW() / 32); int HT = (int)(GetH() / 32);
                        stdout.printf("    Generating room. Width: %s ", WT.to_string()); stdout.printf("Height %s\n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        GenerateBlockTile(x, y, WT, HT, CR, renderer);
                                        DecideBlockTile(x, y, WT, HT, renderer);
                                        DecideMobileTile(x, y, WT, HT, renderer);
                                }
                        }
                }
                private void GenerateBlockTile(int x, int y, int WT, int HT, int CR, Video.Renderer* renderer){
                        int XO = (x * 32) + GetX(); int YO = (y * 32) + GetY();
                        Particles.append(new Entity(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName("floor"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        stdout.printf("     Generating Entity Particle X: %s ", XO.to_string()); stdout.printf("Y: %s \n", YO.to_string());
                        if ( x == (0 + GameMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName("wall"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        }else if ( x == ((WT-1) - GameMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName("wall"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        }else if ( y == (0 + GameMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName("wall"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        }else if ( y == ((HT-1) - GameMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName("wall"), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                        }
                }
                public bool HasPlayer(){
			bool tmp = false;
			if (Player != null){
				tmp = true;
                                visited = true;
			}
			return tmp;
		}
                public Entity GetPlayer(){
			Entity tmp = null;
			if (Player != null){
				tmp = Player;
			}
			return tmp;
		}
                public int TakeTurns(){
                        int tmp = 1;
                        if (HasPlayer()){
                                tmp = Player.run();
                                if (tmp > 0){
                                        stdout.printf("    Player took a turn : %s \n", tmp.to_string());
                                }
                        }else{
                                foreach(Entity mob in Mobs){
					mob.run();
				}
                        }
                        return tmp;
                }
                public bool DetectCollisions(){
                        bool t = false;
                        foreach(var particle in Particles){
                                if(HasPlayer()){
                                        t = Player.DetectCollision(particle) ? true : t ;
                                }
                                //foreach(var mob in Mobs){
                                        //particle.DetectCollision(mob);
                                        //t = Player.DetectCollision(mob) ? Player.DetectCollision(mob) : t;
                                //}
                        }
                        return t;
                }
                private Video.Rect GetHitBox(){
                        return Border;
                }
                private bool InRange(Video.Point point, Video.Rect hitbox){
                        bool t = false;
                        int xx = (int) (hitbox.x + hitbox.w);
                        int yy = (int) (hitbox.y + hitbox.h);
                        if ( point.x > hitbox.x ){
                                if ( point.x <  xx ){
                                        if( point.y > hitbox.y ){
                                                if( point.y < yy ){
                                                        t = true;
                                                }
                                        }
                                }
                        }
                        return t;
                }
                public bool DetectTransition(Entity t){
                        bool r = false;
                        assert(t != null);
                        Video.Point tlc = Video.Point(){ x = t.GetHitBox().x,
                                y=t.GetHitBox().y };
                        bool TLeftCorner = InRange(tlc, GetHitBox());

                        Video.Point trc = Video.Point(){ x = (int)(t.GetHitBox().x + t.GetHitBox().w),
                                y = t.GetHitBox().y };
                        bool TRightCorner = InRange(trc, GetHitBox());

                        Video.Point blc = Video.Point(){ x = t.GetHitBox().x,
                                y = (int)(t.GetHitBox().y + t.GetHitBox().h) };
                        bool BLeftCorner = InRange(blc, GetHitBox());

                        Video.Point brc = Video.Point(){ x = (int)(t.GetHitBox().x + t.GetHitBox().w),
                                y = (int)(t.GetHitBox().y + t.GetHitBox().h) };
                        bool BRightCorner = InRange( brc, GetHitBox());

                        if (TLeftCorner){if (TRightCorner){
                                if (BLeftCorner){if (BRightCorner){
                                        r = true;
                                }}
                        }}

                        return r;
                }
		public void RenderCopy(Video.Renderer renderer){
			if (visited){
				foreach(Entity particle in Particles){
					particle.RenderCopy(renderer);
				}
			}
                        if (HasPlayer()){
				Player.RenderCopy(renderer);
				if (visited = false){
					visited = true;
				}
				foreach(Entity mob in Mobs){
					mob.RenderCopy(renderer);
				}
			}
		}
		public bool EnterRoom(Entity player){
			if (player != null){
                                stdout.printf("    Player Entering Room. \n");
				Player = player;
                                visited = true;
			}else{
                                Player = null;
                                visited = false;
                        }
			return visited;
		}
		public Entity LeaveRoom(bool doleave){
                        Entity tmp = null;
                        if (doleave){
                                if (Player != null){
                                        tmp = Player;
                                        Player = null;
                                }
                        }
			return tmp;
		}
                //lua interfaces for dungeon generation start here, already loose naming conventions deliberately changed...
                /*private void inject_particle(int x, int y, string name, Video.Renderer* renderer){
                        int XO = (x * 32) + GetX(); int YO = (y * 32) + GetY();
                        if ( XO < GetX() + GetW() ){ if ( XO > GetX() ){
                                if ( YO < GetY() + GetW() ){ if ( YO > GetY() ){
                                        Particles.append(new Entity(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName(name), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                                }}
                        }}
                }
                private void inject_mobile(int x, int y, string name, Video.Renderer* renderer){
                        int XO = (x * 32) + GetX(); int YO = (y * 32) + GetY();
                        if ( XO < GetX() + GetW() ){ if ( XO > GetX() ){
                                if ( YO < GetY() + GetW() ){ if ( YO > GetY() ){
                                        Mobs.append(new Entity(Video.Point(){ x = XO, y = YO }, GameMaster.ImageByName(name), GameMaster.GetRandSound(), GameMaster.GetRandFont(), renderer));
                                }}
                        }}
                }*/
	}
}
