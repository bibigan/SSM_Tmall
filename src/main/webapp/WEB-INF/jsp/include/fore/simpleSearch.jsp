<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div class="simpleSear">
	  <a href="forehome"><img src="img/site/simpleLogo.png" class="Logo" id="simpleLogo"></a>
		
	  <form action="foresearch" method="post" >
		<div class="simpleSearDiv pull-right">
			<input type="text" placeholder="平衡车 原汁机 " name="keyword">
			<button type="submit" class="searchBtn">搜天猫</button>
			<div class="simpleSearBelow">
				<c:forEach items="${cs}" var="c" varStatus="i">
					 <c:if test="${i.count>=5 and i.count<=8}">
				 	   <a href="forecategory?cid=${c.id}">${c.name}</a>
				 	   <c:if test="${i.count!=8}">
				 	 		<span>|</span>
				 	   </c:if>
				 	 </c:if>
				</c:forEach>
			</div>
		</div>
	  </form>
	</div>