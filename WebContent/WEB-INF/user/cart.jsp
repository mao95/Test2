<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function(){
			init();
		$(".dot2").click(function(){
			var flag=$(this).prop("checked");
			if(flag==true){
				$(".dot1").prop("checked",true);
				$(".dot2").prop("checked",true);
			}else{
				$(".dot1").prop("checked",false);
				$(".dot2").prop("checked",false);
			}
			totalCountAndPrice();
		});
		
		$(".dot1").click(function(){
			select();
			totalCountAndPrice();
		});		
	});
	
	function init(){
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);
			var html="";
			$.each(cart,function(index,item){				
				$.ajax({
					url:"getGoods.action",
					data:{"gid":item.gid},
					type:"post",
					dataType:"json",
					async:false,
					success:function(data){
						html+="<div class=\"pic01\">"
		            		+"<input id=\""+data.gid+"single\" class=\"dot1\" type=\"checkbox\" value=\""+data.gid+"\">"
		            		+"<img src=\"upLoad/"+data.img+"\" alt=\"这是一张图片\">"
		            		+"<a href=\"product.html\"><span id=\"content\">"+data.name+data.dept+"</span></a>"
		            		+"<h3 >￥"+(data.price).toFixed(2)+"</h3>"
		            		+"<div class=\"num_down\" onclick=\"sub("+data.gid+")\">-</div>"
		            		+"<input id=\""+data.gid+"\"  type=\"tel\" onchange=\"countChange("+data.gid+")\" value=\""+item.count+"\">"
		            		+"<div class=\"num_up\" onclick=\"add("+data.gid+")\">+</div>"
		            		+"<input id=\""+data.gid+"stPrice\" type=\"hidden\" value=\""+item.count*data.price+"\" />"
		            		+"<h4 id=\""+data.gid+"tprice\">￥"+(item.count*data.price).toFixed(2)+"</h4>"
		            		+"<p onclick='deleteOne("+data.gid+")'>删除</p>"
		            		+"</div>"		            		
					}	
				});
			});	
			$(".images").html(html);
		}
	}
	
	function deleteOne(gid){
		var gid=parseInt(gid);
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);			
			var x = 0;			
			$.each(cart,function(index,item){
				if(item.gid==gid){
					x = index;
				}
			});			
			cart.splice(x, 1);			
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
		}
		init();
	}
	
	function deleteSelected(){
		var array=$(".dot1");
		$.each(array,function(index,item){
			if($(item).prop("checked")){
				deleteOne($(item).val());
			}
		});
		init();
	}
	
	function select(){
		var array=$(".dot1");
		var flag=true;
		$.each(array,function(index,item){
			if($(item).prop("checked")==false){
				flag=false;
			}
		});
		if(flag==true){
			$(".dot2").prop("checked",true);
		}else{
			$(".dot2").prop("checked",false);
		}
	}
	
	function add(gid){
		var count = parseInt($("#"+gid).val());
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
			async:false,
			dataType:"json",
			success:function(data){
				if(data.count<=0){
					$("#count").val(0);
				}else{
					if(count<data.count){
						count+=1;
					}else{
						count=data.count;
					}
					$("#"+gid).val(count);
					$("#"+gid+"tprice").text("￥"+(data.price*count).toFixed(2));
					$("#"+gid+"stPrice").val((data.price*count).toFixed(2));
					$("#"+gid+"single").prop("checked",true);
				}				
			}
		});
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);
			$.each(cart,function(index,item){
				if(item.gid==gid){
					item.count=count;
				}
			});
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
		}
		totalCountAndPrice();
		select();
	}
	
	function sub(gid){
		var count = parseInt($("#"+gid).val());
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
			async:false,
			dataType:"json",
			success:function(data){
				if(data.count<=0){
					$("#count").val(0);
				}else{
					if(count>1){
						count-=1;
					}else{
						count=1;
					}
					$("#"+gid).val(count);
					$("#"+gid+"tprice").text("￥"+(data.price*count).toFixed(2));
					$("#"+gid+"stPrice").val((data.price*count).toFixed(2));
					$("#"+gid+"single").prop("checked",true);
				}	
			}
		});	
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);
			$.each(cart,function(index,item){
				if(item.gid==gid){
					item.count=count;
				}
			});
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
		}
		totalCountAndPrice();
		select();
	}
	
	function countChange(gid){
		var count = parseInt($("#"+gid).val());
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
			async:false,
			dataType:"json",
			success:function(data){
				if(data.count<=0){
					$("#count").val(0);
				}else{
					if(count<=1){
						count=1;
					}
					if(count>=data.count){
						count=data.count;
					}
					$("#"+gid).val(count);
				}				
			}
		});
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);
			$.each(cart,function(index,item){
				if(item.gid==gid){
					item.count=count;
				}
			});
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
			$("#"+gid+"tprice").text("￥"+(data.price*count).toFixed(2));
			$("#"+gid+"stPrice").val((data.price*count).toFixed(2));
			$("#"+gid+"single").prop("checked",true);
			totalCountAndPrice();
			select();
		}
	}
	
	function totalCountAndPrice(){
		var array=$(".dot1");
		var totalCount=0;
		var totalPrice=0;
		$.each(array,function(index,item){
			if($(item).prop("checked")){
				totalCount+=parseInt($("#"+$(item).val()).val());
				totalPrice+=parseInt($("#"+$(item).val()+"stPrice").val());
			}
		});
		$("#totalCount").text(totalCount);
		$("#totalPrice").text(totalPrice.toFixed(2));
	}
	
	function pay(){
		var form=$("<form action='user/pay.action' method='post'></form>");
		var array=$(".dot1");
		var i=0;
		$.each(array,function(index,item){
			if($(item).prop("checked")){
				form.append("<input type='text' name='list["+i+"].gid' value='"+$(item).val()+"'/>");
				form.append("<input type='text' name='list["+i+"].amount' value='"+$("#"+$(item).val()).val()+"'/>");
				i++;
			}
		});
		if(i==0){
			alert("未选择商品！");
			return false;
		}
		array=$("input[type='radio']");
		$.each(array,function(index,item){
			if($(item).prop("checked")){
				form.append("<input type='text' name='aid' value='"+$(item).val()+"'/>")
			}
		});
		$(document.body).append(form);
		form.submit();
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
            <form><input id="search" type="text" value="" placeholder="搜商品"><input id="souSuo" type="submit" value="搜索"></form>
        	<c:if test="${sessionScope.user!=null }">
        		<a id="moAddress" href="javascript:void(0)" onclick="showAddress();">更改收货地址</a>
        	</c:if>  	
        </div>
     </div>
<!---content----->
    <div class="words02">
    	<input class="dot2" name="" type="checkbox" value=""><span>全选</span>
		<p>商品信息</p>
        <h1>单价</h1>
        <h2>数量</h2>
        <h3>金额</h3>
        <h4>操作</h4>
    </div>
    <div class="img">
    	<div class="images">        	
        </div>
    </div>
    <div id="showAddress">
     	<table class="dtitle" > 
     	</table>
     	<button class="back" onclick="selectAddress()">确认</button>
    </div>
    <div class="words03">
    	<input class="dot2" name="" type="checkbox" value=""><span>全选</span>
        <p onclick="deleteSelected()">删除</p>
        <h1>共有<span id="totalCount">0</span>件商品</h1>
        <h2>总计:<span id="totalPrice">￥0.00</span></h2>
        <input class="fukuan" onclick="pay()" name="去付款" type="button" value="去付款">
    </div>
<c:if test="${sessionScope.user!=null }">
	<script type="text/javascript">
	function initAddress(){
		var uid=${sessionScope.user.uid};
		var html="";	
		$.ajax({
			url:"user/showAllAddress.action",
			type:"post",
			data:{"uid":uid},
			dataType:"json",
			success:function(data){
				html+="<tr><th>选择</th><th>收货人</th><th>地址</th><th>手机号</th></tr>";
				$.each(data,function(index,item){
					html+="<tr>";
					if(index==0){
						html+="<td>"+"<input type='radio' name='aid' checked='checked' value='"+item.aid+"'/>"+"</td>";	
					}else{
						html+="<td>"+"<input type='radio' name='aid' value='"+item.aid+"'/>"+"</td>";	
					}
					html+="<td>"+item.name+"</td>"
						+"<td>"+item.address+"</td>"
						+"<td>"+item.phone+"</td>"					
						+"</tr>";
				});	
				$(".dtitle").html(html);
			}		
		});	
	}
	
	function selectAddress(){
		$("#showAddress").css("visibility","hidden");
	}
	
	function showAddress(){
		$("#showAddress").css("visibility","visible");
	}
	
	initAddress();
	</script>
</c:if>
</body>
</html>