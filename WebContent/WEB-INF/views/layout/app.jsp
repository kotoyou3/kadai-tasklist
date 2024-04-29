<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="UTF-8">
        <title>タスクリストアプリケーション</title> <!-- ここを適切なタイトルに変更 -->
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <h1>タスクリスト管理</h1> <!-- ここをアプリケーションに合った見出しに変更 -->
            </div>
            <div id="content">
                ${param.content}
            </div>
            <div id="footer">
                by Taro Kirameki.
            </div>
        </div>
    </body>
</html>
