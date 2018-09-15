package ntran.arrays;

public class ForEachDemo {

	public static void doubleArray(int[]arr) {
		// TODO Auto-generated method stub\
		for (int i = 0; i<arr.length;i++)
			arr[i] *=2;
	}
	public static void printArray(int[]arr){
		
		//the simple for the loop
		for (int i = 0; i < arr.length;i++)
			System.out.println(arr[i]+ " ");
		
		System.out.println();
		//the for-each loop
		
		for(int i :arr)
			System.out.print(i+ " ");

		System.out.println();
	}
	
	public static void main(String []args)
	{
		int[]arr={7,6,5,4,3,2,1};
		printArray(arr);
		doubleArray(arr);
		printArray(arr);
	}

}
