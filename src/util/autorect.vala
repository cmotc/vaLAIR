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
        public int xa(){
            return inner_rect.x / 32;
        }
        public void set_x(int newx){
            inner_rect.x = newx;
        }
        public int y(){
            return inner_rect.y;
        }
        public int ya(){
            return inner_rect.y / 32;
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
        public AutoRect quadrant_one(){
            return new AutoRect(
                    x(), y(), halfw(), halfh()
                );
        }
        public AutoRect quadrant_two(){
            return new AutoRect(
                    x()+(int)halfw(), y(), halfw(), halfh()
                );
        }
        public AutoRect quadrant_three(){
            return new AutoRect(
                    x(), y()+(int)halfh(), halfw(), halfh()
                );
        }
        public AutoRect quadrant_four(){
            return new AutoRect(
                    x()+(int)halfw(), y()+(int)halfh(), halfw(), halfh()
                );
        }
        public List<AutoRect> quadrants(){
            List<AutoRect> tmp = new List<AutoRect>();
            tmp.append(quadrant_one());
            tmp.append(quadrant_two());
            tmp.append(quadrant_three());
            tmp.append(quadrant_four());
            return tmp;
        }
        public int in_which_quadrant(AutoPoint point){
            int t = 0;
            if(quadrant_one().in_range(point)){
                t = 1;
            }else if(quadrant_two().in_range(point)){
                t = 2;
            }else if(quadrant_three().in_range(point)){
                t = 3;
            }else if(quadrant_four().in_range(point)){
                t = 4;
            }else{
                t = 0;
            }
            return t;
        }
        public int[] overlap_which_quadrant(AutoRect rect){
            int[4] r = {0,0,0,0};
            r[0] = rect.in_which_quadrant(tlc());
            r[1] = rect.in_which_quadrant(trc());
            r[2] = rect.in_which_quadrant(blc());
            r[3] = rect.in_which_quadrant(brc());
            return r;
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
        private void ignore_unused(){
            xa();
            ya();
            set_w(1);
            set_h(1);
            quadrants();
        }
    }
}
