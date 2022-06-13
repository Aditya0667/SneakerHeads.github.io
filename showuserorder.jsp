
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
		if(session.getAttribute("uname")!=null)
		{
          try
          {
                    String path="jdbc:mysql://localhost:3306/";
                    String place="shopping";
                    String uname="root";
                    String pass="";

                    Connection myconnection;
                    Class.forName("com.mysql.jdbc.Driver");
                    myconnection=DriverManager.getConnection(path+place,uname,pass);
          
          try
          {
              String query="select * from ordertable where uname=? ";
              PreparedStatement mystatement=myconnection.prepareStatement(query);
		mystatement.setString(1,session.getAttribute("uname").toString());
              ResultSet myresult=mystatement.executeQuery();
              if(myresult.next())
                      {
                         out.print("  <font color='red'> <h1>Cart</h1></font>" +
                          "<div.class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>Order id</th>" +
								"<th> Customer name</th>" +
								"<th> Email id</th>" +
								"<th>Phone no</th>" +

								"<th>Address</th>" +
								"<th>Total cost</th>" +
                                                               "<th> Order Status</th>" +
                                                                 
							"</tr>" +
						"</thead>");
                                          out.print("<tbody>");   
                                          do
                                          {
 out.print("<tr><td><a href='vieworderproduct.jsp?orderid=" 
         + myresult.getString("orderid")+ "'>"+myresult.getString("orderid")+"</a></td>"
                             
                             + "<td>" + myresult.getString("name") + "</td>"
                             + "<td>" + myresult.getString("email") + "</td>"
                             + "<td>" + myresult.getString("phno") + "</td>"
                             +"<td>" + myresult.getString("address")+"</td>"
                             +"<td>" + myresult.getString("tcost") +"</td>"
                                     +"<td><a href='viewuserorderstatus.jsp?orderid=" 
                                     + myresult.getString("orderid") + "'>" + "check status" + "</a></td>"
                                             
                            
                             + "</td></tr>");
                                                                 
                                          }
                                          while(myresult.next());
                                          out.print("</tbody></table>");

                      }
              else
              {
                  out.print("no products added yet");
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
		  else
		  {
		  response.sendRedirect("login.jsp");
		  }

        %>
        <%@include file="footer.jsp" %>
    </body>
</html>
