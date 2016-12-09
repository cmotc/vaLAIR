using SDL;
namespace LAIR{
	class Room : Object{
		private int W;
		private int H;
		private bool visited = true;
		private List<Entity> Particles = new List<Entity>();
		private Entity* Player = null;
		private List<Entity> Mobs = new List<Entity>();
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
                                        if ( x == 0 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( x == WT-1 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( y == 0 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( y == HT-1 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
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
			Player = player;
                        stdout.printf("Generating room with Player. \n");
                        stdout.printf("Width: %s ", WT.to_string());
                        stdout.printf("Height %s \n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        if ( x == 0 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( x == WT-1 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( y == 0 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                        if ( y == HT-1 ){
                                                Particles.append(new Entity.Single((x * 32), (y * 32), DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                                stdout.printf("Generating Entity Particle X: %s ", x.to_string());
                                                stdout.printf("Y: %s \n", y.to_string());
                                        }
                                }
                        }
		}
                public int TakeTurns(){
                        int tmp = 1;
                        if (Player != null){
                                tmp = Player->PInput();
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer* renderer){
                        stdout.printf("Propagating Renderer to Entities. \n");
			if (visited){
				foreach(Entity particle in Particles){
					particle.RenderCopy(renderer);
				}
			}
			if (Player != null){
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
