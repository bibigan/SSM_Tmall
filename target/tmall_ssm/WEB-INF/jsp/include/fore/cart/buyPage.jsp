<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 参数：ois、sum -->
<!-- 显示选中的订单项列表 -->
<!-- 显示总金额 -->
<script>
$(function(){
	// $("button.submitOrderButton").click(function(){
	// 	$(".orderItemTR").each(function(){
	// 		var oiid=$(this).attr("oiid");
	// 		//检查是否过期，若过期刷新，否则继续
	// 		var page="forecheckNum";
	// 		$.get(
	// 				page,
	// 				{"oiid":oiid},
	// 				function (result) {
	// 					if ("fail" == result) {
	// 						console.log("当前商品库存有变化，即将返回到购物车界面！");
	// 						alert("当前商品库存有变化，即将返回到购物车界面！");
	// 						location.href="forecart";
	// 						return false;
	// 					}
	// 				}
	// 		);
	// 	});
	// });
	function checkStock(){
		$(".orderItemTR").each(function(){
			var oiid=$(this).attr("oiid");
			//检查是否过期，若过期刷新，否则继续
			var page="forecheckNum";
			$.get(
					page,
					{"oiid":oiid},
					function (result) {
						if ("fail" == result) {
							console.log("当前商品库存有变化，即将返回到购物车界面！");
							alert("当前商品库存有变化，即将返回到购物车界面！");
							location.href="forecart";
							return false;
						}
					}
			);
		});
		return true;
	}
});

</script>
	<div class="buyPageDiv">
	  <form action="forecreateOrder" method="post" class="buyForm" >
<%--		  onsubmit="return checkStock()"--%>
		<div class="buyFlow">
			<span><img class="pull-left" src="img/site/simpleLogo.png"></span>
			<span><img class="pull-right" src="img/site/buyflow.png"></span>
		</div>
		<div style="clear:both"></div>
		
		<div style="clear:both"></div>
		<div class="address">
		   <div class="addressTip">输入收货地址</div>
			<table class="addressTable"><tbody>
				<tr>
					<td>详细地址<span class="redStar">*</span></td>
					<td><textarea  name="address" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea></td>
				</tr>
				<tr>
					<td>邮政编码</td>
					<td><input type="text" placeholder="如果您不清楚邮递区号，请填写000000" name="post"></td>
				</tr>
				<tr>
					<td>收货人姓名<span class="redStar">*</span></td>
					<td><input type="text" name="receiver" placeholder="长度不超过25个字符" ></td>
				</tr>
				<tr>
					<td>手机号码<span class="redStar">*</span></td>
					<td><input type="text" name="mobile" placeholder="请输入11位手机号码"></td>
				</tr>
			</tbody></table>
		</div>
<!-- 		确认订单信息 -->
		<div class="productList">
		<div class="productListTip">确认订单信息</div>
		<table class="productListTable">
			<thead>
				<tr>
					<th class="productListTableFirstColumn" colspan="2">
						<img src="img/site/tmallbuy.png" class="tmallbuy">
						<a href="#nowhere" class="marketLink">店铺：天猫店铺</a>
						<a href="#nowhere" class="wangwanglink"> <span class="wangwangGif"></span> </a>
					</th>
					<th>单价</th>
					<th>数量</th>
					<th>小计</th>
					<th>配送方式</th>
				</tr>
				<tr class="rowborder">
					<td colspan="2"></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</thead>
			<tbody class="productListTableTbody" ois>
				<c:forEach items="${ois}" var="oi" varStatus="st">
					<tr class="orderItemTR" oiid="${oi.id}">
						<td class="orderItemFirstTD"><img width="20px"  src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" class="orderItemImg"></td>
						<td class="orderItemProductInfo">
						<a class="orderItemProductLink" href="foreproduct?pid=${oi.product.id}">
							${oi.product.name}
						</a>
							<img title="支持信用卡支付" src="img/site/creditcard.png">
							<img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
							<img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
						</td>
						<td>
						<span class="orderItemProductPrice">￥
							<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/>
						</span>
						</td>
						<td>
						<span class="orderItemProductNumber">${oi.number}</span>
						</td>
						<td><span class="orderItemUnitSum">
							￥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" minFractionDigits="2"/>
						</span></td>
						<c:if test="${st.count==1}">
							<td class="orderItemLastTD" rowspan="5">
							<label class="orderItemDeliveryLabel">
								<input type="radio" checked="checked" value="">
								普通配送
							</label>
							<select class="orderItemDeliverySelect">
								<option>快递 免邮费</option>
							</select>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="orderItemListumDiv">
			<div class="pull-left">
				<span class="leaveMessageText">给卖家留言:</span>
                <input type="text" class="leaveMessageInput"  placeholder="（选填）对本次交易的说明"> 
                <span class="leaveMessageTextareaSpan" style="display: none;">
                    <textarea class="leaveMessageTextarea" name="userMessage"></textarea>
                    <br>
                        <span class="inputSpan">还可以输入<span class="inputNumber">200</span>个字符</span>
                </span>
			</div>
			<span class="pull-right">店铺合计(含运费): ￥
				<fmt:formatNumber type="number" value="${sum}" minFractionDigits="2"/></span>
			</span>
		</div>
	</div>
	<div class="orderItemTotalSumDiv">
		<div class="pull-right"> 
			<span>实付款：</span>
			<span class="orderItemTotalSumSpan">￥
				<fmt:formatNumber type="number" value="${sum}" minFractionDigits="2"/>
			</span>
		</div>
	</div>
	 <div style="clear:both"></div> 
	<div class="submitOrderDiv">
			<button class="submitOrderButton" type="submit">提交订单</button>
	</div>
  </form>
</div>