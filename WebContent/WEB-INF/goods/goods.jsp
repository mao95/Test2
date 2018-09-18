<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ; 
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>
<link rel="stylesheet" type="text/css" href="css/jd.css"/>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function(){
		var gid=${param.gid};
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
			dataType:"json",
			success:function(data){
				$("#name").text(data.name);
				$("#dept").text(data.dept);
				$("#price").text("￥"+data.price);
				$("#img").attr("src","upLoad/"+data.img);
				if(data.count==0){
					$("#count").val(0);
				}
			}	
		});
		cartNum();
	});
	
	function inCart(){
		var gid=${param.gid};
		var count=$("#count").val();
		if(count==0){
			alert("未选择商品！");
			return false;
		}
		var cart=$.cookie("cart");
		if(cart==undefined){
			cart= new Array();
			goods= new Object();
			goods.gid=gid;
			goods.count=count;
			cart.push(goods);
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
		}else{
			cart= JSON.parse(cart);
			var flag=false;
			$.each(cart,function(index,item){				
				if(item.gid==gid){
					item.count=parseInt(item.count)+parseInt(count);
					flag=true;					
					return false;
				}
			});
			if(flag==false){
				goods= new Object();
				goods.gid=gid;
				goods.count=count;
				cart.push(goods);				
			}
			cart=JSON.stringify(cart);
			$.cookie("cart",cart,{expires:7});
		}
		cartNum();
		alert("加入成功！");
	}
	
	function add(){
		var count = parseInt($("#count").val());
		var gid=${param.gid};
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
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
					$("#count").val(count);
				}				
			}
		});	
	}
	
	function sub(){
		var count = parseInt($("#count").val());
		var gid=${param.gid};
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
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
					$("#count").val(count);
				}	
			}
		});	
	}
	
	function countChange(){
		var count = parseInt($("#count").val());
		var gid=${param.gid};
		$.ajax({
			url:"getGoods.action",
			data:{"gid":gid},
			type:"post",
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
					$("#count").val(count);
				}				
			}
		});	
	}
	
	function cartNum(){
		var cart=$.cookie("cart");
		if(cart!=undefined){
			cart=JSON.parse(cart);
			var sum=0;
			$.each(cart,function(index,item){
				sum+=parseInt(item.count);
			});
			$("#cartNum").text(sum);
		}
	}
	
</script>
</head>
	<body>
		<div class="dtop">
			<div class="dtopm">
				<ul>
					<li>送至：北京</li>
				</ul>
				<c:if test="${sessionScope.user==null }">
					<a href="login.jsp">您好，请登录</a>
					<a href="register.jsp" style="color: #f10215;margin-left: 5px;">免费注册</a>
				</c:if>
				<c:if test="${sessionScope.user!=null }">
					<a href="#">您好，${sessionScope.user.username }</a>
					<a href="user/exit.action" style="color: #f10215;margin-left: 5px;">退出</a>
				</c:if>
				<a href="user/orderView.action">我的订单</a>
				<span class="line">|</span>
				<a href="user/indexView.action">我的京东</a>
				<span class="line">|</span>
				<a href="#">京东会员</a>
				<span class="line">|</span>
				<a href="#">企业采购</a>
				<span class="line">|</span>
				<span class="smallphone"></span>
				<a href="#">手机京东</a>
				<span class="line">|</span>
				<a href="#">关注京东</a>
				<span class="line">|</span>
				<a href="#">客户服务</a>
				<span class="line">|</span>
				<a href="#">网站导航</a>
			</div>
			
		</div>
		<div class="dsecond">
			<div class="dsecondimg">
				<img src="img/jdlogo.png" align="bottom" >	
			</div>
			<a href="#" style="text-decoration: none;">全部分类</a>	
			<div class="dform">
				<form action="#" method="get" class="form">
				<input type="text" name="search" value="京东" /><input type="submit" value="搜全站"/><input type="submit" value="搜本店"/>
			    </form>
				<div>
					<a href="#" style="text-decoration: none;">企业购</a>
					<a href="#" style="text-decoration: none;">企业信贷</a>
					<a href="#" style="text-decoration: none;">直邮全球</a>
					<a href="#" style="text-decoration: none;">企悦服务</a>
					<a href="#" style="text-decoration: none;">办公清洁</a>
				</div>
				
			</div>
			<div class="dbuy" >
				<span class="buys"></span>
				<a href="getCart.action" style="text-decoration: none;">我的购物车</a>
				<span class="buyss" id="cartNum">0</span>
			</div>
			
		</div>
		<div class="dthird">	
		</div>
		<div class="dfourth">
			<div class="dfourthd">
				<ul class="dfourthul">
					<li class="dfourthlii">
						<a class="liaa" href="#"><span>查看所有商品</span></a>
						<ul class="uall">
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall" >
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
							<li class="liall">
								<a href="#" class="aa">Mate系列</a>
								<a href="#" class="aaa">HUAWEI Mate 10</a>
								<a href="#" class="aaa">HUAWEI Mate 10 Pro</a>
								<a href="#" class="aaa">HUAWEI Mate 9</a>
								<a href="#" class="aaa">HUAWEI Mate 9 Pro</a>
							</li>
						</ul>
					</li>
					<li class="dfourthli1">
						<a class="lia" href="#"><span>首页</span></a>
						
					</li>
					<li class="dfourthli2">
						<a class="lia" href="#"><span>Mate系列</span></a>
						<ul class="photo2">
							<li>
								<a href="#" style="padding-left: 100px;"><img src="img/11.png"></a>
								<a href="#"><img src="img/2.png" ></a>
								<a href="#"><img src="img/3.png" ></a>
								<a href="#"><img src="img/4.png" ></a>
							</li>
							
						</ul>
					</li>
					<li class="dfourthli3">
						<a class="lia" href="#"><span>P系列</span></a>
					</li>
					<li class="dfourthli4">
						<a class="lia" href="#"><span>nova/麦芒系列</span></a>
					</li>
					<li class="dfourthli5">
						<a class="lia" href="#"><span>畅享系列</span></a>
					</li>
					<li class="dfourthli6">
						<a class="lia" href="#"><span>穿戴设备</span></a>
					</li>
					<li class="dfourthli7">
						<a class="lia" href="#"><span>平板/笔记本</span></a>
					</li>
					<li class="dfourthli8">
						<a class="lia" href="#"><span>智能家居</span></a>
					</li>
					<li class="dfourthli9">
						<a class="lia" href="#"><span>配件</span></a>
					</li>
				</ul>
				
			</div>
			
		</div>
		<div class="dfifth">
			<div class="indfifth">
				<div>
					<a class="aa" href="#">手机</a>
					<span>></span>
					<a class="aa" href="#">手机通讯</a>
					<span>></span>
					<a class="aa" href="#">手机</a>
					<span>></span>
					<a class="aa" href="#">手机</a>
					<span>华为（HUAWEI）</span>
					<span>></span>
					<span>华为mate9 pro</span>
					<a class="jd" href="#">JD</a>
					<a class="jdz" href="#">自营</a>
				</div>
			</div>
		</div>
		<div class="erweima">
			<span class="e">使用京东APP</span>
			<br>
			<span class="ee">随时随地看商品</span>
			<br>
			<img src="img/2wm.png" >
			<a class="close">X</a>
			
		</div>
		<div class="d1">
			<p id="name"></p>
			<span id="dept" class="d1s"></span>
			<a class="d1a" href="#">华为新品全面上线，更多优惠猛戳》》</a>
			<div class="d2" >
				<span class="d2s">京 东 价</span>
				<b id="price"></b>
				<a href="#">降价通知</a>
				<div class="d3">
					<span>累计评价</span>
					<br>
					<a style="color: #005ea7;font-size: 12px; text-decoration: none;" href="#" >7.6万+</a>
				</div>
				<br/>
				<span class="d2s">促销</span>
				<span class="d2ss">满送</span>
				<a>满19元即赠热销商品，赠完即止 详情 >></a>
				<br>
				
				<span class="d2ss" style="margin-left: 29px;">满送</span>
				<a>满19元即赠热销商品，赠完即止 详情 >></a>
				<br>
				<span class="d2sss">“满送” 仅可在购物车任选其一</span>
				</div>
				
				<span class="d2s">增值业务</span>
				<br>
				<span class="d2s">配 送 至</span>
				<br>
				<span class="d2s">重　　量</span>
				<span style="font-size: 12px;color: #666;">0.55kg</span>
				<hr />
				<div >
				<span class="d2s">选择颜色</span>
				<a href="#" ><img src="img/TIM图片20180621213019.png" align="center" class="img"></a>
				<a href="#" ><img src="img/TIM图片20180621213022.png" align="center" class="img"></a>
				<a href="#" ><img src="img/TIM图片20180621193244.png" align="center" class="img"></a>
				</div>
				<div style="margin-top: 6px;">
				<span class="d2s">选择版本</span>
				<span class="span">64GB</span>
				<span class="span">128GB</span>
				</div>
				<div style="margin-top: 14px;">
				<span class="d2s">套　　装</span>
				<span class="span">优惠套装1</span>
				<span class="span">优惠套装2</span>
				<span class="span">优惠套装3</span>
				<span class="span">优惠套装4</span>
				<span class="span">优惠套装5</span>
				<span class="span">优惠套装6</span>
				</div>
				<div style="margin-top: 14px;">
				<span class="d2s">增值保障</span>
				<span class="span">全保修2年 ￥229</span>
				<span class="span">碎屏保2年 ￥159</span>
				<span class="span">自营延长保 ￥129</span>
				</div>
				<div style="margin-top: 14px;">
				<span class="d2s">京东服务</span>
				<span class="span">特色服务</span>
				<span class="span">原厂服务</span>
				</div>
                <div style="margin-top: 14px;">
				<span class="d2s">白条分期</span>
				<span class="span">不分期</span>
				<span class="span">￥1066.33×3期</span>
				<span class="span">￥533.17×6期</span>
				<span class="span">￥274.58×12期</span>
				<span class="span">￥149.29×24期</span>
				</div>
				<hr />
				<div style="margin-top: 10px;position:relative">
				<input id="count" name="count" type="text" value="1" onchange="countChange()">
				<a id="add" href="javascript:void(0)" onclick="add()">+</a>
				<a id="sub" href="javascript:void(0)" onclick="sub()">-</a>
				<a href="javascript:void(0)" onclick="inCart()" class="buy">加入购物车</a>
				</div>
				<div style="margin-top: 10px;">
				<span class="end">温馨提示·支持7天无理由退货</span>
				</div>
		</div>	
		<img id="img" src="" style="margin-left: 100px;width:450px">
				
	</body>
</html>