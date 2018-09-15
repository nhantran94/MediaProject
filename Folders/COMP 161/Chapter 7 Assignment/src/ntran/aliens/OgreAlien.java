/**
 * 
 */
package ntran.aliens;

/**
 * @author ntt3013
 *
 */
public class OgreAlien extends Alien {
	private final int DAMAGE = 6;

	/**
	 * 
	 */
	public OgreAlien() {
		// TODO Auto-generated constructor stub
	}
	public OgreAlien(int health, String name) {
		super (health,name);
		setDamage(DAMAGE);
			
			// TODO Auto-generated constructor stub
		}
	public OgreAlien (Alien that){
		super (that);
		setDamage (that.getDamage());
		
	}
	@Override
	public boolean equals (Object obj){
		  if (obj ==null)
				return false;
			if (obj.getClass()!=this.getClass())
				return false;
			OgreAlien that = (OgreAlien) obj;
			return (getName().equals(that.getName()))&&getHealth()==that.getHealth()&&getDamage()==that.getDamage();
	}
	@Override
	public String toString(){
		return ("Name"+getName()+"\nHealth: "+getHealth()+ "\nDamage "+getDamage()+ "\n");
	}
	
	
}


