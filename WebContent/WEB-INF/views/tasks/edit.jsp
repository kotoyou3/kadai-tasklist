<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>id : ${task.id} のタスク編集ページ</h2>

        <!-- タスクの内容を編集するためのフォーム -->
        <form method="POST" action="${pageContext.request.contextPath}/update">
            <!-- 隠しフィールドにタスクのIDをセット -->
            <input type="hidden" name="id" value="${task.id}" />
            <input type="hidden" name="_token" value="${sessionScope._token}" />

            <label for="content">内容:</label>
            <textarea name="content" id="content">${task.content}</textarea>
            <br>

            <!-- 更新ボタン -->
            <input type="submit" value="更新">
        </form>

        <!-- 一覧に戻るリンク -->
        <p><a href="${pageContext.request.contextPath}/index">一覧に戻る</a></p>
        <!-- 削除リンク -->
        <p><a href="#" onclick="confirmDestroy();">このタスクを削除する</a></p>
        <!-- 削除用のフォーム（非表示） -->
        <form method="POST" action="${pageContext.request.contextPath}/destroy" style="display: none;">
            <input type="hidden" name="id" value="${task.id}" />
            <input type="hidden" name="_token" value="${sessionScope._token}" />
        </form>

        <script>
        function confirmDestroy() {
            if(confirm("本当にこのタスクを削除してよろしいですか？")) {
                document.forms[1].submit(); // フォームのインデックスに注意
            }
        }
        </script>
    </c:param>
</c:import>
