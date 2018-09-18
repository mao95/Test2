<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE >
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理</title>
<link rel="stylesheet" type="text/css" href="css/orders.css">
<script src="js/jquery-2.2.4.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<c:if test="${requestScope.list!=null }">
	<script>
		function clearCart(){
			var list=${requestScope.list};
			var cart=$.cookie("cart");
			cart=JSON.parse(cart);
			$.each(list,function(index1,item1){
				var x=0;
				$.each(cart,function(index2,item2){
					if(item1==item2.gid){
						x=index2;
					}
				});
				cart.splice(x,1);
			});
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7,path:"/b2cc"});
		}
		clearCart();
	</script>
</c:if>
<script>
	$(function(){
		getOrder(1);
	});
	
	function getOrder(currentPage){
		var lastPage=currentPage-1;
		var nextPage=currentPage+1;
		var html="";	
		var html2="";
		$.ajax({
			url:"user/getOrder.action",
			type:"post",
			data:{"currentPage":currentPage,"pageRows":6},
			dataType:"json",
			success:function(data){
				var pageCount=data.pageCount;
				if(lastPage<1){
					lastPage=1;
				}
				if(nextPage>pageCount){
					nextPage=pageCount;
				}
				html2+="<ul class='pageButton'>"
					 +"<li><a href=\"javascript:void(0)\" onclick='getOrder("+lastPage+")'>Prev</a></li>";	
				for(var i =0;i<pageCount;i++){
					if((i+1)==currentPage){
						html2+="<li><a class='active' href=\"javascript:void(0)\" onclick='getOrder("+(i+1)+")' >"+(i+1)+"</a></li>"	
					}
					else{
						html2+="<li><a href=\"javascript:void(0)\" onclick='getOrder("+(i+1)+")' >"+(i+1)+"</a></li>"
					}
				}
				html2+="<li><a href=\"javascript:void(0)\" onclick='getOrder("+nextPage+")'>Next</a></li>"
					 + "<ul>";
				if(data.list!=null&data.list.length!=0){
					$.each(data.list,function(index,item){
						html+="<div class=\"pic01\">"
				    		  +"<span class=\"pone\">"+item.onumber+"</span>"
				    		  +"<span class=\"pone1\">"+item.time+"</span>"
				    		  +"<span class=\"ptwo\">￥"+item.totalPrice.toFixed(2)+"</span>"
				    		  +"<span class=\"pthree\">￥"+item.totalPrice.toFixed(2)+"</span>"      
				    		  +"<div class=\"box03\">"
				    		  +"<p>已发货</p>"
				    		  +"<a href=\"javascript:void(0)\" onclick=\"showDetails('"+item.onumber+"')\"><h1>订单详情</h1></a>"
				    		  +"<a href=\"javascript:void(0)\"><h1>查看物流</h1></a>"
				    		  +"</div>"
				    		  +"<input class=\"shouhuo\" type=\"button\" value=\"确认收货\">"  
				    		  +"</div>";
					});
					$("#pageSwitch").html(html2);
				}else{
					$("#pageSwitch").empty();
				}				
				$("#content").html(html);				
			}
		})	
	}
	
	function showDetails(onumber){
		$.ajax({
			url:"user/getOneOrder.action",
			type:"post",
			data:{"onumber":onumber},
			dataType:"json",
			success:function(data){
				html="";
				$.each(data.list,function(index,item){
					html+="<tr>"
						+"<td>"+"<img src='upLoad/"+item.img+"'/>"+"</td>"
						+"<td>"+item.gname+"</td>"
						+"<td>"+item.singlePrice.toFixed(2)+"</td>"
						+"<td>"+item.amount+"</td>"
						+"<td>"+item.totalPrice.toFixed(2)+"</td>"
						+"</tr>";					
				});
				$("#body").html(html);
				$("#receiver1").html(data.address.name);
				$("#receiver2").html(data.address.phone);
				$("#receiver3").html(data.address.address);
				$("#details").css("visibility","visible");
			}
		});
	}
	
	function back(){
		$("#details").css("visibility","hidden");
	}
</script>
</head>
<body>
<!---head--------->
	<div class="header">
    	<div class="box">
        	<div class="title">
                <img class="images01" src="img/logo01.jpg" alt="这是一张图片">
                <a href="index.jsp"><div>商城首页</div></a>
                <c:if test="${sessionScope.user!=null }">
                 	<a href="user/indexView.action"><p><span>您好,${sessionScope.user.username}</span></p></a>
                </c:if>
                <c:if test="${sessionScope.user!=null }">
                 	<a href="user/exit.action"><p>退出</p></a>
                </c:if>
                <c:if test="${sessionScope.user==null }">
                 	<a href="login.jsp"><p><span>您好,请登录</span></p></a>
                </c:if>
                <c:if test="${sessionScope.user==null }">
                 	<a href="register.jsp"><p>免费注册</p></a>
                </c:if>  
                <a href="user/orderView.action"><p><img src="img/logo02.jpg">我的订单</p></a>
                <a href="getCart.action"><p><img src="img/logo03.jpg">购物车</p></a>
            </div>
        </div>
		<div class="logoCon">
            <form><input id="search" type="text" value="" placeholder="输入你想要的商品"><input id="souSuo" type="submit" value="搜索"></form>
        </div>
	</div>
<!---content------->
	
		<div class="title01">
	    	<h3>订单编号</h3>
	    	<h1>成交时间</h1>
	        <h2>总价（元）</h2>
	        <h2>实付款</h2>
	        <h2>交易状态</h2>  
	        <h2>操作</h2>
	    </div>
		<!-----01------>
	  <div id="content">  
	       
	</div>
	<div id="pageSwitch">						
	</div>
    <div id="details">
     	<table class="dtitle" > 
     		<thead id="head">
	     		<tr>
		     		<th>图片</th>
		     		<th>商品名称</th>
		     		<th>单价</th>
		     		<th>数量</th>
		     		<th>总计</th>
	     		</tr>
	     	</thead>
	     	<tbody id="body">
	     	</tbody>
     	</table>
     	<div id="receiver">
     		<label>收货人:</label>
     		<span id="receiver1"></span>
     		<label>手机号码:</label>
     		<span id="receiver2"></span>
     		<label>收货地址:</label>
     		<span id="receiver3"></span>
     	</div>
     	<button class="back" onclick="back()">返回</button>
    </div>
  

</body>
</html>