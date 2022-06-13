<%@include file="css.jsp" %>
<!-- top-header -->
	<div class="header-most-top">
		<p>My Sneakers Shopping</p>
	</div>
	<!-- //top-header -->
	<!-- header-bot-->
	<div class="header-bot">
		<div class="header-bot_inner_wthreeinfo_header_mid">
			<!-- header-bot-->
			<div class="col-md-4 logo_agile">
				<h1>
					<a href="index.jsp">
						<span>S</span>neaker
						<span>H</span>eads
						<img src="images/nike1.jpeg" width="100px" height="100px" alt=" ">
					</a>
				</h1>
			</div>
			<!-- header-bot -->
			
						</button><div class="col-md-8 header">
				<!-- header lists -->
				<ul>
					<li>
                                            <a href="index.jsp">
							<span class="fa fa-map-marker" aria-hidden="true"></span>Home</a>
					</li>
					<li>
						<a href="showuserorder.jsp" >
							<span class="fa fa-truck" aria-hidden="true"></span>View User Order</a>
					</li>
					<li>
						<span class="fa fa-phone" aria-hidden="true"></span> +91-8091700162
					</li>
                                        
                                        <%
                                            if(session.getAttribute("uname")==null && session.getAttribute("aname")==null)
                                            {
					out.print("<li>"
						+ "<a href='login.jsp'>"
							+"<span class='fa fa-unlock-alt'aria-hidden='true'></span> Sign In </a>"
					+"</li>"
					+ "<li>"
						+"<a href='signup.jsp'>"
							+"<span class='fa fa-pencil-square-o'aria-hidden='true'></span> Sign Up </a>"
					+"</li>");
                                            }
                                            else
                                            {
                                                out.print("<li>"
                                                        +  "<a href='signout.jsp'>"
							+ "<span class='fa fa-unlock-alt'aria-hidden='true'>"
                                                        + "</span> Sign Out </a>"
                                                +"</li>"
                                                +"<li>"
						+"<a href='changepassword.jsp'>"
							+"<span class='fa fa-pencil-square-o'aria-hidden='true'></span> Change Password </a>"
					+"</li>"
                                                        );
                                                       
                                                
                                            }
                                                             %>
				</ul>
				<!-- //header lists -->
				<!-- search -->
				<div class="agileits_search">
					<form action="#" method="post">
						<input name="Search" type="search" placeholder="How can we help you today?" required="">
						<button type="submit" class="btn btn-default" aria-label="Left Align">
                                                    
					</form>
				</div>
				<!-- //search -->
				<!-- cart details -->
				<div class="top_nav_right">
					<div class="wthreecartaits wthreecartaits2 cart cart box_1">
						<form action="#" method="post" class="last">
							<input type="hidden" name="cmd" value="_cart">
							<input type="hidden" name="display" value="1">
							<button class="w3view-cart" type="submit" name="submit" value="">
								<i class="fa fa-cart-arrow-down" aria-hidden="true"></i>
							</button>
						</form>
					</div>
				</div>
				<!-- //cart details -->
				<div class="clearfix"></div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- shop locator (popup) -->
	<!-- Button trigger modal(shop-locator) -->
				
					
									
                                            <!-- //shop locator (popup) -->
	<!-- signin Model -->
	<!-- Modal1 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog">
		<div class="modal-dialog">
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
						<h3 class="agileinfo_sign">Sign In </h3>
						<p>
							Sign In now, Let's start your Grocery Shopping. Don't have an account?
							<a href="signup.jsp">
								Sign Up Now</a>
						</p>
						<form action="#" method="post">
							<div class="styled-input agile-styled-input-top">
								<input type="text" placeholder="User Name" name="Name" required="">
							</div>
							<div class="styled-input">
								<input type="password" placeholder="Password" name="password" required="">
							</div>
							<input type="submit" value="Sign In">
						</form>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<!-- //Modal content-->
		</div>
	</div>
	<!-- //Modal1 -->
	<!-- //signin Model -->
	<!-- signup Model -->
	<!-- Modal2 -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog">
		<div class="modal-dialog">
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
						<h3 class="agileinfo_sign">Sign Up</h3>
						<p>
							Come join the Grocery Shoppy! Let's set up your Account.
						</p>
						<form action="#" method="post">
							<div class="styled-input agile-styled-input-top">
								<input type="text" placeholder="Name" name="Name" required="">
							</div>
							<div class="styled-input">
								<input type="email" placeholder="E-mail" name="Email" required="">
							</div>
							<div class="styled-input">
								<input type="password" placeholder="Password" name="password" id="password1" required="">
							</div>
							<div class="styled-input">
								<input type="password" placeholder="Confirm Password" name="Confirm Password" id="password2" required="">
							</div>
							<input type="submit" value="Sign Up">
						</form>
						<p>
							<a href="#">By clicking register, I agree to your terms</a>
						</p>
					</div>
				</div>
			</div>
			<!-- //Modal content-->
		</div>
	</div>
	<!-- //Modal2 -->
	<!-- //signup Model -->
	
					