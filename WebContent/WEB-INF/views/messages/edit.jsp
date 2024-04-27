<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>id : ${task.id} のタスク編集ページ</h2>

        <form method="POST" action="${pageContext.request.contextPath}/update">
            <!-- 隠しフィールドにタスクのIDをセット -->
            <input type="hidden" name="_token" value="${_token}" />
            <!-- タスクの内容を編集するためのフォーム -->
            <input type="hidden" name="id" value="${task.id}" />
            <label for="content">内容:</label>
            <textarea name="content" id="content">${task.content}</textarea>
            <br>
            <input type="submit" value="更新">
        </form>

        <p><a href="${pageContext.request.contextPath}/index">一覧に戻る</a></p>
        <p><a href="#" onclick="confirmDestroy();">このタスクを削除する</a></p>
        <form method="POST" action="${pageContext.request.contextPath}/destroy">
            <input type="hidden" name="_token" value="${_token}" />
            <!-- 削除するタスクのIDをセット -->
            <input type="hidden" name="id" value="${task.id}" />
        </form>
        <script>
        function confirmDestroy() {
            if(confirm("本当に削除してよろしいですか？")) {
                document.forms[2].submit();
            }
        }
        </script>
    </c:param>
</c:import>
