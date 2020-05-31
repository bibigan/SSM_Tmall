<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
// 	对名称做了为空判断，当为空的时候，不能提交
$(function(){	
	$("#editForm").submit(function(){
		if(!checkEmpty("name","产品名称"))
			return false;
		if(!checkEmpty("subTitle","产品小标题"))
			return false;
		if(!checkEmpty("originalPrice","原价格"))
			return false;
		if(!checkEmpty("promotePrice","优惠价格"))
			return false;
		if(!checkEmpty("stock","库存"))
			return false;
		return true;
	});
});
</script>

<title>编辑属性</title>

<!-- productServlet 传来product -->

<div class="workingArea">
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_product_list?cid=${product.category.id}">${product.category.name}</a></li>
		<li class="active">编辑产品</li>
	</ol>
	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑产品</div>
		   <div class="panel-body">
			<form action="admin_product_update" method="post" id="editForm">
				<table class="editTable">
					<tr>
    					<td>产品名称</td>
    					<td><input type="text" name="name" id="name" value="${product.name}" class="form-control"></td>
    				</tr>
    				<tr>
    					<td>产品小标题 </td>
    					<td><input type="text" name="subTitle" id="subTitle" value="${product.subTitle}" class="form-control"></td>
    				</tr>
    				<tr>
    					<td>原价格</td>
    					<td><input type="text" name="originalPrice" id="originalPrice" value="${product.originalPrice}" class="form-control"></td>
    				</tr>
    				<tr>
    					<td>优惠价格</td>
    					<td><input type="text" name="promotePrice" id="promotePrice" value="${product.promotePrice}" class="form-control"></td>
    				</tr>
    				<tr>
    					<td>库存</td>
    					<td><input type="text" name="stock" id="stock" value="${product.stock}" class="form-control"></td>
    				</tr>
    				<tr class="submitTR">
    					<td colspan="2" align="center">
    					    <input type="hidden" name="id" value="${product.id}">
    						<input type="hidden" name="cid" value="${product.category.id}">
    						<button type="submit" class="btn btn-success">提 交</button>
    					</td>
    				</tr>
				</table>
			</form>
		</div>
	</div>
</div>