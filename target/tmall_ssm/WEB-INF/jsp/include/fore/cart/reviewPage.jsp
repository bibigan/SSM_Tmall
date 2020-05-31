<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 传参p\o\reviews -->

<div class="reviewPagewDiv">
		<div class="reviewImg"><img src="img/productSingle/${p.firstProductImage.id}.jpg" width="400px"></div>
		<div class="reviewImgInfo">
			<div class="reviewImgInfoTitle">${p.name}</div>
			<table class="reviewImgInfoTable">
				<tbody>
					<tr>
						<td>价格：</td>
						<td><span class="reviewImgInfoPrice">￥
							<fmt:formatNumber type="number" value="${p.originalPrice}" minFractionDigits="2"/>
						</span>元</td>
					</tr>
					<tr>
						<td>配送：</td>
						<td>快递：<span class="reviewImgInfoCourier">0.00</span></td>
					</tr>
					<tr>
						<td>月销量：</td>
						<td><span class="sellOfMonth">${p.saleCount}</span>件</td>
					</tr>
				</tbody>
			</table>
			<div  class="reviewImgOderInfo">
				<div  class="reviewImgOderInfoConext">
					<img src="img/site/reviewLight.png" class="reviewImgOderInfoLogo"></span>
					<span>现在查看的是 您所购买商品的信息于</span>
						<span class="reviewImgOderInfoBuyDate">
							<fmt:formatDate value="${o.createDate}" pattern="yyyy年MM月dd日"/>
						</span>
						<span class="reviewImgOderInfoBuy">下单购买了此商品</span>
				</div>
			</div>
		</div>
		
<div style="clear:both"></div>
		<div class="reviews">
			<div class="reviewsTotal">
				<span class="reviewsTotalSpan">累积评价<span class="reviewsAmount">${p.reviewCount}</span></span>
				<span class="coverTop"></span>
				<span class="cover"></span>
			</div>
			
			<div style="clear:both"></div>
			
		<c:if test="${param.showonly==true}">
		    <div class="reviewDivlistReviews">
		        <c:forEach items="${reviews}" var="r">
		            <div class="reviewDivlistReviewsEach">
		                <div class="reviewDate"><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></div>
		                <div class="reviewContent">${r.content}</div>
		                <div class="reviewUserInfo pull-right">${r.user.anonymousName}<span class="reviewUserInfoAnonymous">(匿名)</span></div>
		            </div>
		        </c:forEach>
		    </div>
		</c:if>	
			
		<c:if test="${param.showonly!=true}">
		  <form method="post" action="foredoreview">
			
			<div class="reviewProduct">
				<div class="reviewProductArea">
					<div class="title">其他买家，需要你的建议哦！</div>
					<table class="reviewTable">
						<tr>
							<td class="reviewProductTitle">评价商品</td>
							<td class="reviewArea"><textarea name="content"></textarea></td>
						</tr>
					</table>
				</div>
				<div class="makeReviewButtonDiv">
					<input type="hidden" value="${o.id}" name="oid">
					<input type="hidden" value="${p.id}" name="pid">
					<button type="submit">提交评价</button>
				</div>
			</div>
			
		 </form>
		</c:if>
		
		</div>
	</div>