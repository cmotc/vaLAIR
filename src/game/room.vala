using SDL;
namespace LAIR{
	class Room : Object{
		private int W;
		private int H;
		private bool visited = true;
		private List<Entity> Particles = new List<Entity>();
		private Entity* Player = null;
		private List<Entity> Mobs = new List<Entity>();
                private GLib.Rand DungeonMaster = new GLib.Rand ();
		public Room(int width, int height, FileDB* DM, Video.Renderer? renderer){
			W = width;
			H = height;
                        int WT = (W / 32);
                        int HT = (H / 32);
                        stdout.printf("Generating room. ");
                        stdout.printf("Width: %s ", WT.to_string());
                        stdout.printf("Height %s \n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        Video.Point corner = Video.Point(){ x = (x * 32), y = (y * 32)};
                                        Particles.append(new Entity.Single(corner, DM->ImageByName("stonefloor"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        if ( x == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( x == ((WT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( y == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( y == ((HT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                }
                        }
		}
		public Room.WithPlayer(int width, int height, Entity* player, FileDB* DM, Video.Renderer? renderer){
			W = width;
			H = height;
                        int WT = (W / 32);
                        int HT = (H / 32);
                        Video.Point ENTER = Video.Point(){ x = 128, y = 128};
                        player = new Entity.Player(ENTER, DM->ImageByName("colortest"), DM->GetRandSound(), DM->GetRandFont(), renderer);
			Player = player;
                        stdout.printf("Generating room with Player. \n");
                        stdout.printf("Width: %s ", WT.to_string());
                        stdout.printf("Height %s \n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        Video.Point corner = Video.Point(){ x = (x * 32), y = (y * 32)};
                                        Particles.append(new Entity.Single(corner, DM->ImageByName("stonefloor"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        if ( x == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( x == ((WT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( y == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }else
                                        if ( y == ((HT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(corner, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                }
                        }
		}
                public int TakeTurns(){
                        int tmp = 1;
                        stdout.printf("   Entities in the room are taking turns\n");
                        if (Player != null){
                                stdout.printf("    Getting Player input,");
                                tmp = Player->PInput();
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer* renderer){
                        stdout.printf("   Rendering Entities. \n");
			if (visited){
				foreach(Entity particle in Particles){
					particle.RenderCopy(renderer);
				}
			}
			if (Player != null){
                                stdout.printf("   Rendering Player. \n");
				Player->RenderCopy(renderer);
				if (visited = false){
					visited = true;
				}
				foreach(Entity mob in Mobs){
					mob.RenderCopy(renderer);
				}
			}
		}
		public bool EnterRoom(Entity player){
			bool tmp = false;
			if (player != null){
				Player = player;
				tmp = true;
				visited = true;
			}
			return tmp;
		}
		public Entity* LeaveRoom(){
			Entity* tmp = Player;
			Player = null;
			return tmp;
		}
		public bool HasPlayer(){
			bool tmp = false;
			if (Player != null){
				tmp = true;
			}
			return tmp;
		}
	}
}
