<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--     cart方法传来ois -->
<script>
var deleteOrderItem = false;
var deleteOrderItemid = 0;
$(function(){
 
    $("a.deleteOrderItem").click(function(){
        deleteOrderItem = false;
        var oiid = $(this).attr("oiid")
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
            	if("deleted" != $(this).attr("selectit")){
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
         
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 1;
        if(num>stock)
            num = stock;
         
        syncPrice(pid,num,price);
    });
 
    $(".numberPlus").click(function(){
         
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemListtock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
 
        num++;
        if(num>stock)
            num = stock;
        syncPrice(pid,num,price);
    });
    $(".numberMinus").click(function(){
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemListtock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
         
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
        --num;
        if(num<=0)
            num=1;
        syncPrice(pid,num,price);
    });
     
    $("button.createOrderButton").click(function(){
        var params = "";
        $(".cartProductItemIfSelected").each(function(){
            if("selectit"==$(this).attr("selectit")){
                var oiid = $(this).attr("oiid");
                params += "&oiid="+oiid;
            }
        });
        params = params.substring(1);
        location.href="forebuy?"+params;//页面跳转到结算页面
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
	if("false"==$(this).attr("selectit"))
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
function syncPrice(pid,num,price){
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
			if("success"!=result){
				location.href="loginPage";
			}
			else{
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
					<tr class="cartProductItemTR" oiid="${oi.id}">
						<td>
							<img src="img/site/cartNotSelected.png" class="cartProductItemIfSelected" oiid="${oi.id}" selectit="false">
							<a href="#nowhere" style="display:none"><img src="img/site/cartSelected.png"></a>
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
                                </div>
							</div>
						</td>
						<td>
<!-- 					价格 -->
							<span class="cartProductItemOringalPrice">￥
								${oi.product.originalPrice}
							</span>
                            <span class="cartProductItemPromotionPrice">￥
                            	${oi.product.promotePrice}
                            </span>
						</td>
<!-- 					数量 -->
						<td>
							<div class="cartProductChangeNumberDiv">
                                <span pid="${oi.product.id}" class="hidden orderItemListtock ">${oi.product.stock}</span>
                                <span pid="${oi.product.id}" class="hidden orderItemPromotePrice ">${oi.product.promotePrice}</span>
                                <a href="#nowhere" class="numberMinus" pid="${oi.product.id}">-</a>
                                <input value="${oi.number}" autocomplete="off" class="orderItemNumberSetting" oiid="${oi.id}" pid="${oi.product.id}">
                                <a href="#nowhere" class="numberPlus" pid="${oi.product.id}" stock="${oi.product.stock}">+</a>
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

