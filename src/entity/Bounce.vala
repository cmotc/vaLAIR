protected bool bounce(bool tl, bool tr, bool bl, bool br, Video.Rect evenout){
        bool r = false;
        if(tl){
                set_x((int)(evenout.x + get_width()));
                r = true;
        }
        if(tr){
                set_x((int)(evenout.x - get_width()));
                r = true;
        }
        if(bl){
                set_x((int)(evenout.x - get_width()));
                r = true;
        }
        if(br){
                set_x((int)(evenout.x - get_width()));
                r = true;
        }
        return r;
}
