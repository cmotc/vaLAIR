using SDL;

namespace LAIR{
	class AutoPoint{
                public Video.Point point = Video.Point(){x=-1, y=-1};
                public AutoPoint(int xx, int yy){
                        point = Video.Point(){x=xx, y=yy};
                        point.x=xx;
                        point.y=yy;
                }
                public AutoPoint.from_point(Video.Point xy = Video.Point(){x=0, y=0}){
                        point = xy;
                }
                public void set_position(int xx, int yy){
                        point = Video.Point(){x=xx, y=yy};
                        point.x=xx;
                        point.y=yy;
                }
                public int x(){return point.x;}
                public int y(){return point.y;}
                public Video.Point get_point(){
                        return point;
                }
                public string to_string(){
                        return "X: " + point.x.to_string() + " Y: " + point.y.to_string();
                }
        }
}
