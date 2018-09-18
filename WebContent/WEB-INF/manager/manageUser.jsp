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
<title>用户管理</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
	<script type="text/javascript">	
		function selectAllUser(currentPage){
			$("#moUser").css("display","none");
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"manager/selectAllUser.action",
				type:"post",
				data:{"currentPage":currentPage},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>id</th><th>用户名</th><th>手机号</th><th>真实姓名</th><th>身份证号</th><th>性别</th>"
						+"<th>年龄</th><th>余额</th><th>状态</th><th>注册日期</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='selectAllUser("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='selectAllUser("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllUser("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllUser("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.uid+"</td>"
								+"<td>"+item.username+"</td>"
								+"<td>"+item.phone+"</td>"
								+"<td>"+item.realName+"</td>"
								+"<td>"+item.idNumber+"</td>"
								+"<td>"+item.sex+"</td>"
								+"<td>"+item.age+"</td>"
								+"<td>"+item.balance+"</td>";
							if(item.state==0){
								html+="<td>异常</td>";
							}else{
								html+="<td>正常</td>";
							}
							html+="<td>"+item.regDate+"</td>"
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moUser("+item.uid+")'>修改</a>"+"</td>"
								+"</tr>";
						});	
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}		
					$("#allUser").html(html);					
				}
			})	
		}
		function queryByName(){
			$("#moUser").css("display","none");
			var username=$("#name").val();
			var html="";
			html+="<tr><th>id</th><th>用户名</th><th>手机号</th><th>真实姓名</th><th>身份证号</th><th>性别</th>"
				+"<th>年龄</th><th>余额</th><th>状态</th><th>注册日期</th><th>操作</th></tr>";
			$.ajax({
				url:"manager/queryByName.action",
				type:"post",
				data:{"username":username},
				dataType:"json",
				success:function(data){
					html+="<tr>"
						+"<td>"+data.uid+"</td>"
						+"<td>"+data.username+"</td>"
						+"<td>"+data.phone+"</td>"
						+"<td>"+data.realName+"</td>"
						+"<td>"+data.idNumber+"</td>"
						+"<td>"+data.sex+"</td>"
						+"<td>"+data.age+"</td>"
						+"<td>"+data.balance+"</td>";
					if(data.state==0){
						html+="<td>异常</td>";
					}else{
						html+="<td>正常</td>";
					}
					html+="<td>"+data.regDate+"</td>"
						+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moUser("+data.uid+")'>修改</a>"+"</td>"
						+"</tr>";
					$("#allUser").html(html);
					$("#pageSwitch").empty();
				}
	   	 	})
		}
		function moUser(uid){
			$("#allUser").empty();
			$("#pageSwitch").empty();
			$("#moUser").css("display","block");
			$("#moUserForm").attr("action","manager/moUser.action?uid="+uid);
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
			<li class="active">用户管理</li>
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
							<input id="name" style="height:25px;width:150px"  type="text" class="input-large" placeholder="用户名">										
							<button type="submit" class="btn btn-primary" onclick="queryByName()">查询</button>
						</div>					
					</div>				
				</div>			
			</div>			
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="selectAllUser(1)">查询所有用户</button>		
					<button class="btn btn-success">Action</button>		
			</div>		
			<div class="row" id="moUser" style="display:none">
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:220px">
							<h2>修改用户信息</h2>
						</div>								
						<form id="moUserForm" class="form-horizontal"  method="post" action="">					
						  <div class="control-group">
						    <label class="control-label" >修改密码</label>
						    <div class="controls">
						      <input name="password" type="password" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >重新输入密码</label>
						    <div class="controls">
						      <input name="repassword" type="password" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label">状态</label>
						    <div class="controls">
							正常 <input name="state" type="radio" value="1" checked="checked">
							异常 <input name="state" type="radio" value="0">     
						    </div>
						  </div>
						  <div class="control-group">
						    <div class="controls">
						      <input class="input-file" type="submit" value="修改">
						    </div>
						  </div>
						</form>
					</div>				
				</div>			
			</div>	
			
			
			<table id="allUser" class="imagetable" border="1px" cellspacing="20px"  style="margin-top:100px">
			</table>
			<div class="pagination pull-left" id="pageSwitch">						
			</div>
	</div>	
	</div> 	
	</div>	
	
				
				
</div> 

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.js"></script>


</body>
</html>
