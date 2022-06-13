

<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@include file="imp.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="css.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="container">
            <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
					<div class="modal_body_left modal_body_left1">
						<h3 class="agileinfo_sign">Add product</h3>
						
                                                <form method="post" enctype="multipart/form-data">
							<select name="cat" id="catbox" class="form-control">
<option>Choose Category</option>
<%
    String path="jdbc:mysql://localhost:3306/";
         String place="shopping";
         String uname="root";
         String pass="";

Class.forName("com.mysql.jdbc.Driver");
try
{
Connection myconn = DriverManager.getConnection(path+place,uname,pass);
try
{
String q = "select catid,catname from categorytable";
PreparedStatement myst = myconn.prepareStatement(q);
ResultSet myres = myst.executeQuery();
if(myres.next())
{
do
{
out.print("<option value='" + myres.getString("catid") + "'>" + myres.getString("catname") + "</option>");
}
while(myres.next()); 
}
else
{
out.print("<option>No Categories</option>");
}

}
catch(Exception e)
{
out.print("Error in query" + e.getMessage());
}
finally
{
myconn.close();
}
} 
catch(Exception e)
{
out.print("Error in connection" + e.getMessage());
} 

%>
</select>
<div id="answerbox"> </div> </br>
<div class="">
    <div id="selectboxarea">
        <select name="subcatbox" id="subcatbox" class="form-control" required> 
            <option value=""> choose subcategory </option>
        </select>
    </div>
</div>
<input type="text" class="text" name="productname" placeholder="product name" class ="form-control"  required> <br>
<input type="text" class="text" name="price" placeholder="price" class ="form-control" required> <br>
<input type="text" class="text" name="quantity" placeholder="quantity" class ="form-control" required> <br>
<input type="file" name="productimage"> <br>


<input type="submit" value="add product" required> <br>       



<%
String catid="", subcatid="", pname="",imagename="",price="",qty="",path1="";
boolean successful=true;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);

if(isMultipart)
{

FileItemFactory factory = new DiskFileItemFactory();

ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> items = null;

try
{
items = upload.parseRequest(request);
}
catch (FileUploadException e)
{
e.printStackTrace();
}



for(FileItem myitem:items)
{
if (myitem.isFormField())
{
String itemName1 = myitem.getFieldName();//catsummary
String value=myitem.getString();//

if(itemName1.equals("cat")) //control's name - textbox name
{
catid=value;
}
else if(itemName1.equals("subcatbox")) //control's name - textbox name
{
subcatid=value;
}
else if(itemName1.equals("productname")) //control's name - textbox name
{
pname =value;
}
else if(itemName1.equals("price")) //control's name - textbox name
{
price=value;
}
else if(itemName1.equals("quantity")) //control's name - textbox name
{
qty=value;
}
}
else
{
String type=myitem.getContentType();
long size=myitem.getSize()/1024; //kbytes

if(size==0)
{
imagename="noimagefound.jpg";
}
else if((type.equals("image/pjpeg") || type.equals("image/jpeg")
|| type.equals("image/png") || type.equals("image/x-png")
|| type.equals("image/gif")))
{
imagename=new java.util.Date().getTime()+myitem.getName();
path1=getServletContext().getRealPath("/") + "upload\\" + imagename;

File savefile=new File(path1);
myitem.write(savefile); 
}
else
{
successful=false;
out.println("Only pictures are allowed");
} 
}

}
if(successful==true)
{
    
      
Class.forName("com.mysql.jdbc.Driver");
try
{
Connection myconn = DriverManager.getConnection(path+place,uname,pass);
try
{
String q = "insert into producttable(catid,subcatid,productname,price,quantity,productimage) values(?,?,?,?,?,?)";
PreparedStatement myst = myconn.prepareStatement(q);
myst.setString(1, catid);
myst.setString(2, subcatid);
myst.setString(3, pname);
myst.setString(4,price);
myst.setString(5,qty);
myst.setString(6,imagename);

int myres = myst.executeUpdate();
if(myres>0)
{
out.print("product added successfully");
}
else
{
out.print("product not added successfully");
}
}
catch(Exception e)
{
out.print("Error in query" + e.getMessage());
}
finally
{
myconn.close();
}
} 
catch(Exception e)
{
out.print("Error in connection" + e.getMessage());
}
}
}
%>
                                        </form>
</div>

</div>
</div>
<%@include file="footer.jsp" %>	
<script>
    $(document).ready(function(){
        $("#catbox").change(function(){
            category=(this).value
            $.ajax({
                url:'ajax.jsp',
                type:'post',
                data:{"catid":category},
                beforeSend:function()
                { 
                    $('#answerbox').html("loading...");
                },
                success:function(result)
                {
                    $('#answerbox').html("");
                   $('#subcatbox').html(result);
                },
                error:function()
                {
                    alert("error")
                }
            })
        })
        
    })
    </script>