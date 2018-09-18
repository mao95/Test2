<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>" > 
    <meta charset="utf-8" />
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css" />
    <script src="js/jquery-2.2.4.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		function refreshImg(){	
			$("#verifyImg").attr("src","user/verify.action?t="+ new Date().getTime());
		}
	</script>
</head>

<body>
 	<%
 		Cookie[] cookies=request.getCookies();
 		if(cookies!=null){
 			for(Cookie cookie:cookies){
 				if("username".equals(cookie.getName())){
 					request.setAttribute("username", cookie.getValue());
 				}
 				if("password".equals(cookie.getName())){
 					request.setAttribute("password", cookie.getValue());
 				}
 			}
 		}
 	%>
    <div class="container">    
        <form class="form-horizontal col-sm-5 col-sm-offset-3" role="form" action="user/login.action" method="post">
			<h1 class="text-center text-danger">用户登录</h1>
            <div class="form-group">
                <label for="firstname" class="col-sm-2 control-label">账号</label>
                <div class="col-sm-10">
                    <input type="text" name="username" value="${requestScope.username }" class="form-control" id="firstname" placeholder="请输入账号">
                </div>
            </div>
            <div class="form-group">
                <label for="lastname" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10">
                    <input type="password" name="password" value="${requestScope.password }" class="form-control" id="lastname" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="lastname" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-10">
                    <input type="text" name="verify"  class="form-control" id="verify" placeholder="请输入验证码">
                    <img src="user/verify.action" id="verifyImg"/>
                    <a href="javascript:void(0)" onclick="refreshImg()">刷新</a>
                    <span style="color:red;margin-left:20px">${error }</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="remember" value="true">记住密码
                        </label>
                        <label>
                            <a href="register.jsp" style="text-decoration:none">免费注册</a>
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-default btn-block btn-warning">登录</button>
                </div>
            </div>
            
        </form>


    </div>

</body>


</html>
