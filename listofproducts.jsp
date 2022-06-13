

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("uname")==null && session.getAttribute("aname")==null)
    {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of products</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            int records_perpage=10, offset, pageno;
            double totalrecords=0, totalpages=0;
            
            
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
             String query2="select count(*) from producttable";
             PreparedStatement mystatement2=myconnection.prepareStatement(query2);
             ResultSet myres2=mystatement2.executeQuery();
             if(myres2.next())
             {
                totalrecords=myres2.getInt(1); 
             }
             if(request.getParameter("pageno")!=null)
             {
                 pageno=Integer.parseInt(request.getParameter("pageno"));
             }
             else
             {
                 pageno=1;
             }
             offset=records_perpage*(pageno-1);
             
             
             
             String query="select * from producttable limit " + offset + " , " + records_perpage;
                     
               
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 int counter=1;
                 out.print("<font color='red'> <h1 align='center'>List of products </h1></font>" +
                          "<div class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th>Product image</th>" +
								"<th>product name</th>" +
								"<th>Quantity</th>" +

								"<th>Price</th>" +
								"<th>Update</th>" +
                                                                "<th>Delete</th>" +
							"</tr>" +
						"</thead>" + "</div>");
                 out.print("<tbody>");
                 do
                 {
                     out.print("<tr><td>" + counter + "</td>"
                             + "<td><img src='upload/" + myresult.getString("productimage") + "'width=100px</td>"
                             + "<td>" + myresult.getString("productname") + "</td>"
                             + "<td>" + myresult.getString("quantity") + "</td>"
                             + "<td>" + myresult.getString("price") + "</td>"
                             + "<td><a href='updateproduct.jsp?pid= " + myresult.getString("productid") +"'> update </a></td>"
                             + "<td><a href='#' class='todelete' pid=" + myresult.getString("productid") +"'> Delete </a></td>"
                             + "</td></tr>");
                     counter++;
                             

                  }
                 while(myresult.next());
                 
                 totalpages=Math.ceil(totalrecords/records_perpage);
                 if(totalpages>1)
                 {
                     out.print(
                     "<table width='5%' align='center' cellpadding='2px' border='10px' cellspacing='10px'><tr>");
                     for(int i=1;i<=totalpages;i++)
                     {
                         if(i==pageno)
                         {
                             out.print("<td>"
                             + "<font color='red'>" + i + "</font></td>");
                         }
                         else
                         {
                             out.print("<td>"
                             +"<a href=listofproducts.jsp?pageno=" + i +">"
                             + i + "</a></td>");
                    }
                     }
                 }
                 out.print("</tr></table>");
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
         
            
            %>
        
         
        <%@include file="footer.jsp" %>
        <script>
             $(document).ready(function(){
                
           $(".todelete").click(function(e){
            e.preventDefault();
            if(confirm("Do you really want to delete?"))
            {
                id=$(this).attr("pid")
                var pr1=$(this).parent();
                var pr=$(this).parent().parent();
            
            $.ajax({
                url:'ajax.jsp',
                type:'post',
                data:{"pid1":id},
                beforeSend:function()
                { 
                    pr1.append("loading......");
                },
                success:function(result)
                {
                    if($.trim(result)=="success")
                    {
                        pr.css({'backgroundColor':'#fb6c6c'});
                        pr.fadeOut(600,function(){
                            pr.remove()
                        })
                    }
                    else
                    {
                        alert(result)
                    }
                },
                error:function()
                {
                    pr1.append("error due to " +e);
                }
            })
        }
        })
            
        
    })
            
     </script>       
        
    </body>
</html>
