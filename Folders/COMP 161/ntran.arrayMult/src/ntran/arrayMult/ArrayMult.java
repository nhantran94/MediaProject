package ntran.arrayMult;

public class ArrayMult
{
	public static void printArray(double[][]array){
		if (array ==null)
			return;
		for (int i = 0; i<array.length;i++){
			for (int j = 0; j<array.length; j++){
				System.out.println(array[i][j] +"\t");
			}
			System.out.println();
		}
		System.out.println("-----------");
	}
	public static double [][] mult (double[][] left, double[][] right){
		
		if(left == null || right == null	
		|| (left[0].length!= right.length))
			return null;
		double[][] result = new double[left.length][right[0].length];
		
		for (int i = 0; i < result.length;i++)
			for (int j = 0; j< result[0].length;j++){
				double sum = 0;
				for (int k = 0; k < result[0].length; k++){
						sum += left[i][k]*right[k][j];
					
				}
				result[i][j] = sum;
			}
		return result;
	}

public static void main (String[]args){
	double[][]left ={{1.0, 2.0},
			{3.0, 4.0}};
	double[][]right ={{10.0, 20.0}};
	printArray(left);
	printArray(right);
	printArray(mult(left,right));
	}

}
