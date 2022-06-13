
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
             String query="select * from categorytable";
             PreparedStatement mystatement=myconnection.prepareStatement(query);
             ResultSet myresult=mystatement.executeQuery();
             if(myresult.next())
             {
                 int counter=1;
                 out.print("<font color='red'> <h1 align='center'>List of Categories </h1></font>" +
                          "<div.class='container'>" + 
                         "<table class='timetable_sub'>" +
						"<thead>" +
							"<tr>" +
								"<th>SL No</th>" +
								"<th>Category Name</th>" +
								"<th>Category Image</th>" +
							
								"<th>Update</th>" +
                                                                "<th>Delete</th>" +
							"</tr>" +
						"</thead>" + "</div>");
                 out.print("<tbody>");
                 do
                 {
                     out.print("<tr><td>" + counter + "</td>"
					 
					 
					 +"<td><a href='showsubcategories.jsp?catid="
					  + myresult.getString("catid")+ "'>"+myresult.getString("catname")+"</a></td>"
                             + "<td><img src='upload/" + myresult.getString("catimage") + "'width=100px</td>"
                             + "<td><a href='updatecat.jsp?cid= " + myresult.getString("catid") +"'> update </a></td>"
                             + "<td><a href='#' class='todelete' cid=" + myresult.getString("catid") +"'> Delete </a></td>"
                             + "</td></tr>");
                     counter++;
                             

                  }
                 while(myresult.next());
                 out.print("</tbody></table>");
             }
             else
             {
                 out.print("no categories added yet");
                   
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
                id=$(this).attr("cid")
                var pr1=$(this).parent();
                var pr=$(this).parent().parent();
            
            $.ajax({
                url:'ajax.jsp',
                type:'post',
                data:{"cid1":id},
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
