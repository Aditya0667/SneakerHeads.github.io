

<%@page import="java.sql.*"%>
<%@page import="java.util.* "%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="css.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
						<h3 class="agileinfo_sign">Sign Up</h3>
						
						<form method="post">
							<div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="User Name(Email)" name="username" required="">
							</div>
							<div class="styled-input">
								<input type="password" placeholder="Password" name="password" required="">
							</div>
                                                    <div class="styled-input">
                                                        <input type="text" name="name" placeholder="name" required="">
                                                    </div>
                                                    <div class="styled-input">
                                                        
							<input type="submit" value="Sign Up" name="submit">
                                                        <%
                                                            if(request.getParameter("submit")!=null)
                                                            {
                                                                String path="jdbc:mysql://localhost/";
                                                                String place="shopping";
                                                                String uname="root";
                                                                String pass="";
                                                                 Random obj=new Random();
                                                                int vercode=obj.nextInt(1000);
                                                                try
                                                                {
                                                                    Connection myconnection;
                                                                    Class.forName("com.mysql.jdbc.Driver");
                                                                    myconnection=DriverManager.getConnection(path+place,uname,pass);
                                                                    try
                                                                    {
                                                                        String query="insert into usertable values(?,?,?,?)";
                                                                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                                        mystatement.setString(1, request.getParameter("username"));
                                                                        mystatement.setString(2,request.getParameter("password"));
                                                                        mystatement.setString(3, request.getParameter("name"));
                                                                        mystatement.setInt(4,vercode);
                                                                        if(mystatement.executeUpdate()>0)
                                                                        {
                                                                            out.print("sign up done successfully");
                                                                            
                                                                        }
                                                                        else
                                                                        {
                                                                            out.print("sign up not successful");
                                                                            
                                                                        }
                                                                    }
                                                                    catch(Exception e)
                                                                    {
                                                                        out.print("error occuredin query due to" + e.getMessage());
                                                                        
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
						</form>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<!-- //Modal content-->
            
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
