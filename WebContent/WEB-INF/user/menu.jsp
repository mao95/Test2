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

	<h1><i class="icon-shopping-cart icon-large"></i>个人中心</h1>
			
			<ul class="side-nav">

				<li class="active">
					<a href="user/indexView.action"><i class="icon-home"></i>首页</a>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle"  href="user/manageAddressView.action"><i class="icon-sitemap"></i> 管理收货地址 </a>
					
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle"  href="javascript:void(0)"><i class="icon-shopping-cart"></i> 购物车 </a>
				
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" href="javascript:void(0)"><i class="icon-signal"></i> 管理订单</a>
					
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" href="user/selfInfoView.action"><i class="icon-user"></i> 个人信息 </a>
					
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" href="user/moPWView.action"><i class="icon-group"></i> 修改密码 </a>
				
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" href="user/exit.action"><i class="icon-cogs" ></i> 退出登录 </a>
					
				</li>
				<li><a href="javascript:void(0)"><i class="icon-bullhorn"></i> Alerts <span class="badge badge-warning">2</span></a></li>
				
			</ul>

</body>
</html>