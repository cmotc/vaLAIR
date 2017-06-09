using SDL;

namespace LAIR{
	class AutoRect : Scribe{
                private Video.Rect inner_rect = Video.Rect(){x=0,y=0,w=32,h=32};
                public AutoRect(int xx, int yy, uint ww, uint hh){
                        inner_rect = Video.Rect(){
                                x = xx,
                                y = yy,
                                w = ww,
                                h = hh
                        };
                }
                public AutoRect.FromRect(Video.Rect my_rect){
                        inner_rect = Video.Rect(){
                                x = my_rect.x,
                                y = my_rect.y,
                                w = my_rect.w,
                                h = my_rect.h
                        };
                }
                public int x(){
                        return inner_rect.x;
                }
                public void set_x(int newx){
                        inner_rect.x = newx;
                }
                public int y(){
                        return inner_rect.y;
                }
                public void set_y(int newy){
                        inner_rect.y = newy;
                }
                public uint w(){
                        return inner_rect.w;
                }
                public void set_w(uint neww){
                        inner_rect.w = neww;
                }
                public uint h(){
                        return inner_rect.h;
                }
                public void set_h(uint newh){
                        inner_rect.h = newh;
                }
                public uint halfw(){
                        return inner_rect.w / 2;
                }
                public uint halfh(){
                        return inner_rect.h / 2;
                }
                public bool in_range(AutoPoint point){
                        bool t = false;
                        int xx = (int) (inner_rect.x + inner_rect.w);
                        int yy = (int) (inner_rect.y + inner_rect.h);
                        if ( point.x() > inner_rect.x ){
                                if ( point.x() <  xx ){
                                        if( point.y() > inner_rect.y ){
                                                if( point.y() < yy ){
                                                        t = true;
                                                }
                                        }
                                }
                        }
                        return t;
                }
                public List<AutoRect> quadrants(){
                        List<AutoRect> tmp = new List<AutoRect>();
                        tmp.append(new AutoRect(
                                        x(), y(), halfw(), halfh()
                                ));
                        tmp.append(new AutoRect(
                                        x()+(int)halfw(), y(), halfw(), halfh()
                                ));
                        tmp.append(new AutoRect(
                                        x(), y()+(int)halfh(), halfw(), halfh()
                                ));
                        tmp.append(new AutoRect(
                                        x()+(int)halfw(), y()+(int)halfh(), halfw(), halfh()
                                ));
                        return tmp;
                }
                public Video.Rect get_rect(){
                        return inner_rect;
                }
                public AutoPoint tlc(){
                        return new AutoPoint(x(), y());
                }
                public AutoPoint trc(){
                        return new AutoPoint(x()+(int)w(), y());
                }
                public AutoPoint blc(){
                        return new AutoPoint(x(), y()+(int)h());
                }
                public AutoPoint brc(){
                        return new AutoPoint(x()+(int)w(), y()+(int)h());
                }
        }
}
