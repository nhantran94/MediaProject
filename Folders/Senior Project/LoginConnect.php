<?php
  
    

    // set the connection information
    //      willy is the server name on the penguin network
    //      set the UserName and Password to your credentials
    //      set the database to your username (the name of your
    //      database in willy).
$Server = "willy";
$UserName = "ntt3013";
$Password = "Temp!ntt3013";
$Database = "ntt3013";


    // connect to the database
    //      create a new instance of a mysqli object. this
    //      object contains the connection to the mysql server
    $Connection = new mysqli( $Server, $UserName, $Password, $Database );

    // check for a successful connection
    //      connect_error will evaluate to true if there is an error
    if ( $Connection->connect_error )
    {
        // stop the script and echo an error message
        echo "<h2>Database Error</h2>\n";
        die( "MySQLi Connection Error: ".$Connection->connect_error."\n" );
}
 
  
    $Connection->close();
?>
