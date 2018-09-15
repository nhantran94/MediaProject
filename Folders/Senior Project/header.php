<head>
<link href="Edits.css" type="text/css" rel="Stylesheet" />

<title>Degree Checklist</title>

</head>

<body>

<table cellpadding="10" cellspacing="0" border="0">
<tr>

<!-- ============ HEADER SECTION ============== -->
<td colspan="3" style="height: 100px;"><h1>Degree Checklist</h1></td></tr>


<!-- ============ NAVIGATION BAR SECTION ============== -->
<tr>
<td colspan="3" valign="middle" height="30" >
<ul>
<li><a href="HomePage.php">Home</a></li>
<li><a href="ACIS_Sheet.php">ACIS Sheet</a></li>
<li><a href="#">Menu link</a></li>
<li><a href="#">Menu link</a></li>
<li class="dropdown">
    <a href="javascript:void(0)" class="dropbtn" onclick="myFunction()">QuickLinks</a>
    <div class="dropdown-content" id="myDropdown">
    <a href="http://www.lhup.edu/">LHUP HomePage</a>
	<a href="https://lhu.desire2learn.com/d2l/home">D2L</a>
    <a href="https://myhaven.lhup.edu/ics">MyHaven</a>
    <a href="https://mail2.lhup.edu/owa/auth/logon.aspx?replaceCurrent=1&reason=3&url=https%3a%2f%2fmail2.lhup.edu%2fowa%2f">LHUP Emails</a>
	<li><a href="Logout.php">Logout</a></li>
</div>  
</li>  
</ul>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
  if (!e.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var d = 0; d < dropdowns.length; d++) {
      var openDropdown = dropdowns[d];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>
