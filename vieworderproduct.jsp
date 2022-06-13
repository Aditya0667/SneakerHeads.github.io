

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of items</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="headeradmin.jsp" %>
        <%
            int tcost=0;
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
                        String query="select * from orderhistory where orderid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,request.getParameter("orderid"));
                        ResultSet myresult=mystatement.executeQuery();
                        if(myresult.next())
                        {
                           out.print(
                           " <font color='red'> <h1>Cart</h1></font>" +
                          "<div class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>Product image</th>" +
								"<th>Product name</th>" +
								"<th>Price</th>" +
								"<th>Quantity</th>" +

								"<th>Total cost</th>" +
                                                                 
							"</tr>" +
						"</thead>");
                                          out.print("<tbody>");
                                          do
                                          {
                                              tcost+=myresult.getInt("tcost");
                                              out.print("<tr><td><img src='upload/"+ myresult.getString("image") + "'width='90px'>" + "</td>"
                             
                             + "<td>" + myresult.getString("pname") + "</td>"
                             + "<td>" + myresult.getString("price") + "</td>"
                             + "<td>" + myresult.getString("qty") + "</td>"
                             
                            +"<td>" + myresult.getString("tcost") +"</td>"
                            
                             + "</td></tr>");
                                          }
                                          while(myresult.next());
                                          out.print("</tbody></table>");
                        }
                        else
                        {
                            out.print("No products added yet");
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
                    if(tcost>0)
                    {
                        out.print("<h2>Final cost:" + tcost + "/-</h2>");
                    }
        
        
        
        
        
        %>
        
        <%@include file="footer.jsp" %>
    </body>
</html>
