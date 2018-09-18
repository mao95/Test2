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
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="css/jingdong.css"/>
		<script src="js/jquery-2.2.4.min.js"></script>
		<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		<script type="text/javascript">
			var index=1;
			var count=1;
			var hour=12;
			var minute=59;
			var second=59;
			$(function(){				
				setInterval("interval()",1000);				
				$(".dthirtwo img").fadeOut();
				$(".dthirtwo img[src='img/dy1.jpg']").fadeIn(1000);
				var temp=setInterval("nextImg()",2000);
//				$(".dthirtwo #last").click("lastImg()");
//				$(".dthirtwo #next").click("nextImg()");
                $(".dthirtwo").mouseover(function(){
                	clearInterval(temp);
                })
                $(".dthirtwo").mouseout(function(){
                	temp=setInterval("nextImg()",2000);
                })
                cartNum();
			});
			function showImg(num){
					$(".dthirtwo img").fadeOut();
					if(num==1)$(".dthirtwo img[src='img/dy1.jpg']").fadeIn(1000);
					if(num==2)$(".dthirtwo img[src='img/dy2.jpg']").fadeIn(1000);
					if(num==3)$(".dthirtwo img[src='img/dy3.jpg']").fadeIn(1000);
					if(num==4)$(".dthirtwo img[src='img/dy4.jpg']").fadeIn(1000);
					shine(num);
			}
			function shine(num){
				    $(".dypoint i").css({"background-color":"","box-shadow":""});
				    if(num==1)$(".dypoint i[onmouseover='showImg(1)']").css({"background-color":"white","box-shadow":"0px 0px 0px 4px rgba(0,0,0,0.3)"});
				    if(num==2)$(".dypoint i[onmouseover='showImg(2)']").css({"background-color":"white","box-shadow":"0px 0px 0px 4px rgba(0,0,0,0.3)"});
				    if(num==3)$(".dypoint i[onmouseover='showImg(3)']").css({"background-color":"white","box-shadow":"0px 0px 0px 4px rgba(0,0,0,0.3)"});
				    if(num==4)$(".dypoint i[onmouseover='showImg(4)']").css({"background-color":"white","box-shadow":"0px 0px 0px 4px rgba(0,0,0,0.3)"});
				    
			}
			
			function interval(){
				if(hour<10){
					$("#hour").text("0"+hour);
				}else{
					$("#hour").text(hour);
				}
				if(minute<10){
					$("#minute").text("0"+minute);
				}else{
					$("#minute").text(minute);
				}
				if(second<10){
					$("#second").text("0"+second);
				}else{
					$("#second").text(second);
				}	
				second--;
				if(second<0){
					second=59;
					minute--;
					if(minute<0){
						minute=59;
						hour--;
						if(hour<0){
							hour=12;
						}
					}
				}		
			}
			function nextImg(){
					index++;
					if(index>4){
						index=1;
					}
					showImg(index);
					shine(index);
			}
			function lastImg(){
					index--;
					if(index<1){
						index=4;
					}
					showImg(index);
					shine(index);
			}
			function rightmove(){
				if(count==1){
					$(".dfourthtwo .grouptwo").animate({"left":"-1520px"},1000,function(){
						 $(".dfourthtwo .grouptwo").css({"left":"760px"});
					});
				    $(".dfourthtwo .groupone").animate({"left":"-760px"},1000);
				    $(".dfourthtwo .groupthree").animate({"left":"0px"},1000);	
				   count=3;
				   return false;
				}
				if(count==3){
					$(".dfourthtwo .groupone").animate({"left":"-1520px"},1000,function(){
						 $(".dfourthtwo .groupone").css({"left":"760px"});
					});
				    $(".dfourthtwo .grouptwo").animate({"left":"0px"},1000);
				    $(".dfourthtwo .groupthree").animate({"left":"-760px"},1000);
				    count=2;
				    return false;
				}
				if(count==2){
					$(".dfourthtwo .groupthree").animate({"left":"-1520px"},1000,function(){
						 $(".dfourthtwo .groupthree").css({"left":"760px"});
					});
				    $(".dfourthtwo .grouptwo").animate({"left":"-760px"},1000);
				    $(".dfourthtwo .groupone").animate({"left":"0px"},1000);
				    count=1;
				    return false;
				}
			}
			function leftmove(){
				if(count==1){
					$(".dfourthtwo .groupthree").animate({"left":"1520px"},1000,function(){
						 $(".dfourthtwo .groupthree").css({"left":"-760px"});
					});
				    $(".dfourthtwo .groupone").animate({"left":"760px"},1000);
				    $(".dfourthtwo .grouptwo").animate({"left":"0px"},1000);	
				   count=2;
				   return false;
				}
				if(count==3){
					$(".dfourthtwo .grouptwo").animate({"left":"1520px"},1000,function(){
						 $(".dfourthtwo .grouptwo").css({"left":"-760px"});
					});
				    $(".dfourthtwo .groupthree").animate({"left":"760px"},1000);
				    $(".dfourthtwo .groupone").animate({"left":"0px"},1000);
				    count=1;
				    return false;
				}
				if(count==2){
					$(".dfourthtwo .groupone").animate({"left":"1520px"},1000,function(){
						 $(".dfourthtwo .groupone").css({"left":"-760px"});
					});
				    $(".dfourthtwo .grouptwo").animate({"left":"760px"},1000);
				    $(".dfourthtwo .groupthree").animate({"left":"0px"},1000);
				    count=3;
				    return false;
				}
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
		<title></title>
	</head>
	<body>
		<div class="navbg">
			<div class="nav">
				<div class="navleft">
					<ul class="outul">
						<li>
							<span class="glyphicon glyphicon-map-marker" id="navpo"><span>北京</span></span>
							<ul class="inul">
								<li><a>北京</a><a>上海</a><a>天津</a><a>河北</a><a>重庆</a></li>
								<li><a>北京</a><a>上海</a><a>天津</a><a>河北</a><a>重庆</a></li>
								<li><a>北京</a><a>上海</a><a>天津</a><a>河北</a><a>重庆</a></li>
								<li><a>北京</a><a>上海</a><a>天津</a><a>河北</a><a>重庆</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="navright">
					<c:if test="${sessionScope.user==null }">
						<a href="login.jsp">您好，请登录</a>
						<a href="register.jsp" style="color: #f10215;margin-left: 5px;">免费注册</a>
					</c:if>
					<c:if test="${sessionScope.user!=null }">
						<a href="#">您好，${sessionScope.user.username }</a>
						<a href="user/exit.action" style="color: #f10215;margin-left: 5px;">退出</a>
					</c:if>					
					<span class="line">|</span>
					<a href="user/orderView.action">我的订单</a>
					<span class="line">|</span>
					<a href="user/indexView.action">我的京东</a>
					<span class="line">|</span>
					<a href="#">京东会员</a>
					<span class="line">|</span>
					<a href="#">企业采购</a>
					<span class="line">|</span>
					<span>客户服务</span>
					<span class="line">|</span>
					<span>网站导航</span>
					<span class="line">|</span>
					<span>手机京东</span>
				</div>
				<div class="cleardiv"></div>
			</div>
			
		</div>
		<div class="dsec">
			<div class="logoimg"></div>
			<div class="secmid">
				<div class="search">
				<form action="search.action">
					<div class="searchgroup">						
						<input type="text" name="name" class="searchinput"/>						
					</div>
					<button type="submit" class="glyphicon glyphicon-search" id="searimg"></button>
				</form>
					<div class="undertext">
						<a href="#" class="unae">全国联保</a>
						<a href="#" class="una">全国联保</a>
						<a href="#" class="una">全国联保</a>
						<a href="#" class="una">全国联保</a>
						<a href="#" class="una">全国联保</a>
						<a href="#" class="una">全国联保</a>
						<a href="#" class="una">全国联保</a>
					</div>
				</div>
				<div class="cartgroup">
					<span class="glyphicon glyphicon-shopping-cart"></span>
					<a href="getCart.action">我的购物车</a>
					<span class="bubble" id="cartNum">0</span>
				</div>
				<div class="undermenu">
					<a href="#">秒杀</a>
					<a href="#">优惠券</a>
					<a href="#">PLUS会员</a>
					<a href="#">闪购</a>
					<a href="#">拍卖</a>
					<a href="#">京东服饰</a>
					<a href="#">京东超市</a>
					<a href="#">生鲜</a>
					<a href="#">全球购</a>
					<a href="#">京东金融</a>
				</div>
			</div>
		</div>
		<div class="dthir">
			<div class="dthirone">
			<ul class="outul">
				<li>
					<a href="javascript:void(0)">家用电器</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">手机/运营商/数码</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">电脑/办公</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">家居/家具</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">男装/女装/童装</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">美妆/清洁/宠物</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">男鞋/运动/户外</a>
					<ul class="inul">
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">房产/汽车/汽车用品</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">母婴/玩具乐器</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">食品/酒类/生鲜/特产</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">医药保健/计生情趣</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">图书/音像/电子书</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">艺术/礼品鲜花</a>
					<ul class="inul">
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
						<li><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a><a>家用电器</a></li>
					</ul>
				</li>
			</ul>
		    </div>
		    <div class="dthirtwo">
		    	<a href="#"><img src="img/dy1.jpg"/></a>
		    	<a href="#"><img src="img/dy2.jpg"/></a>
		    	<a href="#"><img src="img/dy3.jpg"/></a>
		    	<a href="#"><img src="img/dy4.jpg"/></a>
		    	<button class="glyphicon glyphicon-chevron-left" id="last" onclick="lastImg()"></button>
		    	<button class="glyphicon glyphicon-chevron-right" id="next" onclick="nextImg()"></button>
		    	<div class="dypoint">
		    		<i onmouseover="showImg(1)"></i>
		    		<i onmouseover="showImg(2)"></i>
		         	<i onmouseover="showImg(3)"></i>
		    	    <i onmouseover="showImg(4)"></i>
		    	</div>
		    </div>
		    <div class="dthirthree">
		    	<a href="#"><img src="img/group1.jpg"/></a>
		    	<a href="#"><img src="img/group2.jpg"/></a>
		    	<a href="#"><img src="img/group3.jpg"/></a>
		    </div>
		</div>
		<div class="dfourth">
			<div class="dfourthone">
				<a class="outa">
					<div class="firline">京东秒杀</div>
					<div class="secline">FLASH DEALS</div>
					<i class="glyphicon glyphicon-flash"></i>
					<div class="thirline">本场距离结束还剩</div>
					<div class="time">
						<span id="hour"></span>
						<span id="minute"></span>
						<span id="second"></span>
					</div>					
				</a>
			</div>
			
			<div class="dfourthtwo">
				<div class="groupone">
					<div class="imgone"><img src="img/11.webp"/></div>
					<div class="imgtwo"><img src="img/12.webp"/></div>
					<div class="imgthree"><img src="img/13.webp"/></div>
					<div class="imgfour"><img src="img/14.webp"/></div>	
				</div>
				<div class="grouptwo">
					<div class="imgone"><img src="img/21.webp"/></div>
					<div class="imgtwo"><img src="img/22.webp"/></div>
					<div class="imgthree"><img src="img/23.webp"/></div>
					<div class="imgfour"><img src="img/24.webp"/></div>	
				</div>
				<div class="groupthree">
					<div class="imgone"><img src="img/31.webp"/></div>
					<div class="imgtwo"><img src="img/32.webp"/></div>
					<div class="imgthree"><img src="img/33.webp"/></div>
					<div class="imgfour"><img src="img/34.webp"/></div>	
				</div>
				<button class="glyphicon glyphicon-chevron-left" id="lastgroup" onclick="rightmove()"></button>
		    	<button class="glyphicon glyphicon-chevron-right" id="nextgroup" onclick="leftmove()"></button>
			</div>
		</div>
		
	</body>
</html>
