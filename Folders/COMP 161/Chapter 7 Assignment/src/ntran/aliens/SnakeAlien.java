package ntran.aliens;

public class SnakeAlien extends Alien
{
	private final int DAMAGE = 10;

	/**
	 * 
	 */
	public SnakeAlien() {
		// TODO Auto-generated constructor stub
	}
	public SnakeAlien(int health, String name) {
		super (health,name);
		setDamage(DAMAGE);
			
			// TODO Auto-generated constructor stub
		}
	public SnakeAlien (Alien that){
		super (that);
		setDamage (that.getDamage());
		
	}
	@Override
	public boolean equals (Object obj){
		  if (obj ==null)
				return false;
			if (obj.getClass()!=this.getClass())
				return false;
			SnakeAlien that = (SnakeAlien) obj;
			return (getName().equals(that.getName()))&&getHealth()==that.getHealth()&&getDamage()==that.getDamage();
	}
	@Override
	public String toString(){
		return ("Name"+getName()+"\nHealth: "+getHealth()+ "\nDamage "+getDamage()+ "\n");
	}
	
	
}

