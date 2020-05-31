<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 从request的属性"cs" 中获取到分类集合，并取第5个到第8个，一共4个来显示 -->
<div class="search">
		<a href="${contextPath}"><img src="img/site/logo.gif" class="logo" id="logo"></a>
		<form action="foresearch" method="post" >	
			<div class="searchDiv">
				<input type="text" placeholder="<c:if test="${!empty keyword}">${keyword}</c:if><c:if test="${empty keyword}">时尚男鞋  太阳镜</c:if> " name="keyword">
				<button type="submit" class="searchBtn">搜索</button>
				<div class="searchBelow">
					<c:forEach items="${cs}" var="c" varStatus="i">
						<c:if test="${i.count>=5 and i.count<=8}">
							<a href="forecategory?cid=${c.id}">${c.name}</a>
							<c:if test="${i.count!=8}">
								<span></span><span>|</span>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</form>
</div> 