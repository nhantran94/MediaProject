<?php
   include("LoginConnect.php");
   session_start();
   
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      
      $myusername = mysqli_real_escape_string($db,$_POST['username']);
      $mypassword = mysqli_real_escape_string($db,$_POST['password']); 
      
      $sql = "SELECT userName AND pass FROM UserName WHERE userName = '$myusername' and pass = '$mypassword'";
      $result = mysqli_query($db,$sql);
      $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
      $active = $row['active'];
      
      $count = mysqli_num_rows($result);
      
      // If result matched $myusername and $mypassword, table row must be 1 row
		
      if($count == 1) {
         session_register("myusername");
         $_SESSION['login_user'] = $myusername;
         
         header("location: HomePage.php");
      }else {
         $error = "Your Login Name or Password is invalid";
      }
   }
?>


<html >
<head>
  <meta charset="UTF-8">
  <title>Senior Project</title>
  
  
  
      <link rel="stylesheet" href="Login.css">

  
</head>

<body>
  <div class="login-page">
  <div class="form">
  <img src="lhuplogo.jpg" alt="Avatar" class="avatar">
    <form class="register-form">
      <input type="text" placeholder="name"/required>
      <input type="password" placeholder="password"/ required>
      <input type="text" placeholder="email address"/required>
      <button>create</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
	 
    </form method="POST">
	
    <form class="login-form" action="HomePage.php" method="post" >
      <input type="text" placeholder="username"/ required>
      <input type="password" placeholder="password"/ required>
      <button>login</button>
      <p class="message">Not registered? <a href="#">Create an account</a></p>
    </form>
  </div>
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script src="Login.js"></script>

</body>
</html>
