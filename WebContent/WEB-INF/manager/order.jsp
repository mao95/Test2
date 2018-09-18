<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
	<script type="text/javascript">	
		function getAllOrder(currentPage){
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"manager/getAllOrder.action",
				type:"post",
				data:{"currentPage":currentPage,"pageRows":4},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>订单编号</th><th>用户id</th><th>成交时间</th><th>总计</th><th>收货地址id</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='getAllOrder("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='getAllOrder("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='getAllOrder("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='getAllOrder("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.onumber+"</td>"
								+"<td>"+item.uid+"</td>"
								+"<td>"+item.time+"</td>"
								+"<td>"+item.totalPrice.toFixed(2)+"</td>"
								+"<td>"+item.aid+"</td>"
								+"<td><a style='text-decoration:none' href='javascript:void(0)' onclick=\"showDetails('"+item.onumber+"')\">订单详情</a></td>"
								+"</tr>";
						});	
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}					
					$("#allOrder").html(html);	
				}
			});	
		}
		function queryOrderByName(currentPage){
			var username=$("#username").val();
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"manager/queryOrderByName.action",
				type:"post",
				data:{"currentPage":currentPage,"pageRows":4,"username":username},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>订单编号</th><th>用户id</th><th>成交时间</th><th>总计</th><th>收货地址id</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='queryOrderByName("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='queryOrderByName("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='queryOrderByName("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='queryOrderByName("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.onumber+"</td>"
								+"<td>"+item.uid+"</td>"
								+"<td>"+item.time+"</td>"
								+"<td>"+item.totalPrice.toFixed(2)+"</td>"
								+"<td>"+item.aid+"</td>"
								+"<td><a style='text-decoration:none' href='javascript:void(0)' onclick=\"showDetails('"+item.onumber+"')\">订单详情</a></td>"
								+"</tr>";
						});	
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();						
					}
					$("#allOrder").html(html);		
				}
			});
		}
		
		function queryOrderByDate(currentPage){
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"manager/queryOrderByDate.action",
				type:"post",
				data:{"currentPage":currentPage,"pageRows":4,"startDate":startDate,"endDate":endDate},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>订单编号</th><th>用户id</th><th>成交时间</th><th>总计</th><th>收货地址id</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='queryOrderByDate("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='queryOrderByDate("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='queryOrderByDate("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='queryOrderByDate("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.onumber+"</td>"
								+"<td>"+item.uid+"</td>"
								+"<td>"+item.time+"</td>"
								+"<td>"+item.totalPrice.toFixed(2)+"</td>"
								+"<td>"+item.aid+"</td>"
								+"<td><a style='text-decoration:none' href='javascript:void(0)' onclick=\"showDetails('"+item.onumber+"')\">订单详情</a></td>"
								+"</tr>";
						});	
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();						
					}
					$("#allOrder").html(html);		
				}
			});
		}
		
		function showDetails(onumber){
			$.ajax({
				url:"manager/getOneOrder.action",
				type:"post",
				data:{"onumber":onumber},
				dataType:"json",
				success:function(data){
					html="";
					$.each(data.list,function(index,item){
						html+="<tr>"
							+"<td>"+"<img src='upLoad/"+item.img+"'/>"+"</td>"
							+"<td>"+item.gname+"</td>"
							+"<td>"+item.singlePrice.toFixed(2)+"</td>"
							+"<td>"+item.amount+"</td>"
							+"<td>"+item.totalPrice.toFixed(2)+"</td>"
							+"</tr>";					
					});
					$("#body").html(html);
					$("#receiver1").html(data.address.name);
					$("#receiver2").html(data.address.phone);
					$("#receiver3").html(data.address.address);
					$("#details").css("visibility","visible");
				}
			});
		}
		
		function back(){
			$("#details").css("visibility","hidden");
		}
	
	
	</script>
	<style>		
		.imagetable tr{
		border-width: 1px;
		border-style: solid;
		border-color: rgb(81, 130, 187);
		}
		.imagetable th {
          padding: 5px 10px;
		  font-size: 12px;
		  font-family: Verdana;
		  font-weight: bold;
		  border-width: 1px;
		  border-style: solid;
		  border-color: rgb(81, 130, 187);
		  background-color: rgb(81, 130, 187);
		  color: #fff;
		  border-bottom-width: 0;
        }
     .imagetable td {
          color: #000;
     	  padding: 5px 10px;
		  font-size: 12px;
		  font-family: Verdana;
		  font-weight: bold;
     }
     
    #details{
	position:fixed;
	top:80px;
	left:200px;
	border:1px solid black;
	width:800px;
	background-color:white;	
	visibility: hidden;
	overflow: hidden;
	}
	
	#receiver{
		margin-top:30px;
		width:100%;
	}
	#receiver span{
		margin-left:20px;
	}
	#receiver label{
		margin-left:20px;
		display:inline-block;
	}
	
	.dtitle{
		width:100%;
	}
	.dtitle tr{
	border-width: 1px;
	border-style: solid;
	border-color: rgb(81, 130, 187);
	}
	.dtitle th {
		padding: 5px 10px;
		font-size: 12px;
		font-family: Verdana;
		font-weight: bold;
		border-width: 1px;
		border-style: solid;
		border-color: rgb(81, 130, 187);
		background-color: rgb(81, 130, 187);
		color: #fff;
		border-bottom-width: 0;
	 }
	.dtitle td {
	  	width:60px;
	 	color: #000;	
	 	padding: 5px 10px;
		font-size: 12px;
		font-family: Verdana;
		font-weight: bold;
	}
	#body img{
		width:100px;
	}
	#details .back{
		width:50px;
		height:30px;
		margin-top:50px;
		margin-left:350px;
		border-radius: 10px;
		background-color:rgb(81, 130, 187);
		padding:0px;
	}
	
	</style>
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
				<a href="manager/indexView.action">管理</a> <span class="divider">/</span>
			</li>
			<li class="active">订单管理</li>
		</ul>		
	</div>
	<div class="main-area dashboard">
			<div class="alert alert-info">
				<a class="close" data-dismiss="alert" href="#">x</a>
				<h4 class="alert-heading">Information</h4>
				This template shows how forms can be laid out for editing content.
			</div>
			<div class="row">			
				<div class="span10">				
					<div class="slate">					
						<div class="form-inline">
							<input id="username" style="height:25px;width:150px"  type="text" class="input-large" placeholder="用户名">										
							<button type="submit" class="btn btn-primary" onclick="queryOrderByName(1)">查询</button>
							<input id="startDate" style="height:25px;width:150px"  type="text" class="input-large" placeholder="起始时间">
							<input id="endDate" style="height:25px;width:150px"  type="text" class="input-large" placeholder="结束时间">										
							<button type="submit" class="btn btn-primary" onclick="queryOrderByDate(1)">时间查询</button>
						</div>					
					</div>				
				</div>			
			</div>			
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="getAllOrder(1)">查询所有订单</button>		
					<button class="btn btn-success">Action</button>		
			</div>		
			
			
			<table id="allOrder" class="imagetable" border="1px" cellspacing="20px"  style="margin-top:100px">
			</table>
			<div class="pagination pull-left" id="pageSwitch">						
			</div>
			<div id="details">
		     	<table class="dtitle" > 
		     		<thead id="head">
			     		<tr>
				     		<th>图片</th>
				     		<th>商品名称</th>
				     		<th>单价</th>
				     		<th>数量</th>
				     		<th>总计</th>
			     		</tr>
			     	</thead>
			     	<tbody id="body">
			     	</tbody>
		     	</table>
		     	<div id="receiver">
		     		<label>收货人:</label>
		     		<span id="receiver1"></span>
		     		<label>手机号码:</label>
		     		<span id="receiver2"></span>
		     		<label>收货地址:</label>
		     		<span id="receiver3"></span>
		     	</div>
		     	<button class="back" onclick="back()">返回</button>
		    </div>
	</div>	
	</div> 	
	</div>	
	
				
				
</div> 

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.js"></script>


</body>
</html>
