<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 传来当前产品、产品下的属性<-属性值列表、详情图片列表、单个图片列表、评论数、销量、评论列表 -->

<title>模仿天猫官网 ${p.name}</title>

<!-- 分类信息的图片 -->
<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" src="img/category/${p.category.id}.jpg">
</div>
 
<div class="productPageDiv">
<!--     产品基本信息和单个展示图片 -->
    <%@include file="productImgAndInfo.jsp" %>
<!--      产品评论 -->
    <%@include file="productReview.jsp" %>
<!--      产品详情 -->
    <%@include file="productDetail.jsp" %>
</div>