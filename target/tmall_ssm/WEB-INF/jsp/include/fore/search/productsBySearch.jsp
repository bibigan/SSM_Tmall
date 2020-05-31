<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<div class="searchProducts">

	<!-- 搜索条 -->
	<div class="categorySortBar">
		<table class="categorySortBarTable">
			<tr><!-- 行 -->
				<!-- 				根据sort参数判断哪个排序按钮高亮 -->
				<td <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if> >
					<a href="?keyword=${keyword}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
				<td <c:if test="${'review'==param.sort}">class="grayColumn"</c:if> >
					<a href="?keyword=${keyword}&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
				<td <c:if test="${'date'==param.sort}">class="grayColumn"</c:if>>
					<a href="?keyword=${keyword}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
				<td <c:if test="${'saleCount'==param.sort}">class="grayColumn"</c:if>>
					<a href="?keyword=${keyword}&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
				<td <c:if test="${'price'==param.sort}">class="grayColumn"</c:if>>
					<a href="?keyword=${keyword}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
			</tr>
		</table>
		<table class="categorySortBarTable">
			<tr>
				<td><input type="text" placeholder="请输入" class="sortBarPrice beginPrice"></td>
				<td class="mark">-</td>
				<td><input type="text" placeholder="请输入" class="sortBarPrice endPrice"></td>
			</tr>
		</table>
	</div>

    <c:forEach items="${ps}" var="p" varStatus="st">
<!-- 		        每个产品 -->
				<div data-price="${p.promotePrice}" class="productUnit" price="${p.promotePrice}">
					<div class="productUnitFrame">
						<a href="foreproduct?pid=${p.id}">
							<img class="productImage" src="img/productSingle/${p.firstProductImage.id}.jpg">
						</a>
						<span class="productPrice">¥
							<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
						</span>
						<a href="foreproduct?pid=${p.id}" class="productLink"> ${fn:substring(p.name, 0, 50)}</a>
						<a  class="tmallLink" href="foreproduct?pid=${p.id}">天猫专卖</a>
						<div class="show1 productInfo">
							<span class="monthDeal">月成交<span class="productDealNumber">${p.saleCount}笔</span></span>
							<span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
							<span class="wangwang"><a href="#nowhere" class="wangwanglink"><img alt="" src="img/site/wangwang.png"></a></span>
						</div>
					</div>
				</div>
	</c:forEach>
    <c:if test="${empty ps}">
        <div class="noMatch">没有满足条件的产品<div>
    </c:if>
     
        <div style="clear:both"></div>
</div>