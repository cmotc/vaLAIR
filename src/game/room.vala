using SDL;
namespace LAIR{
	class Room : Object{
		private bool visited = true;
		private List<Entity> Particles = new List<Entity>();
		private Entity* Player = null;
		private List<Entity> Mobs = new List<Entity>();
                private GLib.Rand DungeonMaster = new GLib.Rand ();
		public Room(int width, int height, FileDB* DM, Video.Renderer? renderer){
                        int WT = (width / 32); int HT = (height / 32);
                        stdout.printf("    Generating room. Width: %s ", WT.to_string()); stdout.printf("Height %s \n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        Particles.append(new Entity(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonefloor"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        stdout.printf("     Generating Entity Particle X: %s ", x.to_string()); stdout.printf("Y: %s \n", y.to_string());
                                        if ( x == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( x == ((WT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( y == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( y == ((HT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }
                                }
                        }
                        stdout.printf("    Generated room. Length: %s\n", Particles.length().to_string());
		}
		public Room.WithPlayer(int width, int height, FileDB* DM, Video.Renderer? renderer){
                        int WT = (width / 32); int HT = (height / 32);
                        EnterRoom(new Entity.Player(Video.Point(){x = 128, y = 128}, DM->ImageByName("colortest"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                        stdout.printf("    Generating room with Player. Width: %s ", WT.to_string()); stdout.printf("Height %s\n", HT.to_string());
                        for (int x = 0; x < WT; x++){
                                for (int y = 0; y < HT; y++){
                                        Particles.append(new Entity(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonefloor"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        stdout.printf("     Generating Entity Particle X: %s ", x.to_string()); stdout.printf("Y: %s\n", y.to_string());
                                        if ( x == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( x == ((WT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( y == (0 + DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }else if ( y == ((HT-1) - DungeonMaster.int_range(0,2)) ){
                                                Particles.append(new Entity.Blocked(Video.Point(){ x = (x * 32), y = (y * 32)}, DM->ImageByName("stonewall"), DM->GetRandSound(), DM->GetRandFont(), renderer));
                                        }
                                }
                        }
                        stdout.printf("    Generated room. Length: %s\n", Particles.length().to_string());
		}
                public int TakeTurns(){
                        int tmp = 1;
                        stdout.printf("    Entities in the room are taking turns\n");
                        if (HasPlayer()){
                                tmp = (tmp != 1) ? tmp : Player->PInput();
                        }else{
                                foreach(Entity mob in Mobs){
					mob.run();
				}
                        }
                        return tmp;
                }
		public void RenderCopy(Video.Renderer* renderer){
			if (visited){
                                stdout.printf("    Rendering Entities. \n");
				foreach(Entity particle in Particles){
					particle.RenderCopy(renderer);
				}
			}
			if (HasPlayer()){
                                stdout.printf("    Rendering Player. \n");
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
			if (player != null){
                                stdout.printf("    Player Entering Room. \n");
				Player = player;
                                if (Player != null){
                                        visited = true;
                                }
			}
			return visited;
		}
		public Entity LeaveRoom(){
			Entity tmp = Player;
			Player = null;
			return tmp;
		}
		public bool HasPlayer(){
			bool tmp = false;
			if (Player != null){
				tmp = (Player != null) ? (Player != null) : false;
			}
			return tmp;
		}
	}
}
