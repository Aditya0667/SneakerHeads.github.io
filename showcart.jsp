

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(request.getParameter("submit1")!=null)
    {
        response.sendRedirect("index.jsp");
    }
    else if(request.getParameter("submit2")!=null)
    {
        response.sendRedirect("checkout.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show cart</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <form name="form1" method="post">
                <%
                    String finalcost="";
                    int flag=1;
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
                                                    String query="select * from cart where uname=?";
                                                    PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                    mystatement.setString(1,session.getAttribute("uname").toString());
                                                    ResultSet myresult=mystatement.executeQuery();
                                                    if(myresult.next())
                                                    {
                                                        flag=0;
                                                        int counter=1;
                                                         out.print("<font color='red'> <h1>Cart</h1></font>" +
                          "<div class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th> Image</th>" +
								"<th> Name</th>" +
								"<th>Quantity</th>" +

								"<th>Price</th>" +
								"<th>Total cost</th>" +
                                                                "<th>Delete</th>" +
							"</tr>" +
						"</thead>");
                                          out.print("<tbody>");
                                                        do
                                                        {
                                                             out.print("<tr><td>" + counter + "</td>"
                             + "<td><img src='upload/" + myresult.getString("image") + "'width=100px</td>"
                             + "<td>" + myresult.getString("pname") + "</td>"
                             + "<td>" + myresult.getString("qty") + "</td>"
                             + "<td>" + myresult.getString("price") + "</td>"
                             +"<td>" + myresult.getString("tcost")+"</td>"
                             
                             + "<td><a href='#' class='todelete'productid=" + myresult.getString("cartid") +"'> Delete </a></td>"
                             + "</td></tr>");
                                 counter++;                                                            
                                                       
                                                        }
                                                        
                                                        while(myresult.next());
                                                                
                                                               out.print("</div></tbody></table>");  
                                                                }
                                                    else
                                                    {
                                                        out.print("<font color='red'> Cart is empty </font>");
                                                                                                                          
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
                    if(flag==0)
                    {
                        out.print("<h2><div id='msg1'> Final cost: Rs" + finalcost + "</div></h2>");
                    }
                                       
                            
                %>
                <table>
                    <tr>
                        <td><input type="submit" name="submit1" value="continue shopping"></td>
                        <td><input type="submit" name="submit2" value="checkout"></td>
                    </tr>
                </table>
            </form>
        </div>
        <%@include file="footer.jsp" %>
        <script>
            
            $(document).ready(function(){
                calculatetotal();
                $(".todelete").click(function(e){
                    e.preventDefault();
                    if(confirm("Do you really want to delete"))
                    {
                        id=$(this).attr("productid");
                        var pr1=$(this).parent();
                        var pr=$(this).parent().parent();
                        $.ajax({
                            url:'ajax.jsp',
                            type:'post',
                            data:{"cartid1":id},
                            beforesend:function()
                            {
                               pr1.append("loading..") ;
                            },
                            success:function(result)
                            {
                                if($.trim(result)=="success")
                                    pr.css({'backgroundColor':'red'});
                                pr.fadeOut(200,function(){
                                    pr.remove()
                                    calculatetotal();
                                })
                            },
                            error:function(e)
                            {
                                pr1.append("error due to" + e);
                            }
                        })
                    }
                    
                })
            })
            function calculatetotal()
            {
                
                $.ajax({
                    url:"ajax.jsp",
                    data:{"total":"true"},
                    type:"post",
                    beforesend:function()
                    {
                        $("#msg1").html("loading..")
                    },
                    success:function(result)
                    {
                  
                        $("#msg1").html(result)
                    },
                    error:function()
                    {
                        $("#msg1").html("error in ajax")
                    }
                })
            }
        </script>
    </body>
</html>
