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
<title>个人信息</title>
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
		$(function(){
			querySelf();
		});
		function querySelf(){
			$("#update").css("display","none");
			$("#recharge").css("display","none");
			var html="";	
			$.ajax({
				url:"user/querySelf.action",
				type:"post",
				dataType:"json",
				success:function(data){
					html+="<tr><th>账户名</th><th>真实姓名</th><th>身份证号</th><th>手机号</th><th>性别</th>"
						+"<th>年龄</th><th>余额</th><th>状态</th><th>注册日期</th></tr>"
						+"<tr>"
						+"<td>"+data.username+"</td>"
						+"<td>"+data.realName+"</td>"
						+"<td>"+data.idNumber+"</td>"
						+"<td>"+data.phone+"</td>"
						+"<td>"+data.sex+"</td>"
						+"<td>"+data.age+"</td>"
						+"<td>"+data.balance+"</td>";
					if(data.state==0){
						html+="<td>异常</td>";			
					}
					else{
						html+="<td>正常</td>";			
					}
					html+="<td>"+data.regDate+"</td>";
					$("#allInfo").html(html);
				}
			})	
		}

		function recharge(){
			var uid= ${sessionScope.user.uid};
			$("#update").css("display","none");
			$("#recharge").css("display","block");
			$("#rechargeForm").attr("action","user/recharge.action?uid="+uid);
			$("#allInfo").empty();	
		}
		
		function rechargeCheck(){
			var money=$("#money").val();
			var check=/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
			if(check.test(money)==false){
				alert("充值金额不合法!");
				return false;
			}			
		}
		
		function updateView(){
			var uid= ${sessionScope.user.uid};
			$("#update").css("display","block");
			$("#recharge").css("display","none");
			$("#updateForm").attr("action","user/update.action?uid="+uid);
			$("#allInfo").empty();
		}	
		function update(){
			var idNumber=$("input[name='idNumber']").val();
			var phone=$("input[name='phone']").val();
			var flag=/^[0-9]{18}$/;
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
		function back(){
			$("#update").css("display","none");
			$("#recharge").css("display","none");
			querySelf();
		}
		$(function(){	
			$("input[name='idNumber']").focus(function(){
				$("#flag1").html("必须为18位数字")
			})
			$("input[name='idNumber']").blur(function(){
				$("#flag1").empty();
			})
			$("input[name='phone']").focus(function(){
				$("#flag2").html("必须为11位数字")
			})
			$("input[name='phone']").blur(function(){
				$("#flag2").empty();
			})
		})	
	
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
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i> ${sessionScope.user.username }
				</a>
			</li>
		</ul>
		<ul class="breadcrumb">
			<li>
				<a href="#">个人中心</a> <span class="divider">/</span>
			</li>
			<li class="active">个人信息</li>
		</ul>		
	</div>
	<div class="main-area dashboard">
			<div class="alert alert-info">
				<a class="close" data-dismiss="alert" href="#">x</a>
				<h4 class="alert-heading">Information</h4>
				This template shows how forms can be laid out for editing content.
			</div>
				
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="recharge()">余额充值</button>	
					<button class="btn btn-success" onclick="updateView()">编辑信息</button>		
			</div>		
			
			<div class="row" id="update" style="display:none">																	
				<h2 style="margin-left:400px;margin-bottom:20px">编辑信息</h2>										
				<form id="updateForm" class="form-horizontal col-sm-7 col-sm-offset-3" role="form" action="" method="post">
		           	<div style="margin-left:200px;margin-bottom:20px">
		                <label style="margin-right:10px"  class="col-sm-2 control-label">真实姓名</label>
		                <input style="height:30px;width:240px" type="text" name="realName" class="form-control"  placeholder="请输入真实姓名">
		             </div>
		             <div style="margin-left:200px;margin-bottom:20px">	 
		             	<div id="flag1" style="margin-left:150px;color:blue"></div>      
		                <label style="margin-right:10px"  class="col-sm-2 control-label">身份证号</label>   
		                <input style="height:30px;width:240px" type="text" name="idNumber" class="form-control"  placeholder="请输入身份证号">
		             </div>
		             <div style="margin-left:200px;margin-bottom:20px">	
		             	<div id="flag2" style="margin-left:150px;color:blue"></div>       
		                <label style="margin-right:10px" class="col-sm-2 control-label">手机号码</label>   
		                <input style="height:30px;width:240px" type="text" name="phone" class="form-control"  placeholder="请输入手机号码">
		             </div>
		             <div style="margin-left:200px;margin-bottom:20px">
						<label style="margin-right:10px" class="col-sm-2 control-label">性别</label>       
		                                         男<input type="radio" name="sex" id="optionsRadios1" value="男" checked>             
		                                         女<input type="radio" name="sex" id="optionsRadios2" value="女">   
					 </div>
					 <div style="margin-left:200px">
		                <label style="margin-right:10px" class="col-sm-2 control-label">年龄</label>     
		                <input style="height:30px;width:240px" type="text" name="age" class="form-control"  placeholder="请输入年龄">
	 				 </div>				 
		             <input style="margin-left:370px;margin-top:20px;width:60px" type="submit" value="修改" class="btn btn-default btn-block" onclick="return update();"/> 
		             <input style="margin-left:20px;margin-top:20px;width:80px" type="button" value="放弃修改" class="btn btn-default btn-block" onclick="back()"/>          
      		 		  <div id="error" style="color:red;margin-left:200px">			
			  		  </div>
   					  ${error }
      		  </form>					
			</div>
			<div class="row" id="recharge" style="display:none">																	
				<h2 style="margin-left:400px;margin-bottom:20px">用户充值</h2>										
				<form id="rechargeForm" class="form-horizontal col-sm-7 col-sm-offset-3" role="form" action="" method="post">
		           	<div style="margin-left:200px;margin-bottom:20px">
		                <label style="margin-right:10px"  class="col-sm-2 control-label">充值金额</label>
		                <input id="money" style="height:30px;width:240px" type="text" name="money" class="form-control"  placeholder="请输入充值金额">
		             </div>		             		 
		             <input style="margin-left:370px;margin-top:20px;width:60px" type="submit" value="充值" onclick="return rechargeCheck();" class="btn btn-default btn-block" /> 
		             <input style="margin-left:20px;margin-top:20px;width:80px" type="button" value="放弃充值" class="btn btn-default btn-block" onclick="back()"/>          
      		 		  <div id="error" style="color:red;margin-left:200px">			
			  		  </div>
   					  ${error }
      		  </form>					
			</div>			
			
			
			<table id="allInfo" class="imagetable" border="1px" style="margin-top:100px;margin-left:100px;height:100px">
			</table>	
	</div>	
	</div> 	
	</div>	
	
				
				
</div> 

</body>
</html>
