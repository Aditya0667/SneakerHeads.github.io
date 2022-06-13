

<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="css.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="container">
            <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
					<div class="modal_body_left modal_body_left1">
						<h3 class="agileinfo_sign">Sign In</h3>
						
						<form method="post">
							<div class="styled-input agile-styled-input-top">
			                                <input type="text" placeholder="User Name(Email)" name="username" required="">
							</div>
							<div class="styled-input">
								<input type="password" placeholder="Password" name="password" required="">
							</div>
                                                   
                                                    <div class="styled-input">
                                                        
                                                     <input type="submit" value="Sign In" name="submit">
                                                    <div class="styled-input agile-styled-input-top">
                                                        
                                                             <!--<a href="forgotpassword.jsp">Forgot password</a>-->
                                                        
							</div>


<%
 
if(request.getParameter("username")!=null && request.getParameter("password")!=null)
 {
 String path="jdbc:mysql://localhost/";
 String place="shopping";
 String uname="root";
 String pass="";
 try
  {
  Connection myconnection;
 Class.forName("com.mysql.jdbc.Driver");
 myconnection=DriverManager.getConnection(path+place,uname,pass);
   try
   {
   String query="select * from usertable where username=? " + " and password=? ";
   PreparedStatement mystatement=myconnection.prepareStatement(query);
   mystatement.setString(1, request.getParameter("username"));
 mystatement.setString(2,request.getParameter("password"));
ResultSet myresult=mystatement.executeQuery();

String query1="select * from atable where username=? " + "and password=?";
PreparedStatement mystatement1 = myconnection.prepareStatement(query1);
mystatement1.setString(1,request.getParameter("username"));
mystatement1.setString(2, request.getParameter("password"));
ResultSet myresult1=mystatement1.executeQuery();
if(myresult.next())
{
session.setAttribute("name", myresult.getString("name"));
session.setAttribute("uname", myresult.getString("username"));
response.sendRedirect("index.jsp");
}
else if(myresult1.next())
{
    session.setAttribute("aname", myresult1.getString("username"));
response.sendRedirect("adminpanel.jsp");
}
else
{
    out.print("wrong username/password");
}
   }
catch(Exception e)
 {
 out.print("error occured in query due to" + e.getMessage());
                                                                        
 }
 finally
  {
  myconnection.close();
                                                                        
  }
  }
 catch(Exception e)
  {
 out.print("error occured in connection due to" + e.getMessage());
  }
                                                            
 }
 %>
						
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
                                                </form>
				</div>
			</div>
			<!-- //Modal content-->
            
        </div>
        <%@include file="footer.jsp" %>
        </div>
   </body>
</html>
