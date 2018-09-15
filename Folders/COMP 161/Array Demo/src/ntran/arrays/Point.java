package ntran.arrays;

import ntran.aliens.Alien;

public class Point {

    private int x, y;

  public Point(int x, int y){
            setX(x);
            setY(y);
  }

  public Point(Point that){
	  this.x=that.x;
		this.y=that.y;
    //TODO - 3 Points
  }

  public boolean equals(Object obj){
	  if (obj==null)
			return false;
		if (obj.getClass()!=this.getClass())
			return false;
		Point that = (Point)obj;
		
		return x.equals(that.x)&&y.equals(that.y);
				
	}         return false;
  }

  public int getX() {
      return x;
  }

  public void setX(int x) {
      this.x = x;
  }

  public int getY() {
      return y;
  }

  public void setY(int y) {
      this.y = y;
  }
        
}
