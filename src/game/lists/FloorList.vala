using SDL;
namespace LAIR{
	class FloorList : LuaConf{
                private List<Entity> Particles = new List<Entity>();
                private Video.Rect Border = Video.Rect(){ x = 0, y = 0, w = 0, h = 0 };
                int minx(){
                        return Border.x;
                }
                int miny(){
                        return Border.y;
                }
                int maxx(){
                        return Border.x+(int)Border.w;
                }
                int maxy(){
                        return Border.y+(int)Border.h;
                }
                public FloorList(Video.Rect room_dimensions){
                        Border = room_dimensions;
                }
                private void generate_floor_tile(FileDB GameMaster, Video.Point coords, Video.Renderer* renderer){
                        if ( coords.x < maxx() ){ if ( coords.x >= minx() ){
                                if ( coords.y < maxy() ){ if ( coords.y >= miny() ){
                                        Particles.append(new Entity.Floor(coords, GameMaster.image_by_name("floor"), GameMaster.no_sound(), GameMaster.get_rand_font(), renderer));
                                }}
                        }}
                }
                public List<Video.Point?> generate_floor(FileDB GameMaster, int xx, int yy, int offset_x, int offset_y, Video.Renderer renderer){
                        List<Video.Point?> tmp = new List<Video.Point?>();
                        tmp.append(Video.Point(){x=xx, y=yy});
                        tmp.append(Video.Point(){x=xx+offset_x, y=yy+offset_y});
                        generate_floor_tile(GameMaster, tmp.nth_data(1), renderer);
                        return tmp;
                }
                public uint length(){return Particles.length();}
                public unowned List<Entity> get_floor(){
                        return Particles;
                }
        }
}
