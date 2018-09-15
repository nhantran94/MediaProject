package ntran.first;

public class EnumDemo {
enum WorkDay
{
	MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY
}
	public static void main(String[] args) {
		final int SUNDAY = 200;
		// TODO Auto-generated method stub
		WorkDay startday = WorkDay.MONDAY;
		WorkDay enday = WorkDay.FRIDAY;
		WorkDay holiday = WorkDay.WEDNESDAY;
		
		WorkDay myday;
		
		myday=startday;
		
		System.out.println(startday);
		
		switch(myday){
		
		case MONDAY:
			//do something
			System.out.println("Yuck!");
			break;
		case TUESDAY:
			System.out.println("One more to go!");
			break;
		case WEDNESDAY:
			System.out.println("Yay!");
			break;
		default:
		
		
		}
	}

}
