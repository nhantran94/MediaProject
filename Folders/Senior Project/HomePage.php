

<html>
<head>
<link href="Edits.css" type="text/css" rel="Stylesheet" />

<title>Degree Checklist</title>
<?php include 'header.php';?> 
</head>

<body>

<br>

</td>
</tr>

<tr>
<!-- ============ LEFT COLUMN (MENU) ============== -->
<td width="0%" valign="top">



</td>

<!-- ============ MIDDLE COLUMN (CONTENT) ============== -->
<td width="55%" valign="top" >

<h2>Page heading</h2>

<br>
A three column layout with header, navigation bar and footer sections. The first, second and fourth table rows create the header, navigation bar and footer respectively and contain a single table cell each. All these table cells use colspan="3" attribute-value pair. <br>
<br>

The third table row contains three table cells which create the menu column (left), the content column (middle) and the extra column (right).<br>
<br>
<select>
  <option value="#">--Undergraduate List--</option>
  <option value="#">Accounting</option>
  <option value="#">Applied Computer Science & Information System</option>
  <option value="#">Art & Design</option>
  <option value="#">Athletic Training</option>
  <option value="#">Biology</option>
  <option value="#">Business Administration</option>
  <option value="#">Chemistry</option>
  <option value="#">Criminal Justice</option>
  <option value="#">Disability Community Services</option>
  <option value="#">English</option>
  <option value="#">Foreign Language</option>
  <option value="#">Geology</option>
  <option value="#">Health & Physical Education</option>
  <option value="#">Health Science</option>
  <option value="#">Healthcare Professions</option>
  <option value="#">History</option>
  <option value="#">Interdisciplinary Studies</option>
  <option value="#">Mathematics</option>
  <option value="#">Middle Level Elementary Education</option>
  <option value="#">Music</option>
  <option value="#">Nanotechnology</option>
  <option value="#">Nursing BSN</option>
  <option value="#">Physics</option>
  <option value="#">Political Science</option>
  <option value="#">PreK -4/Early Childhood Education</option>
  <option value="#">PreK -4/Special Education</option>
  <option value="#">Phychology</option>
  <option value="#">Recreation Management</option>
  <option value="#">Secondary Education</option>
  <option value="#">Social Work</option>
  <option value="#">Special Education</option>
  <option value="#">Sport Administration</option>
  <option value="#">Studio Art</option>
  <option value="#">Sustainability Studies</option>
</select>
<br>


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
</td>
<!-- RIGHT COLUMN -->
<td width="25%" valign="top">&nbsp;</td>

</tr>

<!-- ============ FOOTER SECTION ============== -->
<tr><td colspan="3" align="center" height="20" >About</td></tr>
</table>
</body>

</html>
