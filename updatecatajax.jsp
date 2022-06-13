<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.sql.*"%>

<%
String cname="", oldpic="",imagename="",cid="",path1="";
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

if(itemName1.equals("catname")) //control's name - textbox name
{
cname=value;//Oils
}
else if(itemName1.equals("oldpic")) //control's name - textbox name
{
oldpic=value;//Oils
}
else if(itemName1.equals("catid")) //control's name - textbox name
{
cid=value;//Oils
}
}
else
{
String type=myitem.getContentType();
long size=myitem.getSize()/1024; //kbytes

if(size==0)
{
imagename=oldpic;
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
String q = "update categorytable set catname=?,catimage=? where catid=?";
PreparedStatement myst = myconn.prepareStatement(q);
myst.setString(1, cname);
myst.setString(2, imagename);
myst.setString(3, cid);
int myres = myst.executeUpdate();
if(myres>0)
{
out.print("Category updated successfully");
}
else
{
out.print("Category not updated successfully");
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
