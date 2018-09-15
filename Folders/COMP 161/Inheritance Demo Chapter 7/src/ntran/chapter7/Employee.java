package ntran.chapter7;

public class Employee 
{
	private String name;
	private Date hireDate;
	
	public Employee(){
		name = "No Name";
		hireDate = new Date("January 1",1,2000);
		
	}
	public Employee(String name, Date hireDate)
	{
		if (name == null || hireDate == null){
			System.out.println("Fatal error creating Employee object!");
			System.exit(0);
			
		}
		this.name = name;
		this.hireDate = hireDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		if (name == null){
			System.out.println("Fatal error setting name!");
			System.exit(0);
		}
		
	}
	public Date getHireDate() {
		return new Date(hireDate);
	}
	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}
	
	public boolean equals (Object other){
		if (other ==null)
			return false;
		if (this.getClass() != other.getClass())
			return false;
		Employee obj = (Employee) other;
		return name.equals(obj.name)&&hireDate.equals(obj.hireDate);
	}
	public boolean equalsIncorrect(Object other){
		if (other ==null)
			return false;
		if (!(other instanceof Employee))
			return false;
		Employee obj = (Employee) other;
		return name.equals(obj.name)&&hireDate.equals(obj.hireDate);
	}
	
	public String toString(){
		return name+ " "+ hireDate.toString();
	}
	public Employee(Employee that){
		name = that.name;
		hireDate = new Date(that.hireDate);
	}
}
