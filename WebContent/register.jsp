<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="css/register.css"/>
    <script src="js/jquery-2.2.4.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		function register(){
			var username=$("input[name='username']").val();
			var password=$("input[name='password']").val();
			var idNumber=$("input[name='idNumber']").val();
			var phone=$("input[name='phone']").val();
			var flag=/^[a-zA-Z][a-zA-Z0-9_]{5,15}$/;
			if(flag.test(username)==false){
				$("#error").html("账户名不对！");
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
			flag=/^[0-9]{18}$/;
			if(idNumber!=""){
				if(flag.test(idNumber)==false){
					$("#error").html("身份证号格式不对！");
					return false;
				}
			}
			flag=/^[0-9]{11}$/;
			if(phone!=""){
				if(flag.test(phone)==false){
					$("#error").html("手机号码格式不对！");
					return false;
				}
			}
			return true;
		}
		$(function(){
			$("input[name='username']").focus(function(){
				$("#flag1").html("账户名由字母和数字组成，长度为6-16位，首字母必须为字母，")
			})
			$("input[name='username']").blur(function(){
				$("#flag1").empty();
			})
			$("input[name='password']").focus(function(){
				$("#flag2").html("密码必须包含字母，由字母数字+-*/构成，长度为6-16位")
			})
			$("input[name='password']").blur(function(){
				$("#flag2").empty();
			})
			$("input[name='idNumber']").focus(function(){
				$("#flag3").html("必须为18位数字")
			})
			$("input[name='idNumber']").blur(function(){
				$("#flag3").empty();
			})
			$("input[name='phone']").focus(function(){
				$("#flag4").html("必须为11位数字")
			})
			$("input[name='phone']").blur(function(){
				$("#flag4").empty();
			})
		})
		
	</script>
</head>

<body>

    <div class="container">
    	<h1 style="text-align:center">用户注册</h1>
        <form class="form-horizontal col-sm-7 col-sm-offset-3" role="form" action="user/register.action" method="post">
            <div class="form-group">
                <label class="col-sm-2 control-label">账户</label>
                <div class="col-sm-8">
                	<div id="flag1" style="color:blue"></div>
                    <input type="text" name="username" class="form-control" placeholder="请输入账户"> 
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8">
                	<div id="flag2" style="color:blue"></div>
                    <input type="password" name="password" class="form-control"  placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">确认密码</label>
                <div class="col-sm-8">
                    <input type="password" name="repassword" class="form-control "  placeholder="请再次输入密码">
                </div>
            </div>
            <div class="form-group">
				<label class="col-sm-2 control-label">性别</label>
                <div class="radio col-sm-1">
                    <label>
                        <input type="radio" name="sex" id="optionsRadios1" value="男" checked> 男
                    </label>
                </div>
                <div class="radio col-sm-1">
                    <label>
                        <input type="radio" name="sex" id="optionsRadios2" value="女">女
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label  class="col-sm-2 control-label">真实姓名</label>
                <div class="col-sm-8">
                    <input type="text" name="realName" class="form-control"  placeholder="请输入手机号码">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">身份证号</label>
                <div class="col-sm-8">
                	<div id="flag3" style="color:blue"></div>
                    <input type="text" name="idNumber" class="form-control"  placeholder="请输入手机号码">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">年龄</label>
                <div class="col-sm-8">
                    <input type="text" name="age" class="form-control"  placeholder="请输入年龄">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">手机号码</label>
                <div class="col-sm-8">
                	<div id="flag4" style="color:blue"></div>
                    <input type="text" name="phone" class="form-control"  placeholder="请输入手机号码">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <input type="submit" value="注册" class="btn btn-default btn-block" onclick="return register();"/>
                </div>
            </div>
             <div id="error" style="color:red">			
			 </div>
			 <div style="color:red">
			 ${error }
			 </div>
   			 
        </form>
    </div>
</body>

</html>
