<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<!-- 	传来o -->
<div class="comfirmReceiptDiv">
		<div class="scheduleDiv">
			<div class="comformPayLogo">
				<img src="img/site/comformPayFlow.png" class="comformPayFlow">				
			</div>
				<div class="scheduleTime">
					<span>
						<fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</span>
					<span>
						<fmt:formatDate value="${o.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</span>
					<span>
						<fmt:formatDate value="${o.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</span>
				</div>
		</div>
			<div class="agreeDiv">我已收到货，同意支付宝付款</div>
			<div class="orderConInfo">订单信息</div>
			<table class="orderConTable">
				<thead>
				  <tr>
				  	<th colspan="2">宝贝</th>
				  	<th width="120px">单价</th>
				  	<th width="120px">数量</th>
				  	<th width="120px">商品总价</th>
				  	<th width="120px">运费</th>
				  </tr>
				</thead>
				<tbody>
				
					<c:forEach items="${o.orderItemList}" var="oi" varStatus="st">
<!-- 					每个订单项 -->
					  <tr>
				    	<td><img width="50px" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
						<td class="confirmPayOrderItemProductLink">
							<a href="#nowhere">${oi.product.name}</a>
						</td>
						<td><span class="confirmPayOrderItemProductPrePrice">￥
							<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/>
						</span></td>
						<td><span class="confirmPayOrderItemProductNumber">${oi.number}</span></td>
						<td><span class="confirmPayOrderItemProductPrice">￥
							<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/>
						</span></td>
						<td>快递 ：<span class="confirmPayOrderItemProductfreight">0.00</span></td>
					  </tr>
				  </c:forEach>
				  
				</tbody>
			</table>
			
			<div class="pull-right">实付款：<span class="confirmPayOrderItemPay">￥
				<fmt:formatNumber type="number" value="${o.total}" minFractionDigits="2"/>
			</span></div>

<div style="clear:both"></div>

			<div class="confirmPayOrderInformation">
				<table class="confirmPayOrderDetailTable">
					<tbody>
						<tr>
							<td class="title">订单编号：</td>
							<td class="value">
								<span class="confirmPayOrderNumber">${o.orderCode}</span>
								<span><img src="img/site/confirmOrderTmall.png" wifth="15px"></span>
							</td>
						</tr><tr>
							<td class="title">卖家昵称：</td>
							<td class="value">
								<span class="seller">天猫商铺</span>
								<a>
									<span class="wangwangLogo"></span>
								</a>
							</td>
						</tr><tr>
							<td class="title">收货信息：</td>
							<td class="value">${o.address}，${o.receiver}， ${o.mobile}，${o.post}</td>
						</tr><tr>
							<td class="title">成交时间：</td>
							<td class="value">
								<fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="warningconfirmPay">
					<div class="warningconfirmPayContext">请收到货后，再确认收货！否则您可能钱货两空！</div>
					<a href="foreorderConfirmed?oid=${o.id}"><button class="confirmPayButton">确认支付</button></a>
				</div>
			</div>
	</div>