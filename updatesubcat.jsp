

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update SubCategory</title>
        <%@include file="css.jsp" %>
<script src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
$('#form1').submit(function (e) 
{
e.preventDefault();
var formData = new FormData($(this)[0]);
$.ajax(
{
type: 'post',
url: 'updatesubcatajax.jsp',
data: formData,
contentType: false,
cache: false,
processData: false,
beforeSend: function () 
{ 
$("#msgdiv").html("<img src='images/loading.gif'>"); 
},
success: function (reslt) 
{
$("#msgdiv").html(reslt); 
},
error: function(e) 
{
$('#msgdiv').html("Error in Ajax");
}
});
});
});
</script>
    </head>
    <body>
    <%@include file="headeradmin.jsp" %>
   
<div class="contact agileits">
				
					<div class="contact-form wthree">
						
                                                    <div class="row">
                                                    <h3 class="tittle-w3l">Update SubCategory
				<span class="heading-style">
					<i></i>
					<i></i>
					<i></i>
				</span>
			</h3>
                                                    </div>
<div class="login">
<div class="container"> 
<%
String scname="";
String scpic="";
String subcatid=request.getParameter("subcatid");
String path="jdbc:mysql://localhost/";
        String place="shopping";
        String uname="root";
        String pass="";

Class.forName("com.mysql.jdbc.Driver");
try
{
Connection myconn = DriverManager.getConnection(path+place,uname,pass);
try
{

PreparedStatement myst;
String q = "select * from subcategorytable where subcatid=?";
myst = myconn.prepareStatement(q);
myst.setString(1,request.getParameter("subcatid"));

ResultSet myres = myst.executeQuery();
if(myres.next())
{
scname = myres.getString("subcatname");
scpic = myres.getString("subcatimage");
}
else
{
out.print("Invalid SubCategory ID");
}


}
catch(Exception e)
{
out.print("Error in query");
}
finally
{
myconn.close();
}
} 
catch(Exception e)
{
out.print("<script>alert('Error in connection')</script>");
}
%>

<div class="login-form-grids animated wow slideInUp" data-wow-delay=".5s">
<form name="form1" method="post" id="form1" enctype="multipart/form-data">
<input type="text" placeholder="Category Name...." required="" name="scatname" value="<% out.print(scname); %>"> <br/>
<input type="hidden" name="oldpic" value="<%out.print(scpic);%>">
<input type="hidden" name="scatid" value="<%out.print(subcatid);%>">
<img src="upload/<%out.print(scpic);%>" width="75">
<input type="file" name="catpic">
<input type="submit" value="Update subCategory" name="s1">
<div id="msgdiv"></div>
</form>
</div>
</div>
</div> 
   </div></div>     
        
        
        <%@include file="footer.jsp" %>
    
    </body>
</html>
