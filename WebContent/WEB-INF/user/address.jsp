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
<title>管理收货地址</title>
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
		function selectAllAddress(currentPage){			
			$("#addAddress").css("display","none");
			$("#moAddress").css("display","none");
			var uid=${sessionScope.user.uid};
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"user/selectAllAddress.action",
				type:"post",
				data:{"currentPage":currentPage,"uid":uid},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>aid</th><th>地址</th><th>姓名</th><th>手机号</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='selectAllAddress("+lastPage+")'>Prev</a></li>";	
					for(var i=0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='selectAllAddress("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllAddress("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllAddress("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.aid+"</td>"
								+"<td>"+item.address+"</td>"
								+"<td>"+item.name+"</td>"
								+"<td>"+item.phone+"</td>"
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moAddress("+item.aid+")'>修改</a>"
								+" <a onclick='return confirm(\"确定删除?\");' href='user/deleteAddress.action?aid="+item.aid+"' style='text-decoration:none;margin-left:10px'>删除</a>"
								+"</td>"
								+"</tr>";
						});
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}		
					$("#allAddress").html(html);					
				}
			})	
		}	
		function moAddress(aid){
			$("#moAddress").css("display","block");
			$("#moAddressForm").attr("action","user/moAddress.action?aid="+aid);
			$("#allAddress").empty();
			$("#pageSwitch").empty();
			$("#addAddress").css("display","none");
		}
		
		function addAddress(){
			$("#allAddress").empty();
			$("#pageSwitch").empty();
			$("#addAddress").css("display","block");
			$("#moAddress").css("display","none");
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
		  font-size: 15px;
		  font-family: Verdana;
		  font-weight: bold;
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
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i> ${sessionScope.user.username }
				</a>
			</li>
		</ul>
		<ul class="breadcrumb">
			<li>
				<a href="#">个人中心</a> <span class="divider">/</span>
			</li>
			<li class="active">管理收货地址</li>
		</ul>		
	</div>
	<div class="main-area dashboard">
			<div class="alert alert-info">
				<a class="close" data-dismiss="alert" href="#">x</a>
				<h4 class="alert-heading">Information</h4>
				This template shows how forms can be laid out for editing content.
			</div>		
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="selectAllAddress(1)">管理收货地址</button>	
					<button class="btn btn-success" onclick="addAddress()">添加收货地址</button>		
			</div>		
			<div class="row" id="addAddress" style="display:none">
				<div class="span5">
					<div class="slate">														
						<h2 style="margin-left:230px;margin-bottom:20px">添加收货地址</h2>									
						<form id="addAddressForm" class="form-horizontal"  method="post" action="user/inAddress.action?uid=${sessionScope.user.uid }">					
						  <div class="control-group">
						    <label class="control-label" >地址</label>
						    <div class="controls">
						      <input name="address" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >姓名</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>	
						  <div class="control-group">
						    <label class="control-label" >手机号</label>
						    <div class="controls">
						      <input name="phone" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>			
						  <div class="control-group">
						    <div class="controls" style="margin-left:240px">
						      <input class="btn btn-default" style="width:80px" type="submit" value="添加">
						    </div>
						  </div>
						</form>
					</div>				
				</div>			
			</div>
			<div class="row" id="moAddress" style="display:none">
				<div class="span5">
					<div class="slate">												
						<h2 style="margin-left:230px;margin-bottom:20px">修改收货地址</h2>												
						<form id="moAddressForm" class="form-horizontal"  method="post" action="">					
						  <div class="control-group">
						    <label class="control-label" >地址</label>
						    <div class="controls">
						      <input name="address" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						   <div class="control-group">
						    <label class="control-label" >姓名</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>	
						  <div class="control-group">
						    <label class="control-label" >手机号</label>
						    <div class="controls">
						      <input name="phone" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>			  
						  <div class="control-group">
						    <div class="controls" style="margin-left:240px">
						      <input class="btn btn-default" style="width:80px" type="submit" value="修改">
						    </div>
						  </div>
						</form>
					</div>				
				</div>			
			</div>		
			
			
			<table id="allAddress" class="imagetable" border="1px"  style="margin-top:100px;margin-left:100px;width:620px">
			</table>
			<div class="pagination pull-left" id="pageSwitch" style="margin-left:100px">						
			</div>
	</div>	
	</div> 	
	</div>	
			
</div> 
</body>
</html>
