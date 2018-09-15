/**
 * 
 */
package ntran.chapter7;

/**
 * @author ntt3013
 *
 */
public class SalariedEmployee extends Employee {
	private double salary;
	/**
	 * 
	 */
	public SalariedEmployee() {
		super();
		salary =0;
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param name
	 * @param hireDate
	 * @param salary 
	 */
	public SalariedEmployee(String name, Date hireDate, double salary) {
		super(name, hireDate);
		if (salary >= 0)
			this.salary = salary;
		else{
			System.out.println("Fatal error: Negative salary!");
			System.exit(0);
		}
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param that
	 */
	public SalariedEmployee(SalariedEmployee that) {
		super(that);
		salary = that.salary;
		
		// TODO Auto-generated constructor stub
	}


	/**
	 * @return the salary
	 */
	public double getPay(){
		return salary/12.0;
	}
	
	public double getSalary() {
		return salary;
	}

	/**
	 * @param salary the salary to set
	 */
	public void setSalary(double salary) {
		if (salary >=0)
		this.salary = salary;
		else{
			System.out.println("Fatal error: Negative salary!");
			System.exit(0);
		}
	}
		public String toString(){
			return getName()+" "+getHireDate()+
					"\n$" + salary+ " per year";
	}
		public boolean equals(SalariedEmployee that){
			return (getName().equals(that.getName())&&
					getHireDate().equals(that.getHireDate())&&
					salary == that.salary);
		}
}


