package ntran.first;

public class OneDim {

	public static void printArray (int[] arr)
{
	for( int i = 0; i <arr.length;i++){
		System.out.print (arr[i]+" ");
	}
	System.out.println();
}
	
	public static <MyClass> void main(String[]args)
	{
		// TODO Auto-generated method stub
		int[] even = new int[10];
		int []myarray= new int[10];
		for (int i = 0; i < even.length; i++)
		{
			even [i]= (i+1) *2;
			myarray[i] = even[1];
			
		}
		if (even == myarray)
			System.out.println("They are equal");
		else
			System.out.println("They arrays are different");
		int [] odd = new int [10];
		
		for (int i = 0; i < odd.length; i++)
		{
			odd [i]= (2 * i) +1;
		}
		printArray(even);
		printArray(odd);
		char [] mesg = {'H','e', 'l', 'l', 'o', };
		System.out.println(mesg);
		String str = new String(mesg);
		String str2 = new String(mesg, 3, 2);
		System.out.println(str2);
		
		OneDim[] classArray = new OneDim[10];
		for (int i = 0; i <classArray.length; i++){
			classArray[i] = new OneDim();
		}
	}

}
