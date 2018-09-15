package ntran.nuances;

public class Main {

	public static void main (String[] args)
	{
		ClassA a = new ClassA();
		ClassB b = new ClassB();
		ClassA tmp = (ClassA) b;
		
		a.staticMethod();
		b.staticMethod();
		
		tmp.staticMethod();
		tmp.instanceMethod();
	}

}
