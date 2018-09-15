package ntran.chapter7;

public class HourlyEmployee extends Employee{
	
	private double wageRate;
	private double hours;
	
	public HourlyEmployee()
	{
		super();
		wageRate = 0;
		hours = 0;
	}
	public HourlyEmployee(String theName, Date theDate, Double theWageRate, double theHours)
	{
		super (theName, theDate);
		if (theWageRate >=0 && theHours >= 0){
			wageRate = theWageRate;
			hours = theHours;
		}else{
			System.out.println("Fatal error: Negative hours!");
			System.exit(0);
		}
	}
	
	
	public double getWageRate(){
		return wageRate;
	}
	//hours worked - the number of hours worked
	public void setWageRate(double wageRate){
		if (wageRate >=0)
			hours = wageRate;
		else{
			System.out.println("Fatal error: Negative hours!");
			System.exit(0);
		}
	}
	public double getHours()
	{
		return hours;
	}
	
	public void setHours(double hours){
		if (hours >=0)
			this.hours = hours;
		else{
			System.out.println("Fatal error: Negative hours!");
			System.exit(0);
		}
	}
	public boolean equals (HourlyEmployee that){
		return (getName().equals(that.getName()))&&
				getHireDate().equals(that.getHireDate())&&
				wageRate == that.wageRate&&
				hours == that.hours;
	}
	public String toString(){
		return (getName() + " " + getHireDate().toString()+
				"\n$"+ wageRate+ " per hour for "+ hours+" hours.");
	}
}
