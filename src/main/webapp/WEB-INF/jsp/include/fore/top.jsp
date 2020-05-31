<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<!-- 根据用户是否登录，决定是否显示退出按钮，或者登录注册按钮，以及购物车中的商品数量 -->

<script>
	$(function () {
		$("#myCart").click(function () {
			var page = "forecheckLogin";
			$.post(
					page,
					function(result){
						if("success"==result){
							location.href= $("#myCart").attr("href");
						}
						else{
							$("#loginModal").modal('show');
						}
					}
			);
			return false;
		});
		$("#myOrders").click(function () {
			var page = "forecheckLogin";
			$.post(
					page,
					function(result){
						if("success"==result){
							location.href= $("#myOrders").attr("href");
						}
						else{
							$("#loginModal").modal('show');
						}
					}
			);
			return false;
		});
	});
</script>

<nav class="top">
	<div class="topDiv">
		<a href="forehome">
			<span class="glyphicon glyphicon-home redColor"></span>天猫首页
		</a>
		<span>喵，欢迎来到天猫</span>
		<c:if test="${empty user}">
			<a href="loginPage">请登录</a>
			<a href="registerPage">免费注册</a>
		</c:if>
		<c:if test="${!empty user}">
			<a href="loginPage">${user.name}</a>
			<a href="forelogout">退出</a>
		</c:if>
		<span class="pull-right">
			<a href="forebought" id="myOrders">我的订单</a>
			<a href="forecart" id="myCart">
				<span class=" glyphicon glyphicon-shopping-cart redColor" ></span>
				购物车<span class="cartNum" style="font-weight: bold">${cartTotalItemNumber}</span>件
			</a>
		</span>
	</div>
</nav> 