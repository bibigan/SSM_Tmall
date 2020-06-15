<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<!-- 这个modal.jsp里提供了两个模态窗口 -->
<!-- 1. 登录模态窗口 -->
<!-- 	当用户在未登录状态，于产品页点击购买\购物车的时候会弹出 -->
<!-- 2. 删除模态窗口 -->
<!-- 	当用户在我的订单页面,和购物车页面进行删除操作的时候，就会弹出模态删除窗口。 -->
 
<style>
div.loginDivInProductPageModalDiv {
	width: 350px;
}

div.deleteConfirmModalDiv {
	width: 350px;
}

div.loginDivInProductPage {
	background-color: white;
	width: 350px;
	height: 400px;
	padding: 60px 25px 80px 25px;
}

div.loginSmallDiv {
	background-color: white;
	position: absolute;
	right: 180px;
	top: 180px;
	width: 350px;
	height: 400px;
	padding: 60px 25px 80px 25px;
}

div.loginErrorMessageDiv {
	width: 300px;
	position: absolute;
	top: 20px;
	display: none;
}

div.loginErrorMessageDiv div.alert {
	padding: 5px !important;
}

div.login_acount_text {
	color: #3C3C3C;
	font-size: 16px;
	font-weight: bold;
}

div.loginInput {
	border: 1px solid #CBCBCB;
	margin: 20px 0px;
}

div.loginInput input {
	display: inline-block;
	border: 0px solid transparent;
	width: 244px;
	height: 30px;
	position: relative;
	left: 6px;
	top: 6px;
}

div.loginInput span, div.loginInput input {
	display: inline-block;
}

div.loginInput span.loginInputIcon {
	margin: 0px;
	background-color: #CBCBCB;
	width: 40px;
	height: 40px;
}

span.loginInputIcon span.glyphicon {
	font-size: 22px;
	position: relative;
	left: 9px;
	top: 9px;
	color: #606060;
}

button.redButton {
	color: white;
	background-color: #C40000;
	font-size: 14px;
	font-weight: bold;
}
</style>
<script>
    $(function () {
        //模态登录点击登录
        $("button.loginSubmitButton").click(function(){
            var name = $("#name").val();
            var password = $("#password").val();

            if(0==name.length||0==password.length){
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }

            var page = "foreloginAjax";
            $.get(
                page,
                {"name":name,"password":password},
                function(result){
                    if("success"==result){
                        location.reload();//刷新当前文档
                    }
                    else{
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );

            return true;
        });
    });
</script>
<div class="modal " id="loginModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog loginDivInProductPageModalDiv">
            <div class="modal-content">
                    <div class="loginDivInProductPage">
                        <div class="loginErrorMessageDiv">
                            <div class="alert alert-danger" >
                              <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                                <span class="errorMessage"></span>
                            </div>
                        </div>
                             
                        <div class="login_acount_text">账户登录</div>
                        <div class="loginInput " >
                            <span class="loginInputIcon ">
                                <span class=" glyphicon glyphicon-user"></span>
                            </span>
                            <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">        
                        </div>
                         
                        <div class="loginInput " >
                            <span class="loginInputIcon ">
                                <span class=" glyphicon glyphicon-lock"></span>
                            </span>
                            <input id="password" name="password"  type="password" placeholder="密码" type="text">          
                        </div>
                                    <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
                        <div>
                            <a href="#nowhere">忘记登录密码</a>
                            <a href="registerPage" class="pull-right">免费注册</a>
                        </div>
                        <div style="margin-top:20px">
                            <button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
                        </div>
                    </div>   
          </div>
    </div>
</div>
 
<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog deleteConfirmModalDiv">
       <div class="modal-content">
          <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">确认删除？</h4>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
          </div>
        </div>
      </div>
    </div>
</div>
<div class="modal" id="reloadConfirmModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog reloadConfirmModalDiv">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">确认刷新？</h4>
            </div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
            </div>
        </div>
    </div>
</div>
</div>