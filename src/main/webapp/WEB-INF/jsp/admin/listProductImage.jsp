<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>

	// 	对分类名称和分类图片做了为空判断，当为空的时候，不能提交
	$(function(){

		$("form.addFormSingle").submit(function(){
			if(!checkEmpty("filepathSingle","产品单个图片"))
				return false;
			return true;

		});
		$("form.addFormDetail").submit(function(){
			if(!checkEmpty("filepathDetail","产品详情图片"))
				return false;
			return true;
		});
	});

</script>

<title>图片管理</title>
<!-- productImageServlet 传来product、singleImgList、detailImgList -->
<div class="workingArea">

	<ol class="breadcrumb">
	  <li><a href="admin_category_list">所有分类</a></li>
	  <li><a href="admin_product_list?cid=${product.category.id}">${product.category.name}</a></li>
	  <li class="active">${product.name}</li>
	  <li class="active">产品图片管理</li>
	</ol>
	
	<table class="addPictureTable" align="center">
		<tr>
<!-- 		新增产品 单个 图片 -->
			<td class="addPictureTableTD">
			  <div>
			  	<div class="panel panel-warning addPictureDiv">
			    	<div class="panel-heading">新增产品<b class="text-primary"> 单个 </b>图片</div>
			    	<div class="panel-body">
			    		<form action="admin_productImage_add" class="addFormSingle" method="post" enctype="multipart/form-data">
			    			<table class="addTable">
			    				<tr>
			    					<td>请选择本地图片 尺寸400X400 为佳</td>
			    				</tr>
			    				<tr>
			    					<td>
			    						<input type="file"  name="image" id="filepathSingle">
			    					</td>
			    				</tr>
			    				<tr class="submitTR">
				    				<td align="center">
				    					<input type="hidden" name="type" value="type_single" />
				    					<input type="hidden" name="pid" value="${product.id}" />
				    					<button type="submit" class="btn btn-success">提 交</button>
				    				</td>
				    			</tr>
			    			</table>
			    		</form>
			    	</div>
		    	</div>
		    	<table class="table table-striped table-bordered table-hover  table-condensed"> 
		    		<thead>
		    			<tr class="success">
		    				<th>ID</th>
		    				<th>产品单个图片缩略图</th>
		    				<th>删除</th>
		    			</tr>
		    		</thead>
		    		<tbody>
		    			<c:forEach items="${singleImgList}" var="m">
		    				<tr>
		    					<td>${m.id}</td>
		    					<td><a title="点击查看原图" href="img/productSingle/${m.id}.jpg">
		    						<img height="50px" src="img/productSingle/${m.id}.jpg">
		    					</a></td>
		    					<td><a deleteLink="true" href="admin_productImage_delete?id=${m.id}">
		    						<span class="glyphicon glyphicon-trash"></span>
		    					</a></td>
		    				</tr>
		    			</c:forEach>
		    		</tbody>
		    	</table>
			  </div>
			</td>
<!-- 		新增产品 详情 图片 -->
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-warning addPictureDiv">
				    	<div class="panel-heading">新增产品<b class="text-primary"> 详情 </b>图片</div>
				    	<div class="panel-body">
				    		<form action="admin_productImage_add" class="addFormDetail" method="post" enctype="multipart/form-data">
				    			<table class="addTable">
				    				<tr>
				    					<td>请选择本地图片 宽度790 为佳</td>
				    				</tr>
				    				<tr>
				    					<td>
				    						<input type="file"  name="image" id="filepathDetail">
				    					</td>
				    				</tr>
				    				<tr class="submitTR">
					    				<td align="center">
					    					<input type="hidden" name="type" value="type_detail" />
					    					<input type="hidden" name="pid" value="${product.id}" />
					    					<button type="submit" class="btn btn-success">提 交</button>
					    				</td>
					    			</tr>
				    			</table>
				    		</form>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover  table-condensed"> 
						<thead>
			    			<tr class="success">
			    				<th>ID</th>
			    				<th>产品详情图片缩略图</th>
			    				<th>删除</th>
			    			</tr>
			    		</thead>
			    		<tbody>
			    			<c:forEach items="${detailImgList}" var="m">
			    				<tr>
			    					<td>${m.id}</td>
			    					<td><a title="点击查看原图" href="img/productDetail/${m.id}.jpg">
			    						<img height="50px" src="img/productDetail/${m.id}.jpg">
			    					</a></td>
			    					<td><a deleteLink="true" href="admin_productImage_delete?id=${m.id}">
			    						<span class="glyphicon glyphicon-trash"></span>
			    					</a></td>
			    				</tr>
			    			</c:forEach>
			    		</tbody>
			    	</table>
				</div>
			</td>
		</tr>
	</table>	
</div>