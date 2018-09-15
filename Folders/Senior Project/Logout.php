<html >
<head>
  <meta charset="UTF-8">
  <title>Senior Project</title>
      <link rel="stylesheet" href="Login.css">

  
</head>

<body>

<h1> You have Succesfully Logout!

</h1>
  <div class="login-page">
  <div class="form">
  <img src="lhuplogo.jpg" alt="Avatar" class="avatar">
    <form class="register-form">
      <input type="text" placeholder="name"/required>
      <input type="password" placeholder="password"/ required>
      <input type="text" placeholder="email address"/required>
      <button>create</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
    <form class="login-form" action = "HomePage.php" method="post" >
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