<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="categoryPageDiv">

		<img src="img/category/${c.id}.jpg">
		
		<!-- 搜索条 -->
		<div class="categorySortBar">
			<table class="categorySortBarTable">
				<tr><!-- 行 -->
<!-- 				根据sort参数判断哪个排序按钮高亮 -->
					<td <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if> >
						<a href="?cid=${c.id}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
					<td <c:if test="${'review'==param.sort}">class="grayColumn"</c:if> >
						<a href="?cid=${c.id}&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
					<td <c:if test="${'date'==param.sort}">class="grayColumn"</c:if>>
						<a href="?cid=${c.id}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
					<td <c:if test="${'saleCount'==param.sort}">class="grayColumn"</c:if>>
						<a href="?cid=${c.id}&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
					<td <c:if test="${'price'==param.sort}">class="grayColumn"</c:if>>
						<a href="?cid=${c.id}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
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
		
		<!-- 产品列表 -->
<!-- 		通过forEach遍历c.products集合里的每个产品，并把产品标题，价格，图片，评价数，成交数打印出来 -->
		<div class="categoryProduct">
			<c:forEach items="${c.products}" var="p" varStatus="st">
<!-- 		        每个产品 -->
				<div data-price="${p.promotePrice}" class="productUnit" price="${p.promotePrice}">
					<div class="productUnitFrame">
						<a href="foreproduct?pid=${p.id}"><img width="100px" class="productImage" src="img/productSingle_middle/${p.firstProductImage.id}.jpg"></a>
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
		<div style="clear:both"></div>
		</div>
	</div>