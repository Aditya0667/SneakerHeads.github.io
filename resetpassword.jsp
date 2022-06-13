

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <%@include file="css.jsp" %>
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
						<h3 class="agileinfo_sign">Reset Password</h3>
						
                                                <form name="abc" method="post" id="loginform">
							<div class="styled-input agile-styled-input-top">
                                                            <input type="text"   name="vercode" placeholder="Verification code" required=""> <br>
							</div>
                                                    <div class="styled-input agile-styled-input-top">
                                                            <input type="password"   name="password" placeholder="Enter new password" required=""> <br>
							</div>
                                                    <div class="styled-input agile-styled-input-top">
                                                            <input type="password"   name="password1" placeholder="Confirm password" required=""> <br>
							</div>
                                                    <input type="submit" value="Reset" name="submit"> <br>
                                                    <a href="login.jsp">LOGIN NOW!!</a>
                                                <%
                                                    if(request.getParameter("submit")!=null)
                                                    {
                                                        if(request.getParameter("password").equals(request.getParameter("password1")))
                                                        {
                                                            try
                                                            {
                                                                 String path="jdbc:mysql://localhost/";
                                                                String place="shopping";
                                                                String uname="root";
                                                                String pass="";
                                                                Connection myconnection;
                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                myconnection=DriverManager.getConnection(path+place,uname,pass);
                                                                try
                                                                {
                                                                    String query="select * from usertable where vercode=? and username=?";
                                                                    PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                                    mystatement.setString(1,request.getParameter("vercode"));
                                                                    mystatement.setString(2,request.getParameter("Email"));
                                                                    
                                                                    ResultSet myresult=mystatement.executeQuery();
                                                                    
                                                                    if(myresult.next())
                                                                    {
                                                                     try
                                                                     {
                                                                         String query1="update usertable set password=? where username=?";
                                                                         PreparedStatement mystatement1=myconnection.prepareStatement(query1);
                                                                         mystatement1.setString(1,request.getParameter("password"));
                                                                         mystatement1.setString(2,request.getParameter("Email"));
                                                                         if(mystatement1.executeUpdate()>0)
                                                                         {
                                                                             response.sendRedirect("index.jsp");
                                                                         }
                                                                         else
                                                                         {
                                                                             out.print("does not work");
                                                                         }
                                                                     } //inner try
                                                                     catch(Exception e)
                                                                     {
                                                                         out.print("error occured in update query due to" + e.getMessage());
                                                                     }
                                                                    } //if
                                                                } //try
                                                                catch(Exception e)
                                                                {
                                                                    out.print("error occured in select query due to" + e.getMessage());
                                                                }
                                                            } //outer try
                                                            catch(Exception e)
                                                            {
                                                                out.print("error occured in connection" + e.getMessage());
                                                            }
                                                          }  
                                                            else
                                                           {
                                                            out.print("Passwords do not match");    
                                                           }
                                                    } //outer if
                             
                                                %>
                                                 </form>
                                        </div>
                                </div>
                        </div>
                                </div>
  
        <%@include file="footer.jsp" %>
    </body>
</html>
