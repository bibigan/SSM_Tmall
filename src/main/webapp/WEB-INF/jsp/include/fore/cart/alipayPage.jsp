<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<div class="aliPayPageDiv">
		<div class="aliPayPageLogo">
			<img src="img/site/simpleLogo.png" class="pull-left">
		</div>
		<div style="clear:both"></div>
		<div class="payDiv">
			<div class="payDivWord">扫一扫付款（元）</div>
			<div class="payDivPrice">￥
				<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/>
			</div>
			<div>
				<img src="img/site/payme.png" class="paymeImg">
			</div>
			<div>	
				<a href="forepayed?oid=${param.oid}&total=${param.total}"><button class="payBtn">确认支付</button></a>
			</div>
		</div>
	</div>