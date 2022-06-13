
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of SubCategories</title>
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
             String query="select * from subcategorytable where subcatid=?";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
              mystatement.setString(1,request.getParameter("subcatid"));
              ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 int counter=1;
                 out.print("<font color='red'> <h1 align='center'>List of SubCategories </h1></font>" +
                          "<div.class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th>SubCategory Name</th>" +
								"<th>SubCategory Image</th>" +
							
								"<th>Update</th>" +
                                                                "<th>Delete</th>" +
							"</tr>" +
						"</thead>" + "</div>");
                 out.print("<tbody>");
                 do
                 {
                     out.print("<tr><td>" + counter + "</td>"
					 + "<td>" + myresult.getString("subcatname") + "</td>"
                             + "<td><img src='upload/" + myresult.getString("subcatimage") + "'width=100px</td>"
                             + "<td><a href='updatesubcat.jsp?subcatid= " + myresult.getString("subcatid") +"'> update </a></td>"
                             + "<td><a href='#' class='todelete' subcatid=" + myresult.getString("subcatid") +"'> Delete </a></td>"
                             + "</td></tr>");
                     counter++;
                             

                  }
                 while(myresult.next());
                 out.print("</tbody></table>");
             }
             else
             {
                 out.print("No SubCategories added yet");
                   
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
                id=$(this).attr("subcatid")
                var pr1=$(this).parent();
                var pr=$(this).parent().parent();
            
            $.ajax({
                url:'ajax.jsp',
                type:'post',
                data:{"scid1":id},
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
