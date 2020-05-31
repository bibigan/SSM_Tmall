<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<!-- 注册页面的主体功能，用于提交账号密码。 在提交之前会进行为空验证，以及密码是否一致验证 -->

<script>
$(function(){
	
// 	当账号提交到服务端，服务端判断当前账号已经存在的情况下，显示返回的错误提示 "用户名已经被使用,不能使用"
    <c:if test="${!empty msg}">
	    $("span.errorMessage").html("${msg}");
	    $("div.registerErrorMessageDiv").css("visibility","visible");      
    </c:if>
     
    $(".registerForm").submit(function(){
        if(0==$("#name").val().length){
            $("span.errorMessage").html("请输入用户名");
            $("div.registerErrorMessageDiv").css("visibility","visible");          
            return false;
        }      
        if(0==$("#password").val().length){
            $("span.errorMessage").html("请输入密码");
            $("div.registerErrorMessageDiv").css("visibility","visible");          
            return false;
        }      
        if(0==$("#repeatpassword").val().length){
            $("span.errorMessage").html("请输入重复密码");
            $("div.registerErrorMessageDiv").css("visibility","visible");          
            return false;
        }      
        if($("#password").val() !=$("#repeatpassword").val()){
            $("span.errorMessage").html("重复密码不一致");
            $("div.registerErrorMessageDiv").css("visibility","visible");          
            return false;
        }      
 
        return true;
    });
})
</script>

<div class="logupDiv">
<form method="post" action="foreregister" class="registerForm">   
<!-- 	 提示栏 -->
	   <div class="registerErrorMessageDiv">
        <div class="alert alert-danger" role="alert">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
            <span class="errorMessage"></span>
        </div>       
       </div>
	   
	   <table align="center" class="registerTable">
        <tbody><tr>
            <td class="registerTip registerTableLeftTD">设置会员名</td>
            <td></td>
        </tr>
        <tr>
            <td class="registerTableLeftTD">登陆名</td>
            <td class="registerTableRightTD"><input placeholder="会员名一旦设置成功，无法修改" name="name" id="name"> </td>
        </tr>
        <tr>
            <td class="registerTip registerTableLeftTD">设置登陆密码</td>
            <td class="registerTableRightTD">登陆时验证，保护账号信息</td>
        </tr>     
        <tr>
            <td class="registerTableLeftTD">登陆密码</td>
            <td class="registerTableRightTD"><input type="password" placeholder="设置你的登陆密码" name="password" id="password"> </td>
        </tr>
        <tr>
            <td class="registerTableLeftTD">密码确认</td>
            <td class="registerTableRightTD"><input type="password" placeholder="请再次输入你的密码" id="repeatpassword"> </td>
        </tr>
        <tr>
            <td class="registerButtonTD" colspan="2">
                <button>提   交</button>
            </td>
        </tr>             
    </tbody></table>
</form>
</div>