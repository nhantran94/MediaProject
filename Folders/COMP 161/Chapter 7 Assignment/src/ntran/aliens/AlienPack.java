package ntran.aliens;

public class AlienPack {

	
	private Alien[] Alien;
	private AlienPack[]AlienPack;
			 
	 public AlienPack(int number)
     {
             Alien = new Alien[number];
     }
	  public int calculateDamage()
      {
              int damage = 0;
              for (int index = 0; index < getAliens().length; index++)
              {
                      damage = getAliens()[index].getDamage();
              }
              return damage;
      }
	  public void addAlien(Alien Alien, int index)
      {
              if (index > AlienPack.length)
              {
            	  System.out.println("Error No space");
            	  System.exit(0);
              }
      }
	  public Alien[] getAliens()
      {
              return Alien;
      }
	  public boolean equals (Object obj){
		  if (obj ==null)
				return false;
			if (obj.getClass()!=this.getClass())
				return false;
			AlienPack that =(AlienPack)obj;
			Alien[]thisarray=getAliens();
			Alien[]thatarray = that.getAliens();
			
			if (thisarray==thatarray){
				return true;
			}
			if (thisarray.length != thatarray.length){
				return false;
			}
	  
	  return true;
			
	  }
	  @Override
	  public String toString(){
		  String totalString ="";
		  for (int i = 0; i < AlienPack.length; i++){
			  totalString += (AlienPack[i].toString()+"\n");
		  }
		  return totalString;
	  }
	  
}