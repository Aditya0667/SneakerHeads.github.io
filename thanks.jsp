
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int orderid=0,tcost=0,pid1=0;
    String address="";
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
             String query="select * from ordertable where uname=? order by orderid desc";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             mystatement.setString(1,session.getAttribute("uname").toString());
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 orderid=Integer.parseInt(myresult.getString("orderid"));
                 tcost=Integer.parseInt(myresult.getString("tcost"));
                 address=myresult.getString("address");
                 try
                 {
                     String query1="select * from cart where uname=?";
                     PreparedStatement mystatement1=myconnection.prepareStatement(query1);
                     mystatement1.setString(1, session.getAttribute("uname").toString());
                     ResultSet myresult1=mystatement1.executeQuery();
                     if(myresult1.next())
                     {
                         pid1=Integer.parseInt(myresult1.getString("productid"));
                         do
                         {
                             
                             String query2="insert into orderhistory(orderid,productid,pname,image,price,qty,tcost)values(?,?,?,?,?,?,?)";
                             PreparedStatement mystatement2=myconnection.prepareStatement(query2);
                             mystatement2.setString(1,String.valueOf(orderid));
                             mystatement2.setInt(2,pid1);
                             mystatement2.setString(3,myresult1.getString("pname"));
                             mystatement2.setString(4,myresult1.getString("image"));
                             mystatement2.setString(5,myresult1.getString("price"));
                             mystatement2.setString(6,myresult1.getString("qty"));
                             mystatement2.setString(7,myresult1.getString("tcost"));
                             mystatement2.executeUpdate();
                         }
                         while(myresult1.next());
                         String query3="delete from cart where uname=?";
                         PreparedStatement mystatement3=myconnection.prepareStatement(query3);
                         mystatement3.setString(1,session.getAttribute("uname").toString());
                         mystatement3.executeUpdate();
                         
                         
                         String query5="update producttable set quantity=quantity-? where productid=?";
                         PreparedStatement mystatement5=myconnection.prepareStatement(query5);
                         mystatement5.setString(1,session.getAttribute("requiredqty").toString());
                         mystatement5.setString(2,session.getAttribute("requiredpid").toString());
                         mystatement5.executeUpdate();
                         
                         String query6="insert into orderstatustable(orderid,status,courierno,couriername) values(?,?,?,?)";
                         PreparedStatement mystatement6=myconnection.prepareStatement(query6);
                         mystatement6.setString(1,String.valueOf(orderid));
                         mystatement6.setString(2,"order received");
                          mystatement6.setString(3,"0");
                           mystatement6.setString(4,"0");
                         mystatement6.executeUpdate();
                         
                         
                     }
                 }
                 catch(Exception e)
                 {
                     out.print("error occued due to" + e.getMessage());
                 }
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanks</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h3> Thanks for shopping with us </h3>
            <h3> Your order is successfully placed</h3>
            <h4> Order details are as followed </h4>
            <h4> Order id: <% out.print(orderid); %></h4>
            <h4> Final cost: <%out.print("Rs" +tcost+ "/-");%></h4>
            <h4> Delivery Address: <%out.print(address);%></h4>
            <h4>Mode of payment:COD(Cash on Delivery)</h4>
            <h4> It will reach your place in a week or so</h4>
            <h4> Product Details:</h4>
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
                        String query="select * from orderhistory where orderid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,String.valueOf(orderid));
                        ResultSet myresult=mystatement.executeQuery();
                        if(myresult.next())
                        {
                            int counter=1;
                            out.print("<font color='red'><h1>List of products </h1></font>" +
                          "<div class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th> Image</th>" +
								"<th> Name</th>" +
								"<th>Price</th>" +

								"<th>Quantity</th>" +
                                    "<th> Total cost</th>" +
								
							"</tr>" +
						"</thead>" + "</div>");
                 out.print("<tbody>");
                 do
                 {
                 out.print("<tr><td>" + counter + "</td>"
                             + "<td><img src='upload/" + myresult.getString("image") + "'width=100px</td>"
                             + "<td>" + myresult.getString("pname") + "</td>"
                             + "<td>" + myresult.getString("Price") + "</td>"
                             + "<td>" + myresult.getString("qty") + "</td>"
                             +"<td>" + myresult.getString("tcost")+"</td>"
                         
                            + "</td></tr>");
                     counter++;
                            
                                                                                         
                     
                 }
                        while(myresult.next());
                            out.print("</tbody></table>");
                                    
                        }
                        else
                        {
                            out.println("no product");
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
    
        <%@include file="footer.jsp" %>
    </body>
</html>
