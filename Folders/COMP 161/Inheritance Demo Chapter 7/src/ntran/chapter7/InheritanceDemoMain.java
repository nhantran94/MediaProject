/**
 * 
 */
package ntran.chapter7;

/**
 * @author ntt3013
 *
 */
public class InheritanceDemoMain {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		HourlyEmployee joe = new HourlyEmployee("Joe Worker", new Date("January", 1, 2016), 50.50, 160);
		
		System.out.println("Changing Joe to Joesphine...");
		joe.setName("Joephine");
		System.out.println("Joe's record shows that his info is - ");
		System.out.println(joe);
		
		SalariedEmployee jane = new SalariedEmployee ("Jane Worker", new Date("February", 1, 2016), 50000);
		
		System.out.println(jane);
	}
	
}
