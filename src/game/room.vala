using SDL;
namespace LAIR{
	class Room : Object{
		private int W;
		private int H;
		private bool visited = false;
		private List<Entity> Particles = new List<Entity>();
		private Entity* Player = null;
		private List<Entity> Mobs = new List<Entity>();
		public Room(int width, int height, GLib.Rand* DM){
			W = width;
			H = height;
		}
		public Room.WithPlayer(int width, int height, Entity* player){
			W = width;
			H = height;
			Player = player;
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
