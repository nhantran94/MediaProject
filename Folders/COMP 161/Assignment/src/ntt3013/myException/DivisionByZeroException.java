package ntt3013.myException;

public class DivisionByZeroException extends Exception {
    
    public DivisionByZeroException(){
        super ("DivisonByZeroExcpetion");
    }

    public DivisionByZeroException(String message){
        super ("" + message);
    }
}