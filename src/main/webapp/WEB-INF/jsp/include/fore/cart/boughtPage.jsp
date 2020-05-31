<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 传来os -->

<script>
$(function(){
$("button.deleteConfirmButton").click(function(){
	deleteOrder = true;
	$("#deleteConfirmModal").modal('hide');
});	
//绑定事件 
 //通过ajax访问后端的服务，一旦后端把数据删除掉后，返回消息给前端，前端确认删除成功后，把该行订单数据隐藏掉
 $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
	 if(deleteOrder){
			var page="foredeleteOrder";//点击确认删除
			$.post(
				    page,
				    {"oid":deleteOrderid},
				    function(result){
						if("success"==result){
							console.log("确认删除");
							$("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
						}
						else{
							location.href="loginPage";
						}
				    }
				);
		}
 }); 
 $(".ask2delivery").click(function(){//点击卖家发货
		var link = $(this).attr("link");
		$(this).hide();
		page = link;
		$.ajax({
			   url: page,
			   success: function(result){
				alert("卖家已秒发，刷新当前页面，即可进行确认收货")
			   }
			});
		
	});
});
</script>


<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a href="#nowhere" orderstatus="all">所有订单</a></div>
        <div class=""><a href="#nowhere" orderstatus="waitPay">待付款</a></div>
        <div class=""><a href="#nowhere" orderstatus="waitDelivery">待发货</a></div>
        <div class=""><a href="#nowhere" orderstatus="waitConfirm">待收货</a></div>
        <div class=""><a class="noRightborder" href="#nowhere" orderstatus="waitReview">待评价</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder"> </a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tbody><tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </tbody></table>
    </div>
    <div class="orderListItem">
    
    	<c:forEach items="${os}" var="o">
<!--     	每个订单 -->
            <table oid="${o.id}" orderstatus="${o.status}" class="orderListItemTable" style="display: table;">
                <tbody>
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                    <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                    <span>订单号: ${o.orderCode}
                    </span>
                    </td>
                    <td colspan="2"><img width="13px" src="img/site/orderItemTmall.png">天猫商场</td>
                    <td colspan="1">
                        <a href="#nowhere" class="wangwanglink">
                            <div class="orderItemWangWangGif"></div>
                        </a>
                    </td>
                    <td class="orderItemDeleteTD">
                        <a href="#nowhere" oid="${o.id}" class="deleteOrderLink">
<!--                         蹦出确认删除的窗口 -->
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>
                
                <c:forEach items="${o.orderItemList}" var="oi" varStatus="st">
<!--                 每个订单项 -->
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                            <img title="支持信用卡支付" src="img/site/creditcard.png">
                                            <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                            <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">                       
                                </div>
                            </div>
                        </td>
                        <td width="100px" class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductoriginalPrice">￥
                            	<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/>
                            </div>
                            <div class="orderListItemProductPrice">￥
                            	<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/>
                            </div>
                        </td>
                        <c:if test="${st.count==1}">
<!--                         该订单的总数 -->
                            <td width="100px" valign="top" class="orderListItemNumberTD orderItemOrderInfoPartTD" rowspan="${fn:length(o.orderItemList)}">
                                <span class="orderListItemNumber">${o.totalNumber}</span>
                            </td>
<!--                         该订单的总金额 -->
                            <td width="120px" valign="top" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" rowspan="${fn:length(o.orderItemList)}">
                                <div class="orderListItemProductRealPrice">￥
                                	<fmt:formatNumber type="number" value="${o.total}" minFractionDigits="2"/>
                                </div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td width="100px" valign="top" class="orderListItemButtonTD orderItemOrderInfoPartTD" rowspan="${fn:length(o.orderItemList)}">
<!--                                 该订单的状态 -->

                                <c:if test="${o.status=='waitConfirm' }">
<!--                                 状态是待确认收货 -->
                                    <a href="foreconfirmPay?oid=${o.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                
                                <c:if test="${o.status=='waitPay' }">
<!--                                状态是待支付 -->
                                    <a href="forealipay?oid=${o.id}&total=${o.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>                             
                                </c:if>
<!--                                状态是待发货 -->
                                <c:if test="${o.status=='waitDelivery'}">
                                    <span>待发货</span>
                                    <button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催卖家发货</button>
                                     
                                </c:if>
<!--  								状态是待评价 -->
                                <c:if test="${o.status=='waitReview' }">
                                    <a href="forereview?oid=${o.id}">
                                        <button  class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                            </td>   
                         </c:if>               
                    </tr>   
                </c:forEach>
                
            </tbody>
            </table>       
    	</c:forEach>	
    	
    </div>
</div>