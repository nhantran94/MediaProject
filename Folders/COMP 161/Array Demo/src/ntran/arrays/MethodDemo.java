package ntran.arrays;

public class MethodDemo 
{
	public static void printArray(int[]array)
	{
		for (int i =0; i<array.length;i++)
			System.out.print(array[i]+"\t");
		System.out.println();
	}
	public static void initArray(int[] array){
		if (array == null)
			return;
		for (int i = 0; i<array.length;i++)
		{
			array[i]=10;
		}
	}
	public static int[] doubleArray(int[]arr)
	{
		int [] result = new int[arr.length*2];
		initArray(result);
		for (int i = 0; i<arr.length;i++)
			result[i]= arr[i];
		return result;
	}
	public static void main (String[]args)
	{
		int[]arr = new int[10];
		initArray(arr);
		System.out.println("Before expanding...");
		printArray(arr);
		arr = doubleArray(arr);
		System.out.println("After expanding...");
		printArray(arr);
	}

}
