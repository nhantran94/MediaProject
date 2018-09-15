package ntran.arraydemo;

public class RaggedArrays {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int [][] rectangular = new int [4][4];
		
		for (int i = 0; i <rectangular.length; i++){
			for (int j = 0; j < rectangular.length; j++ ){
				rectangular [i][j]=5;
				System.out.print(rectangular [i][j]+" ");
			}
			//done with one row
			System.out.println();
		}
	}

}
