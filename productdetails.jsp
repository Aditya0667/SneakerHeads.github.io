


        
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="imp.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product details</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            String pid1="", pname1="",price1="",pimage1="",qty1="";
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
    String query="select * from producttable where productid=? ";
    PreparedStatement mystatement=myconnection.prepareStatement(query);
    mystatement.setString(1,request.getParameter("productid"));
    ResultSet myresult=mystatement.executeQuery();
    if(myresult.next())
    {
        pid1=myresult.getString("productid");
        pname1=myresult.getString("productname");
        price1=myresult.getString("price");
        pimage1=myresult.getString("productimage");
        qty1=myresult.getString("quantity");
        
    }
    else
    {
        out.print("<h3> Product details could not be fetched </h3>");
                
    }
            
       
}
           catch(Exception e)
           {
             out.print("error occured in query due to" + e.getMessage()) ; 
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
            
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <% out.print("<img src='upload/" + pimage1 + "'width=300px height=300px>"); %>
                    </div>
                    <div class="col-md-6">
                        <h2> <%=pname1%> </h2> <br>
                        <b> Price: </b> <%=price1%> <br>
                        <b> Quantity: </b> <%=qty1%>
                        <form name="abc" method="post">
                            <select name="qty">
                                <%
                                    for(int x=1;x<=Integer.parseInt(qty1);x++)
                                    {
                                        out.print("<option>" + x + "</option>");
                                    }
                                %>
                            </select> <br>
                            
                            <a href="showcart.jsp"><input type="submit" name="submit" value="Add to cart"></a>
                            <%
                                if(request.getParameter("submit")!=null)
                                {
                                    if(session.getAttribute("uname")!=null)
                                    {
                                        int price,qty,tcost;
                                        price=Integer.parseInt(price1);
                                        qty=Integer.parseInt(request.getParameter("qty"));
                                        tcost=price*qty;
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
                                                    String q1="select * from cart where productid=? and uname=?";
                                                    PreparedStatement mystatement1=myconnection.prepareStatement(q1);
                                                    mystatement1.setString(1,pid1);
                                                    mystatement1.setString(2,session.getAttribute("uname").toString() );
                                                    ResultSet myres=mystatement1.executeQuery();
                                                    if(myres.next())
                                                    {
                                                        String query="update cart set qty=qty+?,tcost=tcost+? where productid=? and uname=?";
                                                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                        mystatement.setInt(1,qty);
                                                        mystatement.setInt(2,tcost);
                                                        mystatement.setString(3,pid1);
                                                        mystatement.setString(4, session.getAttribute("uname").toString());
                                                        if(mystatement.executeUpdate()>0)
                                                        {
                                                            response.sendRedirect("showcart.jsp");
                                                        }
                                                        else
                                                        {
                                                            out.print("cannot update");
                                                        }
                                                    }
                                                    else
                                                    {
                                                        String query="insert into cart(productid,pname,image,price,qty,tcost,uname) "
                                                                + "values(?,?,?,?,?,?,?)";
                                                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                        mystatement.setString(1,pid1);
                                                        session.setAttribute("requiredpid",pid1);
                                                        mystatement.setString(2,pname1);
                                                        mystatement.setString(3,pimage1);
                                                        mystatement.setInt(4,price);
                                                        mystatement.setInt(5,qty);
                                                        session.setAttribute("requiredqty",qty);
                                                        mystatement.setInt(6, tcost);
                                                        mystatement.setString(7, session.getAttribute("uname").toString());
                                                        
                                                        if(mystatement.executeUpdate()>0)
                                                        {
                                                            response.sendRedirect("showcart.jsp");
                                                        }
                                                        else
                                                        {
                                                            out.print("error");
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
                                            out.print("error in connection due to" + e.getMessage());
                                        }
                                    }
                                    else
                                    {
                                        response.sendRedirect("login.jsp");
                                    }
                                }
                                %>
                        </form>
                        
                    </div>
                </div>
            </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
