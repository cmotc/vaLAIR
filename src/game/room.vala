using SDL;
namespace LAIR{
	class Room : Object{
		private int W;
		private int H;
		private bool visited = false;
		private List<Entity> Particles = new List<Entity>();
		private Entity* Player = null;
		private List<Entity> Mobs = new List<Entity>();
		public Room(int width, int height, FileDB* DM, Video.Renderer? renderer){
			W = width;
			H = height;
                        stdout.printf("Generating room. \n");
                        for (int x = 0; x < (W / 32); x++){
                                for (int y = 0; x < (H / 32); y++){
                                        stdout.printf("Generating Entity Particle X: %s \n", x.to_string());
                                        stdout.printf(" Y: %s \n", y.to_string());
                                        Particles.append(new Entity.Single((x * 32), (y * 32), DM->GetRandImage(), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                }
                        }
		}
		public Room.WithPlayer(int width, int height, Entity* player, FileDB* DM, Video.Renderer? renderer){
			W = width;
			H = height;
			Player = player;
                        stdout.printf("Generating room with Player. \n");
                        for (int x = 0; x < (W / 32); x++){
                                for (int y = 0; x < (H / 32); y++){
                                        stdout.printf("Generating Entity Particle X: %s \n", x.to_string());
                                        stdout.printf(" Y: %s \n", y.to_string());
                                        //Particles.append();
                                }
                        }
		}
		public void RenderCopy(Video.Renderer* renderer){
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
