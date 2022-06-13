

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
url: 'updatecatajax.jsp',
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
                                                    <h3 class="tittle-w3l">Update Category
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
String cname="";
String cpic="";
String catid=request.getParameter("cid");

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
String q = "select * from categorytable where catid=?";
myst = myconn.prepareStatement(q);
myst.setString(1,request.getParameter("cid"));

ResultSet myres = myst.executeQuery();
if(myres.next())
{
cname = myres.getString("catname");
cpic = myres.getString("catimage");
}
else
{
out.print("Invalid Category ID");
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
<input type="text" placeholder="Category Name...." required=" " name="catname" value="<% out.print(cname); %>"><br/>
<input type="hidden" name="oldpic" value="<%out.print(cpic);%>">
<input type="hidden" name="catid" value="<%out.print(catid);%>">
<img src="upload/<%out.print(cpic);%>" width="75">
<input type="file" name="catpic">
<input type="submit" value="Update Category" name="s1">
<div id="msgdiv"></div>
</form>
</div>
</div>
</div> 
   </div></div>     
        
        
        <%@include file="footer.jsp" %>
    
    </body>
</html>
