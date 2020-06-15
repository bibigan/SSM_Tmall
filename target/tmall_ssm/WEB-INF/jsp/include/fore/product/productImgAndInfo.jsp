<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
   
<!-- 传来当前产品p、产品下的属性<-属性值列表pvs、详情图片列表、单个图片列表、评论数、销量、评论列表reviews -->
 
<script>
$(function(){
	var stock = ${p.stock};
	//价格修改
    $(".productNumberSetting").keyup(function(){
        var num= $(".productNumberSetting").val();
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 1;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
     //增加按钮
    $(".increaseNumber").click(function(){
        var num= $(".productNumberSetting").val();
        num++;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
     //减少按钮
    $(".decreaseNumber").click(function(){
        var num= $(".productNumberSetting").val();
        --num;
        if(num<=0)
            num=1;
        $(".productNumberSetting").val(num);
    });
    $(".addCartButton").removeAttr("disabled");
    $(".addCartLink").click(function(){//模态登录
    	//用异步ajax的方式访问forecheckLogin，获取当前是否登录状态
		//如果返回的不是"success" 即表明是未登录状态，那么就会打开登录的模态窗口
        var page = "forecheckLogin";
        $.post(
                page,
                function(result){
                	console.log("********是否登录*"+("success"==result));
                    if("success"==result){
                        var pid = ${p.id};
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        $.get(
                                addCartpage,
                                {"pid":pid,"num":num},
                                function(result){
                                    if("success"==result){
                                        $(".addCartButton").html("已加入购物车");
                                        $(".addCartButton").attr("disabled","disabled");
                                        $(".addCartButton").css("background-color","lightgray");
                                        $(".addCartButton").css("border-color","lightgray");
                                        $(".addCartButton").css("color","black");
                                        //即时刷新购物车数量
										var getCartTotalItemNumberPage="forecartNumber"
                                        $.get(
												getCartTotalItemNumberPage,
												function (data) {
													console.log("data:"+data);
													$("span.cartNum").html(data);
												}
										);
                                    }
                                    else{
                                         
                                    }
                                }
                        );                          
                    }
                    else{
                        $("#loginModal").modal('show');                     
                    }
                }
        );      
		return false;
    });
    //点击购买
    $(".buyLink").click(function(){
        var page = "forecheckLogin";
        $.post(
                page,
                function(result){
                    if("success"==result){
                        var num = $(".productNumberSetting").val();
                        location.href= $(".buyLink").attr("href")+"&num="+num;
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
   
<div class="imgAndInfo">

<!-- 产品5个单个图片展示 -->
	<div class="imgInimgAndInfo">
<!-- 	默认显示第一张图片 -->
		<img src="img/productSingle/${p.firstProductImage.id}.jpg" class="bigImg">
<!-- 		5个小图片 -->
		<div class="smallImageDiv">
		  <c:forEach items="${p.productSingleImages}" var="psi" varStatus="st">
		    <c:if test="${st.count<=5}">
				<img  class="smallImage" src="img/productSingle_small/${psi.id}.jpg" bigImageURL="img/productSingle/${psi.id}.jpg">
		  	</c:if>
		  </c:forEach>
		</div>
		<div class="img4load hidden" ></div> 
	</div>
	
<!-- 产品基本信息	 -->
	<div class="infoInimgAndInfo">
		<div class="productTitle">${p.name}</div>
		<div class="productSubTitle">${p.subTitle}</div>
		<div class="juhuasuan"><span class="juhuasuanBig">聚划算</span><span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始</span></div>
		<div class="productPriceDiv">
			<div class="gouwujuanDiv"><img src="img/site/gouwujuan.png"><span>全至天猫实物商品通用</span></div>	
			<div class="orignalDiv">
				<span class="originalPriceDesc">价格</span>
				<span class="originalPriceYuan">¥</span>
				<span class="originalPrice">
					<fmt:formatNumber type="number" value="${p.originalPrice}" minFractionDigits="2"/>
				</span>
			</div>		
			<div class="promotionDiv">
				<span class="promotionPriceDesc">促销价</span>
				<span class="promotionPriceYuan">¥</span>
				<span class="promotionPrice">
					<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
				</span>
			</div>
		</div>
		<div class="productSaleAndReviewNumber">
			<div>销量<span class="redColor boldWord">${p.saleCount}</span></div>
			<div>累积评价<span class="redColor boldWord">${p.reviewCount}</span></div>
		</div>
		<div class="productNumber">
			<span>数量</span>
			<span>
				<span class="productNumberSettingSpan">
					<c:if test="${p.stock>0}">
						<input type="text" value="1" class="productNumberSetting">
					</c:if>
					<c:if test="${p.stock<1}">
						<input type="text" value="0" class="productNumberSetting">
					</c:if>
				</span>
				<span class="arrow">
					<a class="increaseNumber" href="#nowheretogo">
					<span class="updown">
					   <img src="img/site/increase.png">
					</span>
					</a>
					<span class="updownMiddle"></span>	
					<a class="decreaseNumber" href="#nowheretogo">
					<span class="updown">
					    <img src="img/site/decrease.png">
					</span>
					</a>
				</span>
			件</span>
			<span>库存${p.stock}件</span>
		</div>
		<div class="serviceCommitment">
			<span class="serviceCommitmentDesc">服务承诺</span>
			<span class="serviceCommitmentLink">
				<a href="#nowhere">正品保证</a>
				<a href="#nowhere">极速退款</a>
				<a href="#nowhere">赠运费险</a>
				<a href="#nowhere">七天无理由退换</a>
			</span>
		</div>
		<div class="buyDiv">
            <a class="buyLink" href="forebuyone?pid=${p.id}"><button class="buyButton">立即购买</button></a>
            <a href="#nowheretogo" class="addCartLink"><button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
        </div>
	</div>

	<div style="clear:both"></div>
</div>