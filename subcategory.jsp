<%-- 
    Document   : signup
    Created on : 14 Mar, 2018, 6:51:26 PM
    Author     : DELL
--%>

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
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Add subcategory</title>
        <%@include file="css.jsp" %>
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
						<h3 class="agileinfo_sign">Add subcategory</h3>
						
                                                <form method="post" enctype="multipart/form-data">
							<select name="cat" class="form-control">
<option>Choose Category</option>
<%
    String path="jdbc:mysql://localhost/";
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
<input type="text" placeholder="Sub Category Name" required="" name="subcatname"><br/>
<input type="file" name="subcatimage">
<input type="submit" value="Add Sub Category" name="s1">
</form>
<%
String catid="", scname="", imagename="",path1="";
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
else if(itemName1.equals("subcatname")) //control's name - textbox name
{
scname=value;
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
String q = "insert into subcategorytable(catid,subcatname,subcatimage) values(?,?,?)";
PreparedStatement myst = myconn.prepareStatement(q);
myst.setString(1, catid);
myst.setString(2, scname);
myst.setString(3, imagename);
int myres = myst.executeUpdate();
if(myres>0)
{
out.print("Sub Category added successfully");
}
else
{
out.print("Sub Category not added successfully");
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
</div>

</div>
</div>
        </div>S		