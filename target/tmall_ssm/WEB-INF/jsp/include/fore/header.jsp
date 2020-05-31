<!-- 声明为html5格式 -->
<!DOCTYPE html> 
<!-- 让浏览器以UTF显示中文，本页面的中文文字采用UTF-8编码，启动EL表达式 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 标准标签库 -->
<!-- c通常用于条件判断和遍历 -->
<!-- fmt用于格式化日期和货币 -->
<!-- fn用于校验长度 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 引入bootstrap和jquery -->
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 自定义前端样式 -->
<link href="css/fore/foreStyle.css" rel="stylesheet">
<!-- 各种自定义函数和事件监听 -->
<script src="js/fore.js"></script>