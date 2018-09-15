package ntran.arrays;
import java.lang.reflect.Array;

public class ArrayDemo {


public static boolean equalsArray(int[]a, int[]b){
	if (a==b)
		return true;
	if (a.length != b.length)
		return false;
	//check if each item in array a is equal to the item in array b
	//using a loop of some sort
	//if you see one that doesn't match return a false
	for (int i = 0; i<a.length;i++){
		if (a[i]!= b[i]);
	return false;
	
	}
	return true;
	}
}
