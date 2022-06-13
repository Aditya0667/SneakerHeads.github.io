
<%@page import="java.sql.*" %>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
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
						<h3 class="agileinfo_sign">Forgot Password</h3>
						
                                                <form name="abc" method="post" id="loginform">
							<div class="styled-input agile-styled-input-top">
                                                            <input type="email"  name="Email" placeholder="Enter your email id" required=""> <br>
							</div>
						<input type="submit" value="Proceed to send mail to your id" name="submit">
                                                <%
                                                  if(request.getParameter("submit")!=null)
                                                  {
                                                      Properties props=new Properties();
                                                      props.put("mail.smtp.host","smtp.gmail.com");
                                                      props.put("mail.smtp.socketFactory.port","465");
                                                      props.put("mail.smtp.socketFactory.class",
                                                              "javax.net.ssl.SSLSocketFactory");
                                                      props.put("mail.smtp.auth","true");
                                                      props.put("mail.smtp.port","465");
                                                      
                                                      Session session2=Session.getInstance(props,
                                                              new javax.mail.Authenticator() {
                                                                  protected PasswordAuthentication getPasswordAuthentication(){
                                                                    return new PasswordAuthentication("aditya.sahore2000@gmail.com","Aditya0404");  
                                                               
                                                                  }
                                    
                                                   });
                                                      try
                                                      {
                                                          Message message=new MimeMessage(session2);
                                                          message.addHeader("Content-type","text/html: charset=UTF-8");
                                                          message.setFrom(new InternetAddress("aditya.sahore2000@gmail.com"));
                                                          String text= request.getParameter("Email");
                                                          
                                                          message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(text));
                                                          message.setSubject("Reset password Link");
                                                          
                                                          Random obj=new Random();
                                                          int vercode=obj.nextInt(1000);
                                                          
                                                          message.setText("you have requested for password reset link.Kindly click below link to reset your password " 
                                                                  + "http://localhost:8080/SneakersShop/resetpassword.jsp?Email=" + text + " &vercode" + vercode);
                                                          Transport.send(message);
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
                                                                    String query="update usertable set vercode=? where username=?";
                                                                    PreparedStatement mystatement=myconnection.prepareStatement(query);
                                                                    
                                                                    mystatement.setInt(1,vercode);
                                                                    mystatement.setString(2,text);
                                                                    if(mystatement.executeUpdate()>0)
                                                                    {
                                                                      out.print("Mail sent successfully");  
                                                                    }
                                                                    else
                                                                    {
                                                                        out.print("not updated successfully");
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
                                                              out.print("error occured in connection due to"+e.getMessage());
                                                          }
                                                          
                                                      }
                                                      catch(Exception e)
                                                      {
                                                          out.print("Mail does not work" + e.getMessage());
                                                      }
                                                  }
                                                    %>
                                                </form>
                                        </div>
                                </div>
                        </div>
                                </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
