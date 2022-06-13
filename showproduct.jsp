

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="imp.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
      
     <div class="ads-grid">
            <div class="container">
                <h3 class="tittle-w3l"> Products
				<span class="heading-style">
					<i></i>
					<i></i>
					<i></i>
				</span>
			</h3>
                <%
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
             String query="select * from producttable where subcatid=?";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             mystatement.setString(1,request.getParameter("subcatid"));
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 out.print("<div class='row'>");
                 do
                 {
                     out.print("<div class='col-md-4' align='center'>"
                             + "<a href='productdetails.jsp?productid="+myresult.getString("productid")+"'>"
                                     + "<img src='upload/"+myresult.getString("productimage")+"'height='200px' width='200px'></a>"
                                             + "<br/><a href=productdetails.jsp?productid="+myresult.getString("productid")+"'>"+myresult.getString("productname")+"</div>");
                 }
                 while(myresult.next());
                 out.print("</div>");
             }
             else
             {
                 out.print("no product added yet");
                   
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
                    %>
             
             
            </div>
                
            </div>
        

        
        
        
        <%@include file="footer.jsp" %>
    </body>
</html>
