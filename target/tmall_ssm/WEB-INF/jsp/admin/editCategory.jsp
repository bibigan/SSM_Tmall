<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>

// 增加操作一定会提交图片，而修改不一定提交图片,只判断名字为空
$(function(){
	
	$("#editForm").submit(function(){
		if(!checkEmpty("name","分类名称"))
			return false;

		return true;
	});
});
</script>

<title>编辑分类</title>
<div class="workingArea">
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li>编辑分类</li>
	</ol>
	<div class="panel panel-warning editDiv">
	  <div class="panel-heading">编辑分类</div>
	  <div class="panel-body">
<!--       	1. form的action="admin_category_update"，会导致访问CategoryServlet的update()方法 -->
			<form action="admin_category_update" method="post" id="editForm" enctype="multipart/form-data">
				<table class="editTable">
					<tr>
                        <td>分类名称</td>
                        <td><input  id="name" name="name" type="text" class="form-control" value="${category.name}"></td>
                    </tr>
                    <tr>
                        <td>分类圖片</td>
                        <td>
<!--       需要提供type="file" 的字段进行上传
           accept="image/*" 这样把上传的文件类型限制在了图片 -->
							<input id="categoryPic" accept="image/*" type="file" name="image" />
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                        	<input type="hidden" name="id" value="${category.id}">
                            <button type="submit" class="btn btn-success">提 交</button>
                        </td>
                    </tr>
				</table>
			</form>
	  </div>
	</div>
</div>