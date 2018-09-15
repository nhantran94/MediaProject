package ntran.aliens;

public class Main
{
        public static void main(String[] args)
        {
                SnakeAlien demo1 = new SnakeAlien (100, "Nhan");
                OgreAlien demo2 = new OgreAlien (100, "Messi");
                MarshmallowMan demo3 = new MarshmallowMan (100, "Ronaldo");
                Alien demo4 = new Alien (100, "Giggs");
                
                System.out.println(demo1);
                System.out.println(demo2);
                System.out.println(demo3);
                System.out.println(demo4);
                
                AlienPack  demo5 = new AlienPack (3);
                demo5.addAlien(demo1, 0);
                demo5.addAlien(demo2, 1);
                demo5.addAlien(demo3, 2);
                demo5.addAlien(demo4, 4);
                System.out.println(demo5);
                
                System.out.println("Total Damage of this Alien Pack"+ demo5.calculateDamage());
             
        }
}