

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="imp.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout page</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        
        <div class="container">
            <%@include file="header.jsp" %>
             <form name="abc" method="post">
            <div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
					<div class="modal_body_left modal_body_left1">
						<h3 class="agileinfo_sign">Checkout</h3>
                                               
                                         <div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="Name" name="name" required="">
							</div>
                                                    <div class="styled-input agile-styled-input-top">
                                                        <input type="text" name="email" placeholder="Email id" required=""> <br>
                                                        
                                                    </div>
                                                    
							<div class="styled-input">
			<input type="text" placeholder="Phoneno." name="phoneno." required="">
							</div>
                                                    <div class="styled-input">
                                                    
                                                        <textarea name="add" placeholder="Address" class="form-control"></textarea> <br>
                                                    </div>
                                                <div>
                                                    <h2 style="color:red"> Payment mode is cash on delivery!!</h2>
                                                </div>
                                      
                                       <div class="styled-input">
                                           
                                                        
<input type="submit" value="Proceed" name="submit">
<%
    if(request.getParameter("submit")!=null)
        
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
    String query="insert into ordertable(name,email,phno,address,uname,tcost)values(?,?,?,?,?,?)";
    PreparedStatement mystatement=myconnection.prepareStatement(query);
    mystatement.setString(1,request.getParameter("name"));
    mystatement.setString(2,request.getParameter("email"));
    mystatement.setString(3,request.getParameter("phoneno."));
    mystatement.setString(4,request.getParameter("add"));
    mystatement.setString(5,session.getAttribute("uname").toString());
    mystatement.setString(6,session.getAttribute("tcost").toString());
            
    if(mystatement.executeUpdate()>0)
    {
        
        response.sendRedirect("thanks.jsp");
    }
    else
    {
        out.print("error");
    }
    
}
            catch(Exception e)
            {
                out.print("error in query due to" + e.getMessage());
            }
            finally
            {
                myconnection.close();
            }
            
        }
        catch(Exception e)
        {
            out.print("error in connection due to" + e.getMessage());
        }
    }
    
%>
      
                                                
            
            
        </div>
      </div>
       </div>
        </div>
        
             </form>
        <%@include file="footer.jsp" %>
        
   
        </body>
</html>
