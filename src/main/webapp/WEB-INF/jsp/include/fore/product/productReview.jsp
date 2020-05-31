<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<!-- 传来当前产品p、产品下的属性<-属性值列表pvs、详情图片列表、单个图片列表、评论数、销量、评论列表reviews -->

<!-- 	累积评价 -->
<div class="productReviewDiv" style="display: block;">
<!-- 		标题 -->
	<div class="productReviewTopPart">
		<a class="productReviewTopPartSelectedLink" href="#nowheretogo">商品详情</a>
		<a class="selected" href="#nowheretogo">累计评价 <span class="productReviewTopReviewLinkNumber">${p.reviewCount}</span> </a>
	</div>
<!-- 			评价 -->
	<div class="productReviewContentPart">
		   <c:forEach items="${reviews}" var="r" varStatus="st">
	<!-- 			每条评价 -->
			<div class="productReviewItem">
	<!-- 				评价描述 -->
				<div class="productReviewItemDesc">
	<!-- 					评价内容 -->
					<div class="productReviewItemContent">${r.content}</div>
	<!-- 					评价时间 -->
					<div class="productReviewItemDate">
						<fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
	<!-- 				评价人 -->
				<div class="productReviewItemUserInfo">
					  ${r.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
				</div>
	<!-- 				清除样式  -->
				<div style="clear:both"></div>
			</div>
		  </c:forEach>
	</div>
</div>
