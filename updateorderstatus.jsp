

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
    </head>
    <body>
    <%@include file="headeradmin.jsp" %>
   
<div class="contact agileits">
				
					<div class="contact-form wthree">
						
                                                    <div class="row">
                                                    <h3 class="tittle-w3l">Update Order Status
				<span class="heading-style">
					<i></i>
					<i></i>
					<i></i>
				</span>
			</h3>
                                                    </div>
                                       
<div class="login">
<div class="col-md-12"> 
<%
String cstatus="";
String ccourierno="";
String ccouriername="";

String orderid=request.getParameter("orderid");


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
String q = "select * from orderstatustable where orderid=?";
myst = myconn.prepareStatement(q);
myst.setString(1,request.getParameter("orderid"));

ResultSet myres = myst.executeQuery();
if(myres.next())
{
cstatus = myres.getString("status");
ccourierno = myres.getString("courierno");
ccouriername = myres.getString("couriername");
}
else
{
out.print("Invalid order ID");
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

<div class="modal_body_left modal_body_left1" data-wow-delay=".5s">
<form name="form1" method="post" >
    <select name="statusname" id="statusbox" > 
    <option value="ordered"> Order Received</option>
    <option value="approved">  Approved </option>
    <option value="packed"> Packed </option>
    <option value="shipped"> Shipped </option>
    <option value="delivered"> Delivered </option>
    <option value="delayed"> Delayed </option>
    </select>
<!--<input type="text"  required=" " name="cstatus" value="<% out.print(cstatus); %>"><br/>-->
<input type="text" name="cnumber" placeholder="Courier Number" value="<%out.print(ccourierno);%>">
<input type="text" name="cname" placeholder="Courier Name" value="<%out.print(ccouriername);%>">
<input type="submit" value="Update Status" name="s1">
<div id="msgdiv"></div>
<%
if(request.getParameter("s1")!=null)
{
Class.forName("com.mysql.jdbc.Driver");
try
{
Connection myconn = DriverManager.getConnection(path+place,uname,pass);
try
{
   
String q = "update orderstatustable set status=?,courierno=?,couriername=?where orderid=?";
PreparedStatement myst = myconn.prepareStatement(q);
String statusname;
    if(request.getParameter("statusname").equals("ordered"))
	{
		statusname="order_Received";
	}
    else  if(request.getParameter("statusname").equals("approved"))
	{
		statusname="approved";
	}
	else if(request.getParameter("statusname").equals("packed"))
	{
	    	statusname="packed";
	}
	else if(request.getParameter("statusname").equals("shipped"))
	{
	     statusname="shipped";	
	}	 
	 else if(request.getParameter("statusname").equals("delivered"))
	{
	     statusname="delivered";	
	}
else if(request.getParameter("statusname").equals("delayed"))
	{
	     statusname="delayed";	
	}
 myst.setString(1,request.getParameter("statusname"));
myst.setString(2, request.getParameter("cnumber"));
myst.setString(3, request.getParameter("cname"));
myst.setString(4, request.getParameter("orderid"));
int myres = myst.executeUpdate();
if(myres>0)
{
out.print("Status updated successfully");
}
else
{
out.print("Status not updated successfully");
}
}
catch(Exception e)
{
out.print("Error in query" + e.getMessage());
}
finally
{
myconn.close();
}
} 
catch(Exception e)
{
out.print("Error in connection" + e.getMessage());
}



}



%>






</form>
</div>
</div>
<div class="clearfix"></div>
</div> 
    </div>  
</div>  
        
        <%@include file="footer.jsp" %>
    
    </body>
</html>
