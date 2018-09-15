package ntran.arrays;

public class ExerciseException extends Exception{
    
    /**
     * Exercise Exception Class
     */

    public ExerciseException() {
        super("Exercise Exception thrown!");
        System.out.println("Exception thrown.");
    }
    
    public ExerciseException(String message) {
        super(message);
        System.out.println("Exercise Exception invoked with an argument.");
        
    }
    
}