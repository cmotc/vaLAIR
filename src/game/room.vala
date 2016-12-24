using SDL;
namespace LAIR{
	class Room : Object{
		private bool visited = false;
                private int X = 0; private int Y = 0;
                private int Width = 0; private int Height = 0;
		private List<Entity> Particles = new List<Entity>();
		private Entity Player = null;
		private List<Entity> Mobs = new List<Entity>();
                private GLib.Rand DungeonMaster = new GLib.Rand ();
		//public Room(int width, int height, FileDB* DM, Video.Renderer? renderer){
                public Room(int width, int height, FileDB DM, Video.Renderer? renderer, int[] xyoffset){
                        X = xyoffset[0]; Y = xyoffset[1];
                        Width = width; Height = height;
                        GenerateStructure(DM, 2, xyoffset, renderer);
                        stdout.printf("    Generated room. Length: %s\n", Particles.length().to_string());
		}
		//public Room.WithPlayer(int width, int height, FileDB* DM, Video.Renderer? renderer){
                public Room.WithPlayer(int width, int height, FileDB DM, Video.Renderer? renderer, int[] xyoffset){
                        X = xyoffset[0]; Y = xyoffset[1];
                        Width = width; Height = height;
                        GenerateStructure(DM, 2, xyoffset, renderer);
                        EnterRoom(new Entity.Player(Video.Point(){x = 128, y = 128}, DM.BodyByTone("med"), DM.GetRandSound(), DM.GetRandFont(), renderer));
                        stdout.printf("    Generated room. Length: %s\n", Particles.length().to_string());
		}
                //Only coarse generation of the dungeon structure is done in the native code, most of the logic will be handed to scripts eventually.
                private void GenerateStructure(FileDB DM, int CR, int[] xyoffset, Video.Renderer* renderer){
                        int WT = (Width / 32); int HT = (Height / 32);
                        stdout.printf("    Generating room. Width: %s ", WT.to_string()); stdout.printf("Height %s\n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        GenerateBlockTile(DM, x, y, WT, HT, CR, renderer);
                                }
                        }
                }
                private void GenerateBlockTile(FileDB DM, int x, int y, int WT, int HT, int CR, Video.Renderer* renderer){
                        int XO = (x * 32) + X; int YO = (y * 32) + Y;
                        Particles.append(new Entity(Video.Point(){ x = XO, y = YO }, DM.ImageByName("stonefloor"), DM.GetRandSound(), DM.GetRandFont(), renderer));
                        stdout.printf("     Generating Entity Particle X: %s ", XO.to_string()); stdout.printf("Y: %s \n", YO.to_string());
                        if ( x == (0 + DungeonMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, DM.ImageByName("stonewall"), DM.GetRandSound(), DM.GetRandFont(), renderer));
                        }else if ( x == ((WT-1) - DungeonMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, DM.ImageByName("stonewall"), DM.GetRandSound(), DM.GetRandFont(), renderer));
                        }else if ( y == (0 + DungeonMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, DM.ImageByName("stonewall"), DM.GetRandSound(), DM.GetRandFont(), renderer));
                        }else if ( y == ((HT-1) - DungeonMaster.int_range(0,CR)) ){
                                Particles.append(new Entity.Blocked(Video.Point(){ x = XO, y = YO }, DM.ImageByName("stonewall"), DM.GetRandSound(), DM.GetRandFont(), renderer));
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
                        Video.Rect r = Video.Rect(){ x = X,
                                                     y = Y,
                                                     w = Width,
                                                     h = Height };
                        return r;
                }
                private bool InRange(Video.Point point, Video.Rect hitbox){
                        bool t = false;
                        int xx = (int) (hitbox.x + hitbox.w);
                        int yy = (int) (hitbox.y + hitbox.h);
                        if ( point.x > hitbox.x ){
                                if ( point.x <  xx ){
                                        if( point.y > hitbox.y ){
                                                if( point.y < yy ){
                                                        stdout.printf("\n\n Does this Number AXC:%s", point.x.to_string());
                                                        stdout.printf(" come after this Number AX1:%s, and that number", hitbox.x.to_string());
                                                        stdout.printf(" come before this Number AX2:%s\n", xx.to_string());
                                                        stdout.printf(" Does this Number AYC:%s", point.y.to_string());
                                                        stdout.printf(" come after this Number BY1:%s, and that number", hitbox.y.to_string());
                                                        stdout.printf(" come before this Number BY2:%s\n\n", yy.to_string());
                                                        t = true;
                                                }
                                        }
                                }
                        }
                        return t;
                }
                public bool DetectTransition(Entity t){
                        int test = 0;
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
/*                private void inject_particle(FileDB DM, int x, int y, string name, Video.Renderer* renderer){
                        int XO = (x * 32) + X; int YO = (y * 32) + Y;
                        if ( XO < X + Width ){ if ( XO > X ){
                                if ( YO < Y + Height ){ if ( YO > Y ){
                                        Particles.append(new Entity(Video.Point(){ x = XO, y = YO }, DM.ImageByName(name), DM.GetRandSound(), DM.GetRandFont(), renderer));
                                }}
                        }}
                }
                private void inject_mobile(FileDB DM, int x, int y, string name, Video.Renderer* renderer){
                        int XO = (x * 32) + X; int YO = (y * 32) + Y;
                        if ( XO < X + Width ){ if ( XO > X ){
                                if ( YO < Y + Height ){ if ( YO > Y ){
                                        Mobs.append(new Entity(Video.Point(){ x = XO, y = YO }, DM.ImageByName(name), DM.GetRandSound(), DM.GetRandFont(), renderer));
                                }}
                        }}
                }*/
	}
}
