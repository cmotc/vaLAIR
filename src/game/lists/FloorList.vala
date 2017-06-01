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
                        message("Setting regular dimensions on Floor minx %s miny %s maxx %s maxy %s", minx().to_string(),miny().to_string(),maxx().to_string(),maxy().to_string());
                }
                private void generate_floor_tile(FileDB GameMaster, AutoPoint coords, Video.Renderer* renderer){
                        if ( coords.x() < maxx() ){ if ( coords.x() >= minx() ){
                                if ( coords.y() < maxy() ){ if ( coords.y() >= miny() ){
                                        Particles.append(new Entity.Floor(coords, GameMaster.image_by_name("floor"), GameMaster.no_sound(), GameMaster.get_rand_font(), renderer));
                                }}
                        }}
                }
                public List<AutoPoint> generate_floor(FileDB GameMaster, int xx, int yy, int offset_x, int offset_y, Video.Renderer renderer){
                        List<AutoPoint> tmp = new List<AutoPoint>();
                        tmp.append(new AutoPoint(xx, yy));
                        tmp.append(new AutoPoint(offset_x, offset_y));
                        message("Placing floor at x %s y %s, os %s, oy %s",
                                tmp.nth_data(0).x().to_string(),
                                tmp.nth_data(0).y().to_string(),
                                tmp.nth_data(1).x().to_string(),
                                tmp.nth_data(1).y().to_string()
                                );//*/
                        generate_floor_tile(GameMaster, tmp.nth_data(1), renderer);
                        return tmp;
                }
                public uint length(){return Particles.length();}
                public unowned List<Entity> get_floor(){
                        return Particles;
                }
        }
}
