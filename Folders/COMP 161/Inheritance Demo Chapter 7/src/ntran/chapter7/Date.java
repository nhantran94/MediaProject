package ntran.chapter7;

public class Date {
	private String month;
	private int day, year;

	
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getYear() {
		return year;
	}
	public boolean equals(Date other){
		return (year==other.year)&&(day==other.day)&&month.equals(other.month);
	}
	
	public String toString(){
		return month+ " "+day+ ", "+year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public Date(){
		month = "January";
		day = 1;
		year = 2016;
		
	}
	
	// deep copy
	public Date (String month, int day, int year){
		this.month = month;
		this.day = day;
		this.year = year;
	}

	public Date(Date hireDate){
		month = hireDate.month;
		day = hireDate.day;
		year = hireDate.year;
		
	}
}
