<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<script>
$(function(){
	//服务器跳转回来，msg:用户名、密码错误
	<c:if test="${!empty msg}">
		$("span.errorMessage").html("${msg}");
		$("div.loginErrorMessageDiv").show();
	</c:if>
	$("form.loginForm").submit(function(){
		if(0==$("#name").val().length){
			$("span.errorMessage").html("请输入用户名");
			$("div.loginErrorMessageDiv").show();
			return false;
		}
		if(0==$("#password").val().length){
			$("span.errorMessage").html("请输入密码");
			$("div.loginErrorMessageDiv").show();
			return false;
		}
		return true;
	});
	$("form.loginForm input").keyup(function(){
        $("div.loginErrorMessageDiv").hide();  
    });
	
});
</script>

<div class="loginDiv">
		<div class="simpleLogo pull-left" >
			<img src="img/site/simpleLogo.png">
		</div>
		
		<img src="img/site/loginBackground.png" class="backgroundImg">
		
		<form action="forelogin" method="post" class="loginForm">
			<div class="loginPageDiv">
			
				<div class="loginErrorMessageDiv">
	                <div class="alert alert-danger" >
	                  <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
	                    <span class="errorMessage"></span>
	                </div>
           		</div>
			
				<div class="loginContext">账户登录</div>
				<div class="loginInput ">
					<span class="loginInputIcon ">
						<span class=" glyphicon glyphicon-user"></span>
					</span>
					<input type="text" placeholder="手机/会员名/邮箱" name="name" id="name">			
				</div>
				<div  class="loginInput ">
					<span class="loginInputIcon ">
						<span class=" glyphicon glyphicon-lock"></span>
					</span>
					<input type="password" placeholder="密码" name="password" id="password">
				</div>
				<div style="padding-top:10px;">
					<a href="#nowhere" class="notImplementLink pull-left">忘记登录密码</a> 
					<a class="pull-right" href="registerPage">免费注册</a>
				</div>
				<div class="loginBtn">
					<button class="btn btn-block redButton">登录</button>
				</div>
			</div>	
	   </form>
	</div>