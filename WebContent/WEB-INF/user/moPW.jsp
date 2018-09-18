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
    <script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.js"></script>     
    <script type="text/javascript">
		function moPW(){
			var password=$("input[name='password']").val();
			var repassword=$("input[name='repassword']").val();
			if(password!=repassword){
				$("#error").html("两次密码不一致！");
				return false;
			}
			flag=/^[a-zA-Z+\-*\/0-9]{6,16}$/;
			if(flag.test(password)==false){
				$("#error").html("密码含有非法字符或者长度不够！");
				return false;
			}
			flag=/[a-zA-Z]/;
			if(flag.test(password)==false){
				$("#error").html("密码需要包含字母");
				return false;
			}
			return true;
		}
		$(function(){
			$("input[name='password']").focus(function(){
				$("#flag2").html("密码必须包含字母，由字母数字+-*/构成，长度为6-16位")
			})
			$("input[name='password']").blur(function(){
				$("#flag2").empty();
			})
		})
		
	</script>
	
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
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i> ${sessionScope.user.username }
				</a>
			</li>
		</ul>
		<ul class="breadcrumb">
			<li>
				<a href="#">个人中心</a> <span class="divider">/</span>
			</li>
			<li class="active">修改密码</li>
		</ul>		
	</div>
	
	<div style="margin-top:100px;margin-left:60px">
		<h2 style="margin-left:220px;margin-bottom:20px">修改密码</h2>
								
		 <form class="form-horizontal col-sm-7 col-sm-offset-3" role="form" action="user/moPW.action?uid=${sessionScope.user.uid }" method="post">
            
            <div class="form-group">
               <label class="col-sm-2 control-label" style="margin-right:10px">密码</label>
               <div class="col-sm-8">                	
               		<input type="password" name="password"  placeholder="请输入密码" style="width:300px;height:30px">
             		<div id="flag2" style="margin-left:150px;color:blue"></div>
             	</div>
          	 </div>
           		<div class="form-group">
          		   <label class="col-sm-2 control-label" style="margin-top:20px;margin-right:10px">确认密码</label>
                	<div class="col-sm-8">
                    	<input type="password" name="repassword"  placeholder="请再次输入密码" style="width:300px;height:30px;margin-top:20px">
               		</div>
            	</div>
           		<div class="form-group">
               		<div class="col-sm-offset-2 col-sm-8">
                   		 <input type="submit" style="margin-top:20px;margin-left:200px;width:150px" value="修改" class="btn btn-default btn-block" onclick="return moPW();"/>
               		</div>
            	</div>
            	 <div id="error" style="color:red">			
				 </div>
    			 ${error }
       		 </form>
       		
		</div>	
	 </div>	
	</div>							
</div> 
</body>
</html>
