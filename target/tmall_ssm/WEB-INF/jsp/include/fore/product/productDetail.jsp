<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<!-- 传来当前产品p、产品下的属性<-属性值列表pvs、详情图片列表、单个图片列表、评论数、销量、评论列表reviews -->

<div class="productDetailDiv" >
	<div class="productDetailTopPart">
		<a href="#nowheretogo" class="productDetailTopPartSelectedLink selected">商品详情</a>
		<a href="#nowheretogo" class="productDetailTopReviewLink" >累积评价
		<span class="productDetailTopReviewLinkNumber">${p.reviewCount}</span></a>
	</div>
	<!--  显示属性值 -->
	<div class="productParamterPart">
		<div class="productParamter">产品参数:</div>
		<div class="productParamterList">
		  <c:forEach items="${pvs}" var="pv" varStatus="st">
			<span>${pv.property.name}:  ${pv.value}</span>
           </c:forEach> 
		</div>
	</div>
	<div style="clear:both"></div>
	<!--  显示详情图片 -->
	<div class="productDetailImagesPart">
		<c:forEach items="${p.productDetailImages}" var="pi">
                <img src="img/productDetail/${pi.id}.jpg">
        </c:forEach>
	</div>
</div>