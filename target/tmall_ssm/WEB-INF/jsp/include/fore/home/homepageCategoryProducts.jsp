<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 主题的17种分类以及每种分类对应的5个产品 -->
<div class="productList">
	<c:forEach items="${cs}" var="c">
<!-- 	每个分类只显示5个产品 -->
		<div class="eachProductList">
			<span class="tubiao"></span><span class="productListTitle">${c.name}</span><br>
			
		 	<c:forEach items="${c.products}" var="p" varStatus="st">
<!-- 		其下每个产品 -->
			  <c:if test="${st.count<6}">
				<div class="productItem">
					<a href="foreproduct?pid=${p.id}"><img src="img/productSingle_middle/${p.firstProductImage.id}.jpg"></a>
					<a href="foreproduct?pid=${p.id}" class="productItemDescLink">
						<span class="productItemDesc">[热销]${fn:substring(p.name, 0, 20)}</span>
					</a>
					<span class="price">
						<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
					</span>
				</div>
			   </c:if>
			</c:forEach>
			
			<div style="clear:both"></div>
		</div>		
	</c:forEach>
	
	<div class="end">
			<img src="img/site/end.png">
	</div>
</div>