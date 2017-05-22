namespace LAIR{
	class Dice : LuaConf{
                private GLib.Rand dice_bag = new GLib.Rand();
                protected int roll_dice(int min, int max){
                        return dice_bag.int_range(min, max);
                }
                protected int roll_hundred(){
                        return roll_dice(0, 100);
                }
                protected int roll_twenty(){
                        return roll_dice(0, 20);
                }
                protected int roll_twelve(){
                        return roll_dice(0, 10);
                }
                protected int roll_eight(){
                        return roll_dice(0, 8);
                }
                protected int roll_six(){
                        return roll_dice(0, 6);
                }
                protected int roll_four(){
                        return roll_dice(0, 4);
                }
                protected int roll_two(){
                        return roll_dice(0, 2);
                }
                protected bool coin_toss(){
                        bool r = false;
                        if( roll_two() == 2 ){
                                r = true;
                        }
                        return r;
                }
                protected int roll_variable(int sides = 0){
                        int r = 0;
                        if (sides == 0){
                                r = roll_six();
                        }else{
                                r = roll_dice(0, sides);
                        }
                        return r;
                }
	}
}
