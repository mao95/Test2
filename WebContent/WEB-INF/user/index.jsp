<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		init();
	});
	function init(){
		$.ajax({
			url:"user/initIndex.action",
			type:"post",
			dataType:"json",
			success:function(data){
				$("#balance").text(data.balance.toFixed(2));
				$("#totalConsume").text(data.totalConsume.toFixed(2));
				$("#totalOrder").text(data.totalOrder);
			}
		});	
	}
</script>
</head>
<body>
	

		
	<div class="row">
		
		<div class="span2">
		
		<div class="main-left-col">
		
			<jsp:include page="menu.jsp"></jsp:include>
		
		</div> <!-- end main-left-col -->
	
	</div> <!-- end span2 -->
	
	<div class="span10">
		
	<div class="secondary-masthead">	
		<ul class="nav nav-pills pull-right">		
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i> ${sessionScope.user.username }
				</a>
			</li>
		</ul>
		<ul class="breadcrumb">
			<li>
				<a href="#">个人中心</a>
			</li>	
		</ul>		
	</div>
	
	<div class="main-area dashboard">

		<div class="row">
		
			<div class="span10">
			
				<div class="slate clearfix">
				
					<a class="stat-column" href="#">						
						<span id="balance" class="number">16</span>
						<span>余额</span>					
					</a>
					<a class="stat-column" href="#">
						
						<span id="totalConsume" class="number">452</span>
						<span>总消费金额</span>						
					</a>											
					<a class="stat-column" href="#">						
						<span id="totalOrder" class="number">348</span>
						<span>总订单数</span>						
					</a>		
				</div>			
			</div>		
		</div>
		
		<div class="row">
		
			<div class="span5">
				
			</div>
		
			<div class="span5">
			
				<div class="slate">
				
					<div class="page-header">
						<h2><i class="icon-shopping-cart pull-right"></i>Latest Orders</h2>
					</div>

				</div>
		
			</div>
		
		
	
	</div>
	
	</div> <!-- end span10 -->
		
	</div> <!-- end row -->
		
</div> <!-- end container -->
</body>
</html>