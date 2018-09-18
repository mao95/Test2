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
<title>商品搜索</title>
<link rel="stylesheet" type="text/css" href="css/search.css" />
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script>
	
	selectAllGoods(1,0,0);
	initBigType();
	$(function(){
		 cartNum();
	})

	function selectAllGoods(currentPage,bigtype,smalltype){
		
		var name="${param.name}";
		var lastPage=currentPage-1;
		var nextPage=currentPage+1;
		var html="";	
		var html2="";
		$.ajax({
			url:"queryLike.action",
			type:"post",
			data:{"currentPage":currentPage,"pageRows":8,"name":name,"bigtype":bigtype,"smalltype":smalltype},
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
					 +"<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+lastPage+","+bigtype+","+smalltype+")'>Prev</a></li>";	
				for(var i =0;i<pageCount;i++){
					if((i+1)==currentPage){
						html2+="<li><a class='active' href=\"javascript:void(0)\" onclick='selectAllGoods("+(i+1)+","+bigtype+","+smalltype+")' >"+(i+1)+"</a></li>"	
					}
					else{
						html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+(i+1)+","+bigtype+","+smalltype+")' >"+(i+1)+"</a></li>"
					}
				}
				html2+="<li><a href=\"javascript:void(0)\" onclick='selectAllGoods("+nextPage+","+bigtype+","+smalltype+")'>Next</a></li>"
					 + "<ul>";
				$.each(data.list,function(index,item){
					html+="<div class=\"goods\">"
						+"<a href='getGoodsView.action?gid="+item.gid+"'>"
						+"<img src=\"upLoad/"+item.img+"\"/>"
						+"</a>"
						+"<span class=\"price\">￥"+item.price+"</span>"
						+"<a href='getGoodsView.action?gid="+item.gid+"'>"
						+"<span class=\"content\">"+item.name+item.dept+"</span>"
						+"</a>"
						+"<span class=\"sales\">"+"已售出"+item.sales+"</span>"
						+"</div>";
				})
				html+="<div class=\"clear\"></div>";
				$(".goodsList").html(html);
				$("#pageSwitch").html(html2);
			}
		})	
	}
	
	function initBigType(){
		var html="";
		$.ajax({
			url:"queryBigType.action",
			dataType:"json",
			type:"post",
			success:function(data){
				$.each(data,function(index,item){
					html+="<a href='javascript:void(0)' onclick='initSmallType("+item.tid+")' >"+item.name+"</a>"
				})
				$("#bigType").html(html);
			}		
		});	
	}
	function initSmallType(tid){
		selectAllGoods(1,tid,0);
		var html="";
		$.ajax({
			url:"querySmallType.action",
			data:{"tid":tid},
			dataType:"json",
			type:"post",
			success:function(data){
				$.each(data,function(index,item){
					html+="<a href='javascript:void(0)' onclick='selectAllGoods(1,"+tid+","+item.tid+");' >"+item.name+"</a>"
				})
				$("#smallType").html(html);
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
            <a href="#">客户服务</a>
            <span class="line">|</span>
            <a href="#">网站导航</a>
            <span class="line">|</span>
            <a href="#">手机京东</a>
        </div>

    </div>
    <div class="dsecond">
        <div class="dsecondimg">
            <img src="img/jdlogo.png" align="bottom">
        </div>

        <div class="dform">
            <form action="#" method="get" class="form">
                <input type="text" name="search" value="手机" />
                <input type="submit" value="搜索" />
            </form>
            <div class="indform">
                <a href="#">手机京东自营</a>
                <span class="line">|</span>
                <a href="#">华为手机</a>
                <span class="line">|</span>
                <a href="#">小米</a>
                <span class="line">|</span>
                <a href="#">华为</a>
                <span class="line">|</span>
                <a href="#">苹果</a>
                <span class="line">|</span>
                <a href="#">vivo</a>
                <span class="line">|</span>
                <a href="#">oppo</a>
                <span class="line">|</span>
                <a href="#">老人手机</a>
                <span class="line">|</span>
                <a href="#">小米8</a>
                <span class="line">|</span>
                <a href="#">三星</a>
            </div>

        </div>
        <div class="dbuy">
            <span class="buys"></span>
            <a href="getCart.action" style="text-decoration: none">我的购物车</a>
            <span id="cartNum" class="buyss">0</span>
        </div>

    </div>
    <div class="dthird">
        <div class="indthird">
            <ul>
                <li>
                    <a class="all" href="#">全部商品分类</a>
                </li>

                <li>
                    <a class="afterall" href="#">京东服饰</a>
                </li>
                <li>
                    <a class="afterall" href="#">美妆馆</a>
                </li>
                <li>
                    <a class="afterall" href="#">超市</a>
                </li>
                <li>
                    <a class="afterall" href="#">生鲜</a>
                </li>
                <li>
                    <a class="afterall" href="#">全球购</a>
                </li>
                <li>
                    <a class="afterall" href="#">闪购</a>
                </li>
                <li>
                    <a class="afterall" href="#">拍卖</a>
                </li>
                <li>
                    <a class="afterall" href="#">金融</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="dfourth">
		<a href="#">全部结果</a>
		<span>></span>
		<a href="#">手机通讯</a>
		<span>></span>
		<a href="#">手机</a>
		<span style="font-weight: bold; color: #666;">"手机"</span>
	</div>
	<div class="dfifth">
		<div class="infifone">
			<div class="head"><span style="position: relative;bottom: 45px;left: 10px;">品牌：</span></div>
			<div class="fifone">
				<div class="imgone" style="background-image: url(img/one.jpg);"></div>
				<div class="afterimgone"><a href="#">&nbsp &nbsp华为(HUAWEI)</a></div>
				<div class="imgone2" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone2"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone3" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone3"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone4" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone4"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone5" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone5"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone6" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone6"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone7" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone7"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone8" style="background-image: url(img/er.jpg);"></div>
				<div class="afterimgone8"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone1" style="background-image: url(img/one.jpg);"></div>
				<div class="afterimgone1" style="top:47px;"><a href="#">&nbsp &nbsp华为(HUAWEI)</a></div>
				<div class="imgone2" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone2" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone3" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone3" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone4" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone4" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone5" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone5" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone6" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone6" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone7" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone7" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
				<div class="imgone8" style="background-image: url(img/er.jpg);top:46px;border-top-width: 0px;"></div>
				<div class="afterimgone8" style="top:47px;"><a href="#">&nbsp &nbsp &nbsp &nbsp小米(MI)</a></div>
			</div>
		</div>
		<div class="fiftwo">
			<div class="head"><span style="position: relative;left: 10px;">大分类:</span></div>
			<div id="bigType" class="fifbody"><a></a></div>
		</div>
		<div class="fiftwo">
			<div class="head"><span style="position: relative;left: 10px;">小分类:</span></div>
			<div id="smallType" class="fifbody"><a></a></div>
		</div>		
	</div>
	<div class="goodsList">		
	</div>
	<div id="pageSwitch">						
	</div>

</body>

</html>