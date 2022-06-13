

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("uname")==null && session.getAttribute("aname")==null)
    {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change password</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <div class="container">
        
            <%
                if(session.getAttribute("uname")==null)
                {
             %>  
             <%@include file="header.jsp" %>
             <%
                }
else if(session.getAttribute("aname")==null)
{
%>
<%@include file="headeradmin.jsp" %>
<%
}
%>

<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
					<div class="modal_body_left modal_body_left1">
						<h3 class="agileinfo_sign">Change password</h3>
						
                                                <form action="#" method="post" id="login-form">
							<div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="current password" name="curpass" required="">
							</div>
                                                    <div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="New password" name="newpass" required="">
							</div>
                                                    
                                                    <div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="Confirm password" name="conpass" required="">
							</div>
                                                    <div class="styled-input agile-styled-input-top">
                                                        <ul>
                                                            <!-- <li> <a href="forgotpassword.jsp">Forgot password</a></li>--> 
                                                        </ul>
							</div>


						
                                                        
                                                   
                                                    
                                                        
                                                    <input type="submit" value="submit" name="submit"> 
                                                    
                     <%
                         if(request.getParameter("submit")!=null)
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
                                      String query="";
                                      PreparedStatement mystatement;
                                      if(session.getAttribute("uname")!=null)
                                      {
                                          query="update usertable set password=? where username=? and password=?";
                                          mystatement=myconnection.prepareStatement(query);
                                          mystatement.setString(1,request.getParameter("newpass"));
                                          mystatement.setString(2,session.getAttribute("uname").toString());
                                          mystatement.setString(3,request.getParameter("curpass"));
                                          
                                      }
                                      else
                                      {
                                          query="update atable set password=? where username=? and password=?";
                                          mystatement=myconnection.prepareStatement(query);
                                          mystatement.setString(1,request.getParameter("newpass"));
                                          mystatement.setString(2,session.getAttribute("aname").toString());
                                          mystatement.setString(3,request.getParameter("curpass"));
                                                  
                                      }
                                      if(mystatement.executeUpdate()>0)
                                      {
                                          out.print("password changed");
                                      }
                                      else
                                      {
                                          out.print("incorrect password");
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
                     <div id="message"> </div>
                                                </form>
                     <p> Don't have an account? <a href ="signup.jsp"> Sign up now!</a></p>
                                                   
                                        </div>

                                </div>

</div>
        </div>

        
       
        <%@include file="footer.jsp" %>
    </body>
</html>
