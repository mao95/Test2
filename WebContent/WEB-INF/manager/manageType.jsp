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
<title>分类管理</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
	<script type="text/javascript">	
		function selectAllType(currentPage){
			$("#addType").css("display","none");
			$("#moType").css("display","none");
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"selectAllType.action",
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
					html+="<tr><th>tid</th><th>分类名称</th><th>pid</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='selectAllType("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='selectAllType("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllType("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllType("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.tid+"</td>"
								+"<td>"+item.name+"</td>"
								+"<td>"+item.pid+"</td>"				
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moType("+item.tid+")'>修改</a>"+"</td>"
								+"</tr>";
						});
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}					
					$("#allType").html(html);		
				}
			})	
		}
		function queryByName(){
			var name=$("#name").val();			
			$("#addType").css("display","none");
			$("#moType").css("display","none");
			$("#pageSwitch").empty();
			var html="";	
			$.ajax({
				url:"queryByName.action",
				type:"post",
				data:{"name":name},
				dataType:"json",
				success:function(data){
					html+="<tr><th>tid</th><th>分类名称</th><th>pid</th><th>操作</th></tr>";
					$.each(data.list,function(index,item){
						html+="<tr>"
							+"<td>"+item.tid+"</td>"
							+"<td>"+item.name+"</td>"
							+"<td>"+item.pid+"</td>"				
							+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moType("+item.tid+")'>修改</a>"+"</td>"
							+"</tr>";
					})	
					$("#allType").html(html);
				}
	   	 	})
		}
		
		function queryByBigType(currentPage){
			$("#addType").css("display","none");
			$("#moType").css("display","none");
			var pid=$("#bigType").val();
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			var html="";	
			var html2="";
			$.ajax({
				url:"queryByBigType.action",
				type:"post",
				data:{"currentPage":currentPage,"pid":pid},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>tid</th><th>分类名称</th><th>pid</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='queryByBigType("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='queryByBigType("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='queryByBigType("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='queryByBigType("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"
								+"<td>"+item.tid+"</td>"
								+"<td>"+item.name+"</td>"
								+"<td>"+item.pid+"</td>"				
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='moType("+item.tid+")'>修改</a>"+"</td>"
								+"</tr>";
						});
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}	
					$("#allType").html(html);					
				}
			})	
		}
		
		function moType(tid){
			$("#moType").css("display","block");
			$("#moTypeForm").attr("action","manager/moType.action?tid="+tid);
			$("#allType").empty();
			$("#pageSwitch").empty();
			$("#addType").css("display","none");
		}
		
		function addType(){
			$("#allType").empty();
			$("#pageSwitch").empty();
			$("#addType").css("display","block");
			$("#moType").css("display","none");
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
			<li class="active">分类管理</li>
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
							<select id="bigType" class="span2">								
							</select>
							<button class="btn btn-primary" onclick="queryByBigType(1)">分类查询</button>
							<input id="name" style="height:25px" type="text" class="input-large" placeholder="分类名称">							
							<button class="btn btn-primary" onclick="queryByName()">名称查询</button>
						</div>					
					</div>				
				</div>			
			</div>			
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="selectAllType(1)">查询所有分类</button>	
					<button class="btn btn-success" onclick="addType()">添加分类</button>		
			</div>		
			<div class="row" id="addType" style="display:none">
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:220px">
							<h2>添加分类</h2>
						</div>								
						<form id="addTypeForm" class="form-horizontal"  method="post" action="manager/addType.action">					
						  <div class="control-group">
						    <label class="control-label" >分类名称</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >父类</label>
						    <select name="pid" id="type1" class="span2" style="width:80px;margin-left:20px">
							</select>
						  </div>  
						  <div class="control-group">
						    <div class="controls">
						      <input class="input-file" type="submit" value="添加">
						    </div>
						  </div>
						</form>
					</div>				
				</div>			
			</div>
			<div class="row" id="moType" style="display:none">
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:220px">
							<h2>修改分类</h2>
						</div>								
						<form id="moTypeForm" class="form-horizontal"  method="post" action="">					
						  <div class="control-group">
						    <label class="control-label" >分类名称</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >父类</label>
						    <select id="type2" name="pid" class="span2" style="width:80px;margin-left:20px" >
							</select>
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
			
			
			<table id="allType" class="imagetable" border="1px" cellspacing="20px" style="margin-top:100px;margin-left:100px;width:320px">
			</table>
			<div class="pagination pull-left" id="pageSwitch" style="margin-left:100px">						
			</div>
	</div>	
	</div> 	
	</div>	
	
				
				
</div> 

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script>
	
	function initBigType(){
		var html="";
		html+="<option value='0'>大分类</option>";
		$.ajax({
			url:"queryBigType.action",
			dataType:"json",
			type:"post",
			success:function(data){
				$.each(data,function(index,item){
					html+="<option value='"+item.tid+"'>"
						+item.name+"</option>";
				})
				$("#bigType").html(html); // 问老师？ 为什么放在外边 接收不到html的改变？？  放在外边，因为异步的关系
										 //ajax还没执行完，后面的代码就已经执行了。
			}		
		});	
	}
	function initType(){
		var html="";
		html+="<option value='0'>无</option>";
		$.ajax({
			url:"queryType.action",
			dataType:"json",
			type:"post",
			success:function(data){
				$.each(data,function(index,item){
					html+="<option value='"+item.tid+"'>"
						+item.name+"</option>";
				})
				$("#type1").html(html);
				$("#type2").html(html);// 问老师？ 为什么放在外边 接收不到html的改变？？  放在外边，因为异步的关系
										 //ajax还没执行完，后面的代码就已经执行了。
			}		
		});	
	}
	initType()
	initBigType();
</script>

</body>
</html>
