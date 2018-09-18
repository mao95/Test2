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
<title>修改密码</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
	
</head>    
<body>

<div class="container">		
	<div class="row">		
		<div class="span2">		
		<div class="main-left-col">	
			<jsp:include page="menu.jsp"></jsp:include>		
		</div> 
	</div>
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
			<li class="active">修改密码</li>
		</ul>		
	</div>
	<div class="main-area dashboard">
			<div class="alert alert-info">
				<a class="close" data-dismiss="alert" href="#">x</a>
				<h4 class="alert-heading">Information</h4>
				This template shows how forms can be laid out for editing content.
			</div>
						
				
			<div class="row"  >
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:220px">
							<h2>修改密码</h2>
						</div>								
						<form class="form-horizontal"  method="post" action="manager/moPW.action">					
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
						    <div class="controls">
						      <input class="input-file" type="submit" value="修改">
						    </div>
						  </div>
						</form>
					</div>				
				</div>			
			</div>	
			
			
		
	</div>	
	</div> 	
	</div>	
	
				
				
</div> 

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.js"></script>


</body>
</html>
