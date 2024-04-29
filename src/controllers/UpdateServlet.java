package controllers;

import java.io.IOException;
import java.sql.Timestamp;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Task;
import utils.DBUtil;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String _token = request.getParameter("_token");
        if (_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();

            Task task = em.find(Task.class, (Integer) (request.getSession().getAttribute("task_id")));

            String content = request.getParameter("content");
            task.setContent(content);

            // 現在のタイムスタンプを取得
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            task.setUpdatedAt(currentTime);
            em.getTransaction().begin();
            em.merge(task);
            em.getTransaction().commit();
            em.close();

            // タスクIDをセッションスコープから削除
            request.getSession().removeAttribute("task_id");

            // インデックスページへリダイレクト
            response.sendRedirect(request.getContextPath() + "/index");
        }
    }
}