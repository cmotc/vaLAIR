using SDL;
namespace LAIR{
	class RoomsList : LuaConf {
                protected AutoRect floor_dims;
                protected List<Room> rooms = new List<Room>();
                protected unowned string[] lua_scripts;
                protected AutoRect position_with_offset;
                public RoomsList(string[] scripts){
                        base(scripts[0]);
                        int count = 2;
                        int width = ((count * 6) * 32);
                        int height = ((count * 6) * 32);
                        floor_dims = new AutoRect(0,0,(width * count),(height * count));
                        position_with_offset = new AutoRect((0*width),(0*height),width,height);
                }
        }
}
