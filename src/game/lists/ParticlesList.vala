using SDL;
namespace LAIR{
	class ParticlesList : Scribe{
                private List<Entity> Particles = new List<Entity>();
                private AutoRect Border = new AutoRect(0,0,0,0);
                int minx(){
                        return Border.x();
                }
                int miny(){
                        return Border.y();
                }
                int maxx(){
                        return Border.x()+(int)Border.w();
                }
                int maxy(){
                        return Border.y()+(int)Border.h();
                }
                public ParticlesList(AutoRect room_dimensions){
                        Border = new AutoRect(room_dimensions.x(),room_dimensions.y(),room_dimensions.w(),room_dimensions.h());
                        message("Setting regular dimensions on Particles minx %s miny %s maxx %s maxy %s", minx().to_string(),miny().to_string(),maxx().to_string(),maxy().to_string());
                }
                private string generate_particle_tile(FileDB GameMaster, AutoPoint coords, List<List<string>> generated_tags, Video.Renderer* renderer, int index = 0){
                        string tmp = "";
                        if ( coords.x() < maxx() ){ if ( coords.x() >= minx() ){
                                if ( coords.y() < maxy() ){ if ( coords.y() >= miny() ){
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
                public void generate_particle(FileDB GameMaster, List<AutoPoint> point_list, List<List<string>> generated_tags, Video.Renderer renderer){
                        bool t = false;
                        foreach(var tag_list in generated_tags.copy()){
                                foreach(string tag in tag_list){
                                        message("Tag in Tag List:%s",tag);
                                        t = true;
                                }
                        }
                        if(t){
                                message("Placing particle at x %s y %s, os %s, oy %s",
                                        point_list.nth_data(0).x().to_string(),
                                        point_list.nth_data(0).y().to_string(),
                                        point_list.nth_data(1).x().to_string(),
                                        point_list.nth_data(1).y().to_string()
                                        );//*/
                                generate_particle_tile(GameMaster, point_list.nth_data(1), generated_tags, renderer);
                        }
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
