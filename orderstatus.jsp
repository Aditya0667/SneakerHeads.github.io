
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Categories</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="headeradmin.jsp" %>
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
             String query="select * from orderstatustable";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 int counter=1;
                 out.print("<font color='red'> <h1 align='center'>Status Of Various Orders </h1></font>" +
                          "<div.class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th>Order Id</th>" +
								"<th>Status</th>" +
                                                                "<th>Courier No</th>" +
                                                                "<th>Courier Name</th>" +
							
								"<th>Update</th>" +
                                                                
							"</tr>" +
						"</thead>" + "</div>");
                 out.print("<tbody>");
                 do
                 {
                     out.print("<tr><td>" + counter + "</td>"
					 
					 
					  +"<td><a href='vieworderproduct.jsp?orderid="
					  + myresult.getString("orderid")+ "'>"+myresult.getString("orderid")+"</a></td>"
                                          + "<td>" + myresult.getString("status") + "</td>"
                                           + "<td>" + myresult.getString("courierno") + "</td>"
                                           + "<td>" + myresult.getString("couriername") + "</td>"
                            
                             + "<td><a href='updateorderstatus.jsp?orderid= " + myresult.getString("orderid") +"'> update </a></td>"
                             
                             + "</td></tr>");
                     counter++;
                             

                  }
                 while(myresult.next());
                 out.print("</tbody></table>");
             }
             else
             {
                 out.print("no orders yet");
                   
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
        
         
        <%@include file="footer.jsp" %>
        
        
        
    </body>
</html>
