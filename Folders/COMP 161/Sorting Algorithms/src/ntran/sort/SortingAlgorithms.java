package ntran.sort;

public class SortingAlgorithms 
{
	
	public static void swap(int src, int dst, int []array)
	{
		int tmp = array[src];
		array[src]=array[dst];
		array[dst]=tmp;
		return;
	}
	public static void printArray(int[]array)
	{
		for (int num:array)
			System.out.print(num+" ");
		System.out.println();
	}
	public static int findLocationOfSmallest(int start, int[]array)
	{
		int location = start;
		int min = array[location];
		for (int i = start; i<array.length;i++)
		{
			if (array [i]<min)
			{
				min = array[i];
				location=i;
			}
		}
		
		return location;
	}
	public static void sort(int[]array)
	{
		for (int i = 0; i <array.length;i++)
		{
			swap(findLocationOfSmallest(i, array),i,array);
		}
	}
	public static void main(String[] args) 		
	{
		int []array= {3445,3446,768,4354,6878,878,453,8,4,357,58,98,7};
		System.out.println("Before");
		printArray(array);
		sort(array);;
		System.out.println("After");
		printArray(array);
			
			// TODO Auto-generated method stub

	}

}
