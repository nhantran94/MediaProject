package ntt3013.myException;

import java.util.InputMismatchException;
import java.util.Scanner;

public class MyException {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
 
		int n1, n2;
		double r = 0;
		boolean finished = false;
 
		do{
			try{
				System.out.println("Please input the numerator. ");
				n1 = scan.nextInt();
 
				System.out.println("Please input the denominator. ");
				n2 = scan.nextInt();
 
				if (n2 == 0)
					throw new DivisionByZeroException("Denominator cannot be zero!");
 
				r = (double) n1/n2;
				System.out.println("r = " + r);
				finished = true;
			}	catch(DivisionByZeroException e){
				System.out.println(e.getMessage());
				System.out.println("Please retry.");
				scan.nextLine();
			}catch(InputMismatchException e){
				System.out.println("Only enter numbers!");
				System.out.println("Please retry.");
				scan.nextLine();
			}catch(Exception e){
				System.out.println("General Exception!");
				System.out.println("Please retry.");
				scan.nextLine();
			}
		}while (!finished);
 
		scan.close();
 

	}

}