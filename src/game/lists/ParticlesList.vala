using SDL;
namespace LAIR{
	class ParticlesList : LuaConf{
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
                public ParticlesList(Video.Rect room_dimensions){
                        Border = room_dimensions;
                }
                private string generate_particle_tile(FileDB GameMaster, Video.Point coords, List<List<string>> generated_tags, Video.Renderer* renderer, int index = 0){
                        string tmp = "";
                        if ( coords.x < maxx() ){ if ( coords.x >= minx() ){
                                if ( coords.y < maxy() ){ if ( coords.y >= miny() ){
                                        string new_name = index.to_string();
                                        Particles.append(new Entity.Wall(coords,
                                                GameMaster.image_by_name(generated_tags.nth_data(0).nth_data(0)),
                                                GameMaster.no_sound(),
                                                GameMaster.get_rand_font(),
                                                renderer,
                                                generated_tags.nth_data(0),
                                                new_name));
                                        tmp = generated_tags.nth_data(0).nth_data(0);
                                }}
                        }}
                        return tmp;
                }
                public List<Video.Point?> generate_particle(FileDB GameMaster, int xx, int yy, int offset_x, int offset_y, List<List<string>> generated_tags, Video.Renderer renderer){
                        List<Video.Point?> tmp = new List<Video.Point?>();
                        tmp.append(Video.Point(){x=xx, y=yy});
                        tmp.append(Video.Point(){x=xx+offset_x, y=yy+offset_y});
                        generate_particle_tile(GameMaster, tmp.nth_data(1), generated_tags, renderer);
                        return tmp;
                }
                public uint length(){return Particles.length();}
                public unowned List<Entity> get_particles(){
                        return Particles;
                }
                public Entity get_particle(int index){
                        return Particles.nth_data(index);
                }
                public List<TagCounter> count_bytag(){
                        List<TagCounter> tag_count = new List<TagCounter>();
                        foreach(Entity particle in Particles){
                                foreach(string tag in particle.get_tags_strings()){
                                        bool has = false;
                                        foreach(TagCounter count in tag_count){
                                                if(count.check_name(tag)){
                                                        count.increment_count();
                                                        has = true;
                                                        break;
                                                }
                                        }
                                        if(!has){
                                                tag_count.append(new TagCounter(tag));
                                        }
                                }
                        }
                        return tag_count;
                }
        }
}
