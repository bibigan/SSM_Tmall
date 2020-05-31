<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

	<img src="img/site/catear.png" class="catear" id="catear"><!-- 猫耳朵 -->
	<div class="categoryWithCarousel">
		<div class="headbar">
			<div class="head">
				<span class="glyphicon glyphicon-th-list" style="margin-left:10px"></span>
				<span>商品分类</span>
			</div>
			<div class="menu">
				<span><a href="#nowhere"><img src="img/site/chaoshi.png"></a></span>
				<span><a href="#nowhere"><img src="img/site/guoji.png"></a></span>
				<c:forEach items="${cs}" var="c" varStatus="i">
					<c:if test="${i.count<=4}">
						<span><a href="forecategory?cid=${c.id}">${c.name}</a></span>
					</c:if>
			     </c:forEach>
			</div>
		</div><!--导航 -->
		<div style="clear:both"></div>
<!-- 		分类、产品列表 -->
		 <div style="position: relative">
    		<%@include file="categoryMenu.jsp" %>
		</div style="position: relative">
<!-- 		 轮播 -->
		<%@include file="carousel.jsp" %>
		 
		<div class="carouselBackgroundDiv"></div>  
	</div>