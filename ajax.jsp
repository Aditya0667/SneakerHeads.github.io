

<%@page import="java.sql.*"%>

        <%
            Thread.sleep(1000);
            String path="jdbc:mysql://localhost/";
         String place="shopping";
         String uname="root";
         String pass="";
            if(request.getParameter("emailid")!=null)
            {
          
       Class.forName("com.mysql.jdbc.Driver");
                
                       
                 
             try
        {
            
            Connection myconnection;
            Class.forName("com.mysql.jdbc.Driver");
            myconnection=DriverManager.getConnection(path+place,uname,pass);
            
                        try
            {
                String query = " select * from usertable where username=? ";
                PreparedStatement mystatement = myconnection.prepareStatement(query);
                ResultSet myresult=mystatement.executeQuery();
                
                if(myresult.next())
                {
                    out.print("<font color='red'> username exists </font>" );
                }
                else
                {
                    out.print("<font color='green'> username available </font>");
                }
            }
            catch(Exception e)
            {
                out.print("Error in query" + e.getMessage());
            }
            finally
            {
                myconnection.close();
            }
        }   
        catch(Exception e)
        {
            out.print("Error in connection" + e.getMessage());
        }
   }
            else if(request.getParameter("catid")!=null)
            {
                try
                {
                    Connection myconnection;
                    Class.forName("com.mysql.jdbc.Driver");
                    myconnection=DriverManager.getConnection(path+place,uname,pass);
                    try
                    {
                        String query="select * from subcategorytable where catid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,request.getParameter("catid"));
                        ResultSet myresult=mystatement.executeQuery();
                        if(myresult.next())
                        {
                            do
                            
                            {
                            
                           out.print("<option value=" + myresult.getString("subcatid")+ ">" + myresult.getString("subcatname") + "</option>" );
                            }
                            while(myresult.next());
                            
                        }
                        else
                        {
                            out.print("<option> no subcategory exists </option>");
                        }
                        
                                        
                                    
                    }
                    catch(Exception  e)
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
            }

          else if(request.getParameter("pid1")!=null)
            {
                try
                {
                    Connection myconnection;
                    Class.forName("com.mysql.jdbc.Driver");
                    myconnection=DriverManager.getConnection(path+place,uname,pass);
                    try
                    {
                        String query="delete from producttable where productid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,request.getParameter("pid1"));
                       if(mystatement.executeUpdate()>0)
                       {
                           out.print("success");
                       }
                        else
                        {
                            out.print("error");
                        }
                        
                                        
                                    
                     }
                    catch(Exception  e)
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
            }
          else if(request.getParameter("cartid1")!=null)
          {
             try
             {
          Connection myconnection;
         Class.forName("com.mysql.jdbc.Driver");
         myconnection=DriverManager.getConnection(path+place,uname,pass);
         try
         {
          String query="delete from cart where cartid=?"; 
          PreparedStatement mystatement=myconnection.prepareStatement(query);
          mystatement.setString(1,request.getParameter("cartid1"));
          if(mystatement.executeUpdate()>0)
                  {
                      out.print("success");
                  }
          else
          {
              out.print("product cannot be deleted");
          }
         
             }
         catch(Exception e)
         {
             out.print("error in query due to" + e.getMessage());
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
          else if(request.getParameter("total")!=null)
          {
              String finalcost="";
              try
              {
         Connection myconnection;
         Class.forName("com.mysql.jdbc.Driver");
         myconnection=DriverManager.getConnection(path+place,uname,pass);

              
              try
              {
                  String q1="select sum(tcost) as fcost from cart where uname=?";
                  PreparedStatement mystatement1=myconnection .prepareStatement(q1);
                  mystatement1.setString(1,session.getAttribute("uname").toString());
                  ResultSet myresult1=mystatement1.executeQuery();
                  if(myresult1.next())
                  {
                      finalcost=myresult1.getString("fcost");
                      session.setAttribute("tcost",finalcost);
                      out.print("Final cost: Rs " + finalcost + "/-");
                  }
                  else
                  {
                      out.print("could not finad the sum");
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
        }
        else if(request.getParameter("cid1")!=null)
            {
                try
                {
                     
                    Connection myconnection;
                    Class.forName("com.mysql.jdbc.Driver");
                    myconnection=DriverManager.getConnection(path+place,uname,pass);
                    try
                    {
                        String query="delete from categorytable where catid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,request.getParameter("cid1"));
                       if(mystatement.executeUpdate()>0)
                       {
                           out.print("success");
                       }
                        else
                        {
                            out.print("error");
                        }
                        
                                        
                                    
                     }
                    catch(Exception  e)
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
            }
  else if(request.getParameter("scid1")!=null)
            {
                try
                {
                    Connection myconnection;
                    Class.forName("com.mysql.jdbc.Driver");
                    myconnection=DriverManager.getConnection(path+place,uname,pass);
                    try
                    {
                        String query="delete from subcategorytable where subcatid=?";
                        PreparedStatement mystatement=myconnection.prepareStatement(query);
                        mystatement.setString(1,request.getParameter("scid1"));
                       if(mystatement.executeUpdate()>0)
                       {
                           out.print("success");
                       }
                        else
                        {
                            out.print("error");
                        }
                        
                                        
                                    
                     }
                    catch(Exception  e)
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
            }
         
            

                          
 %>