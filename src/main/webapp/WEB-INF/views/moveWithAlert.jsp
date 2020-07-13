<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>loginAlert JSP</title>
</head>
<body>
	<script type="text/javascript">
		var message = '${msg}';
		var returnUrl = '${url}';
		alert(message);
		document.location.href = returnUrl;
	</script>
</body>
</html>