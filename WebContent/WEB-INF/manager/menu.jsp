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
<title>Insert title here</title>
</head>
<body>

	<h1><i class="icon-shopping-cart icon-large"></i>后台管理</h1>
			
			<ul class="side-nav">

				<li class="active">
					<a href="manager/indexView.action"><i class="icon-home"></i>首页</a>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#website-dropdown" href="manager/manageType.action"><i class="icon-sitemap"></i> 分类管理 </a>
					
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#store-dropdown" href="manager/manageGoods.action"><i class="icon-shopping-cart"></i> 管理商品 </a>
				
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#reports-dropdown" href="javascript:void(0)"><i class="icon-signal"></i> 数据统计</a>
					
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#help-dropdown" href="manager/manageUser.action"><i class="icon-user"></i> 用户管理 </a>
					
				</li>
				<li><a href="manager/orderView.action"><i class="icon-bullhorn"></i>订单管理<span class="badge badge-warning">2</span></a></li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#members-dropdown" href="manager/moPWView.action"><i class="icon-group"></i> 修改密码 </a>
				
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#settings-dropdown" href="manager/exit.action"><i class="icon-cogs" ></i> 退出登录 </a>
					
				</li>
				
				
			</ul>

</body>
</html>