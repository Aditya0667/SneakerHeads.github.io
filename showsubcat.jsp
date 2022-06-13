

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="imp.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show subcategory</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
                
      <div class="ads-grid">
            <div class="container">
                <h3 class="tittle-w3l">subcategories
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
             String query="select * from subcategorytable where catid=?";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             mystatement.setString(1,request.getParameter("catid"));
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 out.print("<div class='row'>");
                 do
                 {
                     out.print("<div class='col-md-4' align='center'>"
                             + "<a href='showproduct.jsp?subcatid="+myresult.getString("subcatid")+"'>"
                                     + "<img src='upload/"+myresult.getString("subcatimage")+"' height='200px' width='200px'></a>"
                                             + "<br/><a href='showproduct.jsp?subcatid="+myresult.getString("subcatid")+"'>"+myresult.getString("subcatname")+"</div>");
                 }
                 while(myresult.next());
                 out.print("</div>");
             }
             else
             {
                 out.print("no subcategory added yet");
                   
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
