package controllers;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Task;
import utils.DBUtil;

@WebServlet("/destroy")
public class DestroyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DestroyServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CSRFトークンのチェック
        String _token = request.getParameter("_token");
        if (_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();

            // トランザクションの開始
            EntityTransaction tx = em.getTransaction();
            tx.begin();
            try {
                // リクエストパラメータからタスクのIDを取得
                int taskId = Integer.parseInt(request.getParameter("id"));
                Task task = em.find(Task.class, taskId);

                // タスクが存在すれば削除
                if (task != null) {
                    em.remove(task); // タスクを削除
                    tx.commit();
                    System.out.println("Task with ID: " + taskId + " has been deleted."); // 削除のログ出力
                } else {
                    tx.rollback();
                    System.out.println("No task found with ID: " + taskId); // タスクが見つからない場合のログ出力
                }
            } catch (Exception e) {
                tx.rollback();
                e.printStackTrace(); // エラーのスタックトレースを出力
                throw new ServletException("Deleting task failed.", e);
            } finally {
                em.close();
            }

            // 一覧ページへリダイレクト
            response.sendRedirect(request.getContextPath() + "/index");
        } else {
            // CSRFトークン不一致の場合は何もせずに一覧ページへリダイレクト
            response.sendRedirect(request.getContextPath() + "/index");
        }
    }
}