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
<title>商品管理</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">  
	<script type="text/javascript">
		function addGoods(){
			$("#addGoods").css("display","block");
			$("#allGoods").empty();
			$("#pageSwitch").empty();
			$("#updateGoods").css("display","none");
		}
		function selectAllGoods(currentPage){
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			$("#addGoods").css("display","none");
			$("#updateGoods").css("display","none");
			var html="";	
			var html2="";
			$.ajax({
				url:"selectAllGoods.action",
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
					html+="<tr><th>名称</th><th>品牌</th><th>价格</th><th>库存</th><th>销量</th>"
						+"<th>状态</th><th>大分类</th><th>小分类</th><th>图片</th><th>描述</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='selectAllGoods("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"	
								+"<td>"+item.name+"</td>"
								+"<td>"+item.bname+"</td>"
								+"<td>"+item.price+"</td>"
								+"<td>"+item.count+"</td>"
								+"<td>"+item.sales+"</td>";
							if(item.state==1){
								html+="<td>上架</td>";
							}else{
								html+="<td>下架</td>";
							}
							html+="<td>"+item.bigtype+"</td>"
								+"<td>"+item.smalltype+"</td>"
								+"<td>"+"<img src='upLoad/"+item.img+"'/>"+"</td>"
								+"<td>"+item.dept+"</td>"
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='updateGoods("+item.gid+")'>修改</a>"
								+" <a style='text-decoration:none' onclick='return confirm(\"确定删除?\");'  href='manager/deleteGoods.action?gid="+item.gid+"'>删除</a>"+"</td>"
								+"</tr>";
						});
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}						
					$("#allGoods").html(html);		
				}
			})	
		}
		function queryLike(currentPage){
			var name=$("#name").val();
			var dept=$("#dept").val();
			var bname=$("#bname").val();
			var bigtype=$("#bigtype").val();
			var smalltype=$("#smalltype").val();
			var lastPage=currentPage-1;
			var nextPage=currentPage+1;
			if(lastPage<1){
				currentPage=1;
			}
			$("#addGoods").css("display","none");
			$("#updateGoods").css("display","none");
			var html="";	
			var html2="";
			$.ajax({
				url:"queryLike.action",
				type:"post",
				data:{"currentPage":currentPage,"name":name,"dept":dept,"bname":bname,"bigtype":bigtype,"smalltype":smalltype},
				dataType:"json",
				success:function(data){
					var pageCount=data.pageCount;
					if(lastPage<1){
						lastPage=1;
					}
					if(nextPage>pageCount){
						nextPage=pageCount;
					}
					html+="<tr><th>名称</th><th>品牌</th><th>价格</th><th>库存</th><th>销量</th>"
						+"<th>状态</th><th>大分类</th><th>小分类</th><th>图片</th><th>描述</th><th>操作</th></tr>";
					html2+="<ul>"
						 +"<li><a href=\"javascript:void(0)\" onclick='queryLike("+lastPage+")'>Prev</a></li>";	
					for(var i =0;i<pageCount;i++){
						if((i+1)==currentPage){
							html2+="<li class='active'><a href=\"javascript:void(0)\" onclick='queryLike("+(i+1)+")' >"+(i+1)+"</a></li>"	
						}
						else{
							html2+="<li><a href=\"javascript:void(0)\" onclick='queryLike("+(i+1)+")' >"+(i+1)+"</a></li>"
						}
					}
					html2+="<li><a href=\"javascript:void(0)\" onclick='queryLike("+nextPage+")'>Next</a></li>"
						 + "<ul>";
					if(data.list!=null&&data.list.length!=0){
						$.each(data.list,function(index,item){
							html+="<tr>"	
								+"<td>"+item.name+"</td>"
								+"<td>"+item.bname+"</td>"
								+"<td>"+item.price+"</td>"
								+"<td>"+item.count+"</td>"
								+"<td>"+item.sales+"</td>";
							if(item.state==1){
								html+="<td>上架</td>";
							}else{
								html+="<td>下架</td>";
							}							
							html+="<td>"+item.bigtype+"</td>"
								+"<td>"+item.smalltype+"</td>"
								+"<td>"+"<img src='upLoad/"+item.img+"'/>"+"</td>"
								+"<td>"+item.dept+"</td>"
								+"<td>"+"<a href='javascript:void(0)' style='text-decoration:none' onclick='updateGoods("+item.gid+")'>修改</a>"
								+" <a style='text-decoration:none' onclick='return confirm(\"确定删除?\");'  href='manager/deleteGoods.action?gid="+item.gid+"'>删除</a>"+"</td>"
								+"</tr>";
						});
						$("#pageSwitch").html(html2);
					}else{
						$("#pageSwitch").empty();
					}		
					$("#allGoods").html(html);					
				}
	   	 	})
		}
		function updateGoods(gid){
			$("#updateGoods").css("display","block");
			$("#allGoods").empty();
			$("#pageSwitch").empty();
			$("#addGoods").css("display","none");
			$("#updateForm").attr("action","manager/updateGoods.action?gid="+gid);
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
     	  width:60px;
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
			<li class="active">商品管理</li>
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
							<input id="name" style="height:25px;width:150px" type="text" class="input-large" placeholder="名称">
							<input id="dept" style="height:25px;width:150px" type="text" class="input-large" placeholder="描述">
							<input id="bname" style="height:25px;width:150px" type="text" class="input-large" placeholder="品牌">
							<select id="bigtype" onchange="initSmallType(0)" class="span2" style="width:80px">
							</select>
							<select id="smalltype" class="span2" style="width:80px">
								<option value=''>小分类</option>
							</select>							
							<button type="submit" class="btn btn-primary" onclick="queryLike(1)">模糊查询</button>
						</div>
					
					</div>
				
				</div>
			
			</div>
			
			<div class="span10 listing-buttons">		
					<button class="btn btn-info" onclick="selectAllGoods(1)">查询所有商品</button>		
					<button class="btn btn-primary" onclick="addGoods()">添加商品</button>
					<button class="btn btn-success">Action</button>		
			</div>
			
			<div class="row" id="addGoods" style="display:none">
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:250px">
							<h2>添加商品</h2>
						</div>								
						<form class="form-horizontal"  method="post" action="manager/addGoods.action" enctype="multipart/form-data">					
						  <div class="control-group">
						    <label class="control-label" >名称</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >价格</label>
						    <div class="controls">
						      <input name="price" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >库存</label>
						    <div class="controls">
						      <input name="count" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >品牌</label>
						    <div class="controls">
						      <input name="bname" type="text" class="input-xlarge" style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >大类</label>
						    <select name="bigtype" onchange="initSmallType(1)" id="bigtype1" class="span2" style="width:80px;margin-left:20px">
							</select>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >小类</label>						    
							<select name="smalltype" id="smalltype1" class="span2" style="width:80px;margin-left:20px">
								<option value=''>小分类</option>
							</select>	
						  </div>
						  <div class="control-group">
						    <label class="control-label">状态</label>
						    <div class="controls">
							上架 <input name="state" type="radio" value="1" checked="checked">
							下架 <input name="state" type="radio" value="0">     
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label">上传图片</label>
						    <div class="controls">
						      <input name="pic" class="input-file" type="file">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label">商品描述</label>
						    <div class="controls">
						      <textarea name="dept" class="input-xlarge" rows="3"></textarea>
						    </div>
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
			<div class="row" id="updateGoods" style="display:none">
				<div class="span5">
					<div class="slate">								
						<div class="page-header" style="margin-left:250px">
							<h2>修改商品</h2>
						</div>								
						<form id="updateForm" class="form-horizontal" action="" method="post" enctype="multipart/form-data">					
						  <div class="control-group">
						    <label class="control-label" >名称</label>
						    <div class="controls">
						      <input name="name" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >价格</label>
						    <div class="controls">
						      <input name="price" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >库存</label>
						    <div class="controls">
						      <input name="count" type="text" class="input-xlarge"  style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >品牌</label>
						    <div class="controls">
						      <input name="bname" type="text" class="input-xlarge" style="height:25px">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >大类</label>
						    <select name="bigtype" onchange="initSmallType(2)" id="bigtype2" class="span2" style="width:80px;margin-left:20px">
							</select>
						  </div>
						  <div class="control-group">
						    <label class="control-label" >小类</label>						    
							<select name="smalltype" id="smalltype2" class="span2" style="width:80px;margin-left:20px">
								<option value=''>小分类</option>
							</select>	
						  </div>
						  <div class="control-group">
						    <label class="control-label">状态</label>
						    <div class="controls">
							上架 <input name="state" type="radio" value="1" checked="checked">
							下架 <input name="state" type="radio" value="0">     
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label">上传图片</label>
						    <div class="controls">
						      <input name="pic" class="input-file" type="file">
						    </div>
						  </div>
						  <div class="control-group">
						    <label class="control-label">商品描述</label>
						    <div class="controls">
						      <textarea name="dept" class="input-xlarge" rows="3"></textarea>
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
			<table id="allGoods" class="imagetable" border="1px" cellspacing="20px"  style="margin-top:100px">
			</table>
			<div class="pagination pull-left" id="pageSwitch">						
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
				$("#bigtype").html(html);
				$("#bigtype1").html(html);
				$("#bigtype2").html(html);
				}		
			});	
	}
	function initSmallType(flag){
		var flag;
		var tid;
		if(flag==0){
			tid=$("#bigtype").val();
		}
		if(flag==1){
			tid=$("#bigtype1").val();
		}
		if(flag==2){
			tid=$("#bigtype2").val();
		}
		var html="";
		html+="<option value=''>小分类</option>";
		$.ajax({
			url:"querySmallType.action",
			data:{"tid":tid},
			dataType:"json",
			type:"post",
			success:function(data){
				$.each(data,function(index,item){
					html+="<option value='"+item.tid+"'>"
						+item.name+"</option>";
					})	
					if(flag==0){
						$("#smalltype").html(html); 
					}
					if(flag==1){
						$("#smalltype1").html(html); 
					}
					if(flag==2){
						$("#smalltype2").html(html); 
					}
				}		
			});	
		}
	initBigType();
</script>

</body>
</html>
