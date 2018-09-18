<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<!DOCTYPE >
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员首页</title>
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Le styles -->
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
    
 		$(function(){
 			init();
 			latestOrders();
 		});
    
    	function init(){
    		$.ajax({
    			url:"manager/initIndex.action",
    			type:"post",
    			dataType:"json",
    			success:function(data){
    				$("#goodsCount").text(data.goodsCount);
    				$("#userCount").text(data.userCount);
    				$("#totalIncome").text(data.totalIncome.toFixed(2));
    				$("#totalSell").text(data.totalSell);
    			}
    		});	
    	}
    	
    	function latestOrders(){
    		$.ajax({
    			url:"manager/latestOrders.action",
    			type:"post",
    			dataType:"json",
    			success:function(data){
    				html="";
    				$.each(data,function(index,item){
    					html+="<tr>"
							+"<td><a style='text-decoration:none' href=\"manager/orderView.action\">"+item.onumber+"</a></td>"
							+"<td>￥"+item.totalPrice.toFixed(2)+"</td>"
							+"</tr>";
    				});
    				$("tbody").html(html);
    			}
    		});
    	}
    </script>
</head>    
<body>

<div class="container">
		
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
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i> ${sessionScope.manager.username }
				</a>		
			</li>
		</ul>

		<ul class="breadcrumb">
			<li>
				<a href="manager/indexView.action">管理</a>
			</li>
			
		</ul>
		
	</div>
	
	<div class="main-area dashboard">

		<div class="row">
		
			<div class="span10">
			
				<div class="slate clearfix">
				
					<a class="stat-column" href="javascript:void(0)">						
						<span id="goodsCount" class="number">16</span>
						<span>商品种类数</span>						
					</a>
				
					<a class="stat-column" href="javascript:void(0)">
						
						<span id="userCount" class="number">452</span>
						<span>用户数</span>
						
					</a>
				
					<a class="stat-column" href="javascript:void(0)">						
						<span id="totalIncome" class="number">$2,512</span>
						<span>总收入</span>
					</a>				
					<a class="stat-column" href="javascript:void(0)">						
						<span id="totalSell" class="number">348</span>
						<span>售出商品数</span>						
					</a>
				
				</div>
			
			</div>
		
		</div>
		
		<div class="row">
			<div class="span5">
			
				<div class="slate">
				
					<div class="page-header">
						<h2><i class="icon-shopping-cart pull-right"></i>最近成交订单</h2>
					</div>
					
					<table class="orders-table table">
					<tbody>						
					</tbody>
					</table>

				</div>
			
			</div>
		
		</div>
		
	
		
		
	</div>
	
	</div> <!-- end span10 -->
		
	</div> <!-- end row -->
		
</div> <!-- end container -->

</body>
</html>