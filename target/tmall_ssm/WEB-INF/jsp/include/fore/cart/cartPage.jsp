<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--     cart方法传来ois -->

<style>

</style>

<script>

var deleteOrderItem = false;
var deleteOrderItemid = 0;

$(function(){
	<c:if test="${!empty mess}">
		alert("${mess}");
	</c:if>
    $("a.deleteOrderItem").click(function(){
        deleteOrderItem = false;
        var oiid = $(this).attr("oiid");
        deleteOrderItemid = oiid;
        $("#deleteConfirmModal").modal('show');   
    });
  //点击确认删除按钮
    $("button.deleteConfirmButton").click(function(){
        deleteOrderItem = true;
        $("#deleteConfirmModal").modal('hide');
    });
//     点击删除按钮后
    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
        if(deleteOrderItem){
        	console.log("删除触发");
            var page="foredeleteOrderItem";
            $.post(
                    page,
                    {"oiid":deleteOrderItemid},
                    function(result){
                        if("success"==result){
                        	console.log("deleteOrderItem删除成功");
                        	$(".cartProductItemIfSelected[oiid="+deleteOrderItemid+"]").attr("selectit", "deleted");
                            $("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").hide();
                            syncSelect();
                            syncCreateOrderButton();
                            calcCartSumPriceAndNumber();
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
                            location.href="loginPage";
                        }
                    }
                );
             
        }
    }) 
     
    $("img.cartProductItemIfSelected").click(function(){
        var selectit = $(this).attr("selectit")
        if("selectit"==selectit){
            $(this).attr("src","img/site/cartNotSelected.png");
            $(this).attr("selectit","false")
            $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
        }
        else{
            $(this).attr("src","img/site/cartSelected.png");
            $(this).attr("selectit","selectit")
            $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
        }
        syncSelect();
        syncCreateOrderButton();
        calcCartSumPriceAndNumber();
    });
    $("img.selectAllItem").click(function(){
        var selectit = $(this).attr("selectit")
        if("selectit"==selectit){
            $("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
            $("img.selectAllItem").attr("selectit","false")
            $(".cartProductItemIfSelected").each(function(){
            	if("deleted" != $(this).attr("selectit")){
	            	$(this).attr("src","img/site/cartNotSelected.png");
	                $(this).attr("selectit","false");
	                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            	}
            });        
        }
        else{//现在是选中
            $("img.selectAllItem").attr("src","img/site/cartSelected.png");
            $("img.selectAllItem").attr("selectit","selectit")
            $(".cartProductItemIfSelected").each(function(){
            	if(("deleted" != $(this).attr("selectit"))&&("none"!=$(this).css("display"))){
                    $(this).attr("src","img/site/cartSelected.png");
                    $(this).attr("selectit","selectit");
                    $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
                }
            });            
        }
        syncCreateOrderButton();
        calcCartSumPriceAndNumber();
         
    });
     
    $(".orderItemNumberSetting").keyup(function(){
        var pid=$(this).attr("pid");
		var stock= $("span.orderItemListtock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        //刷新stock
		var oiid=$(this).attr("oiid");
        page="foregetStock";
        $.get(
        		page,
				{"oiid":oiid},
				function(result){
					stock=parseInt(result);
					console.log("实际库存:"+result);
					console.log("计算的库存:"+stock);

					var select1=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit");
					if("none"!=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().css("display")){
						//first还没隐藏--第一次修改数量
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit",select1);
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit","false");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().hide();//藏
					}

					var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
					num = parseInt(num);
					if(isNaN(num))
						num= 1;
					if(num<=0)
						num = 1;
					if(num>stock){
						alert("当前商品数量大于库存，自动将数量调整至库存数量！");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit","false");
						num = stock;
					}
					if(stock==0){
						alert("当前商品没有库存");
						num=0;
					}
					syncPrice(pid,num,price,stock);
				}
		);


    });
 
    $(".numberPlus").click(function(){
		var oiid=$(this).attr("oiid");
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemListtock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();

		//刷新stock
		page="foregetStock";
		$.get(
				page,
				{"oiid":oiid},
				function(result){
					stock=parseInt(result);

					console.log("实际库存:"+result);
					num++;
					console.log("计算的库存:"+stock);

					var select1=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit");
					if("none"!=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().css("display")){
						//first还没隐藏--第一次修改数量
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit",select1);
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit","false");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().hide();//藏
					}

					if(num>stock){
						if(num-stock>1){//原来num>stock,num+1后满足该条件
							alert("当前商品数量大于库存，自动将数量调整至库存数量！");
							$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit","false");
						}
						else alert("当前商品数量等于库存，不可再增加！");
						num = stock;
					}
					if(stock==0){
						alert("当前商品没有库存");
						num=0;
					}
					syncPrice(pid,num,price,oiid,stock);
				}
		);
    });
    $(".numberMinus").click(function(){
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemListtock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		var oiid=$(this).attr("oiid");

		//刷新stock
		page="foregetStock";
		$.get(
				page,
				{"oiid":oiid},
				function(result){
					stock=parseInt(result);
					console.log("实际库存:"+result);
					console.log("计算的库存:"+stock);

					var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
					--num;

					var select1=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit");
					if("none"!=$(".cartProductItemIfSelected[oiid="+oiid+"]").first().css("display")){
						//first还没隐藏--第一次修改数量
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit",select1);
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().attr("selectit","false");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").first().hide();//藏
					}

					if(num<=0)
						num=1;
					if(num>stock){//原来更大
						alert("当前商品数量大于库存，自动将数量调整至库存数量！");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit","false");
						num = stock;
					}
					if(stock==0){
						alert("当前商品没有库存");
						num=0;
					}
					syncPrice(pid,num,price,oiid,stock);
				}
		);
    });
     
    $("button.createOrderButton").click(function(){
        var params = "";
        console.log("点击结算");
		// var flag=false;
        $(".cartProductItemIfSelected").each(function(){
            if("selectit"==$(this).attr("selectit")){//所有选中的，有可能过期
                var oiid = $(this).attr("oiid");
				// //检查是否过期，若过期刷新，否则继续
				// var page="forecheckNum";
				// $.get(
				// 		page,
				// 		{"oiid":oiid},
				// 		function (result) {
				// 			if("fail"==result){
				// 				console.log("有变化！");
				// 				flag=true;
				// 			}
							params += "&oiid="+oiid;
				// 		}
				// );
            }
        });
        // if(flag){
		// 	alert("商品库存有变化，即将刷新页面");
		// 	location.reload();
		// }
        // else{
			alert("商品库存可能有变化，建议刷新页面");
			params = params.substring(1);
			location.href="forebuy?"+params;//页面跳转到结算页面
		// }
    });
});
function formatMoney(num) {
num = num.toString().replace(/\$|\,/g, '');
if (isNaN(num))
 num = "0";
sign = (num == Math.abs(num));//sign为false，num是负数，反之亦然
num = Math.abs(num);//取正数num  
/*   百分位四舍五入
cents: 小数部分
num: 整数部分* */   
num = Math.floor(num * 100 + 0.50000000001);
cents = num % 100;
num = Math.floor(num / 100).toString();
if (cents < 10)
 cents = "0" + cents;
//三位一隔
var number="";
var len=num.length;
for (var i = 0; i < len ; i++) {
 number+=num[i];
 if ((i + 1) % 3 == len % 3 && i != len - 1) {
     // console -1,234,567.46
     //第0位，第3位时打印"," 最后一位不用打印,
     number+=",";
 }
}
return (((sign) ? '' : '-') + number + '.' + cents);
}

//结算刷新
function syncCreateOrderButton(){
//对每个框，判断是否有框勾上
var flag=false;
$("img.cartProductItemIfSelected").each(function(){
	if("selectit"==$(this).attr("selectit"))
		flag=true;//有勾上
});
if(flag){//有勾上，结算变红可点
	$("button.createOrderButton").removeAttr("disabled");
	$("button.createOrderButton").css("background-color","#C40000");
}
else{//没有勾，结算变灰不可点
	$("button.createOrderButton").attr("disabled","disabled");
	$("button.createOrderButton").css("background-color","#AAAAAA");
}
}
//全选刷新
function syncSelect(){
//对每个框，判断是否有框没有勾上
var flag=true;
$("img.cartProductItemIfSelected").each(function(){
	if(("false"==$(this).attr("selectit"))&&("none"!=$(this).css("display")))
		flag=false;//存在没有勾上
});	
if(!flag){ //有框没勾上，不是全选，不勾
	$("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
 	$("img.selectAllItem").attr("selectit","false");
}
//是全选,勾上
else {
	 $("img.selectAllItem").attr("src","img/site/cartSelected.png");
	 $("img.selectAllItem").attr("selectit","selectit");
}

}
//总计、总数刷新
function calcCartSumPriceAndNumber(){
var sum=0.00;//总计
var totalNumber = 0;//总数
//对勾了的行，根据pid找对应的小计和数量
$("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
	var oiid=$(this).attr("oiid");
	var n=$(".orderItemNumberSetting[oiid="+oiid+"]").val();
	totalNumber+=new Number(n);
	
	var s=$("span.cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
	s=s.replace(/,/g,"");
	s=s.replace(/￥/g,"");
	sum+=new Number(s); 
});
//放到对应的位置
$("span.cartSumNumber").html(totalNumber);
$("span.cartSumPrice").html("￥"+formatMoney(sum));
$("span.cartTitlePrice").html("￥"+formatMoney(sum));	
}
//小计刷新 某行改了数量，传该行pid,num,单价price，并刷新总计
function syncPrice(pid,num,price,oiid,stock){
$(".orderItemNumberSetting[pid="+pid+"]").val(num);
$("span.cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+formatMoney(num*price));
calcCartSumPriceAndNumber();
// 更新订单项
var page = "forechangeOrderItem";
$.post(
	    page,
	    {"pid":pid,"number":num},
	    function(result){
	    	console.log("changeOrderItem:"+result);
			if("fail"==result){
				location.href="loginPage";
			}
			else{
				console.log("够？："+result);
				 $(".noenoughSpan[oiid="+oiid+"]").first().hide();//藏

				if("success"==result){//够
					console.log("够！！");
					if(stock<1){
						console.log("当前商品已经没有库存！");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit","false");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("src","img/site/cartNotSelected.png");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().parents("tr.cartProductItemTR").css("background-color","#fff");
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().hide();//藏
						$(".noenoughSpan[oiid="+oiid+"]").last().html("当前商品已经没有库存！");
						$(".noenoughSpan[oiid="+oiid+"]").last().addClass(" alert alert-danger");
						$(".noenoughSpan[oiid="+oiid+"]").last().show();//显示

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
						if("selectit"==$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("selectit")){
							$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("src","img/site/cartSelected.png");
							$(".cartProductItemIfSelected[oiid="+oiid+"]").last().parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
						}
						else{
							$(".cartProductItemIfSelected[oiid="+oiid+"]").last().attr("src","img/site/cartNotSelected.png");
							$(".cartProductItemIfSelected[oiid="+oiid+"]").last().parents("tr.cartProductItemTR").css("background-color","#fff");
						}
						$(".cartProductItemIfSelected[oiid="+oiid+"]").last().show();
						$(".noenoughSpan[oiid="+oiid+"]").last().hide();//藏

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
				}
				else{//不够
					console.log("!!!!!!!!!!!!!不够!!!!!!!!!!!!");
					// $(".cartProductItemIfSelected[oiid="+oiid+"]").hide();//两个都藏
					// $(".noenoughSpan[oiid="+oiid+"]").html("数量大于商品库存，请重新选择数量！next 当前库存为"+stock+"件");
					// $(".noenoughSpan[oiid="+oiid+"]").show();
				}
			}
	    }
	);

}


</script>    
<!--     js:点击结算按钮----获取选中的订单项的id并跳转 -->
    
	<div class="cartDiv">
<!-- 	上方结算 -->
		<div class="cartTitle pull-right">
			<span>已选商品（不含运费）</span>
			<span class="cartTitlePrice">￥0.00</span>
			<button class="createOrderButton" disabled="disabled">结 算</button>
		</div>
<!-- 	订单列表 -->
		<div class="cartProductList">
<!-- 	            订单表 -->
			  <table class="cartProductTable">
<!-- 			  表头 -->
			  	 <thead>
			  	 	<tr>
			  	 		<th class="selectAndImage">
			  	 			 <img src="img/site/cartNotSelected.png" class="selectAllItem" selectit="false"> 
			  	 			 全选    
			  	 		</th>
			  	 		<th>商品信息</th>
			  	 		<th>单价</th>
			  	 		<th>数量</th>
			  	 		<th width="120px">金额</th>
			  	 		<th class="operation">操作</th>
			  	 	</tr>
			  	 </thead>
<!-- 			 表身 -->
				<tbody>
				  <c:forEach items="${ois}" var="oi" varStatus="st">
<!-- 				订单项 -->
					<tr class="cartProductItemTR" oiid="${oi.id}" oid="${oi.oid}">
						<td>
							<span>
								<c:if test="${oi.oid==-1 && oi.product.stock>0}">
									<img src="img/site/cartNotSelected.png" class="cartProductItemIfSelected" oiid="${oi.id}" pid="${oi.product.id}" selectit="false">
								</c:if>
								<img src="img/site/cartNotSelected.png" class="cartProductItemIfSelected" oiid="${oi.id}" pid="${oi.product.id}" selectit="false" style="display:none">
								<a href="#nowhere" style="display:none"><img src="img/site/cartSelected.png"></a>
							</span>
							<img class="cartProductImg" width="40px" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
						</td>
						<td>
<!-- 					商品详情 -->
							<div class="cartProductLinkOutDiv">
								 <a class="cartProductLink" href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
<!-- 							小图标 -->
								 <div class="cartProductLinkInnerDiv">
                                    <img title="支持信用卡支付" src="img/site/creditcard.png">
                                    <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                    <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
<%--						库存不够的警告--%>
										<span class="noenoughSpan" oiid="${oi.id}">
											<c:if test="${oi.product.stock<1}">
												<span class="alert alert-danger">
													当前商品已经没有库存！
													<c:if test="${oi.oid==-2}">请重新选择数量!</c:if>
												</span>
											</c:if>
											<c:if test="${oi.oid==-2 && oi.product.stock>=1}">
												<span class="alert alert-danger">
													数量大于商品库存，请重新选择数量!库存为${oi.product.stock}件
												</span>
											</c:if>
										</span>
									 <span class="noenoughSpan" oiid="${oi.id}"></span>
								 </div>
							</div>
						</td>
						<td>
<!-- 					价格 -->
							<span class="cartProductItemOringalPrice" style="display:inline-block">￥
								${oi.product.originalPrice}
                            <span class="cartProductItemPromotionPrice" style="display:inline-block">￥
                            	${oi.product.promotePrice}
                            </span>
						</td>
<!-- 					数量 -->
						<td>
							<div class="cartProductChangeNumberDiv">
                                <span pid="${oi.product.id}" class="hidden orderItemListtock ">${oi.product.stock}</span>
                                <span pid="${oi.product.id}" class="hidden orderItemPromotePrice ">${oi.product.promotePrice}</span>
                                <a href="#nowhere" class="numberMinus" pid="${oi.product.id}" oiid="${oi.id}">-</a>
                                <input value="${oi.number}" autocomplete="off" class="orderItemNumberSetting" oiid="${oi.id}" pid="${oi.product.id}">
                                <a href="#nowhere" class="numberPlus" pid="${oi.product.id}" stock="${oi.product.stock}" oiid="${oi.id}">+</a>
                            </div>   
						</td>
<!-- 					小计 -->
						 <td>
                            <span pid="${oi.product.id}" oiid="${oi.id}" class="cartProductItemSmallSumPrice">
								￥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" minFractionDigits="2"/>
							</span>
                        </td>
<!--                    操作 -->
                        <td>
                            <a href="#nowhere" oiid="${oi.id}" class="deleteOrderItem">删除</a>
                        </td>
					</tr>
				   </c:forEach>
				</tbody>
			  </table>
		</div>
<!-- 	下方结算 -->
		<div class="cartFoot">
			<img src="img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
			<span>全选</span>
			<div class="pull-right">
				<span>已选商品<span class="cartSumNumber">0</span>件</span>
				<span>合计（不含运费）：</span>
				<span class="cartSumPrice">￥0.00</span>
				<button class="createOrderButton" disabled="disabled">结  算</button>
			</div>
		</div>
	</div>

