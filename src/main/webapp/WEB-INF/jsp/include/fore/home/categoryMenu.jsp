<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<!-- 随机挑选一个产品作为推荐产品，来进行高亮显示 -->
<script>
$(function(){
    $("div.productsAsideCategorys div.Categorys_row a").each(function(){
        var v = Math.round(Math.random() *6);
        if(v == 1)
            $(this).css("color","#87CEFA");
    });
});
 
</script>

<div class="category">
	<div class="categoryMenu">
		<c:forEach items="${cs}" var="c" varStatus="i">
			<div class="categoryMenuItem" cid="${c.id}">
				 <span class="glyphicon glyphicon-link"></span>
				 <a href="forecategory?cid=${c.id}">${c.name}</a>
			</div>
		</c:forEach>	
	</div>	
	
	<c:forEach items="${cs}" var="c">
		<div class="productsAsideCategorys" cid="${c.id}">
	<!-- 	每个分类 -->
			 <c:forEach items="${c.productsByRow}" var="pr">
			 	<div class="Categorys_row">
	<!-- 		 	每行 -->
			 	    <c:forEach items="${pr}" var="p">
	                    <c:if test="${!empty p.subTitle}">
					 		<a href="foreproduct?pid=${p.id}">
	<!-- 				 		每个产品 -->
								<c:forEach items="${fn:split(p.subTitle, ' ')}" var="title" varStatus="st">
	<!-- 							每个子标题字段 -->
									<c:if test="${st.count==1}">
	<!-- 								只显示第一个标题字段 -->
										${title}
									</c:if>
								</c:forEach>
							</a>
			             </c:if>
			         </c:forEach>
			 	</div>
			 </c:forEach>
			</div>
	</c:forEach>
</div>