<%@ page import="java.util.List" %>
<%@ page import="com.worknest.model.Comment" %>
<%@ page import="com.worknest.model.Task" %>
<%@ page import="com.worknest.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>User Dashboard</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css" />
  <style>
    body {
      background: #f7f9fc;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      color: #333;
    }
    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px 40px;
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 12px 35px rgba(0,0,0,0.1);
    }
    h2 {
      font-weight: 700;
      color: #004080;
      margin-bottom: 25px;
      font-size: 2rem;
      letter-spacing: 1px;
      text-align: center;
    }
    a.logout-link {
      display: inline-block;
      margin-bottom: 30px;
      color: #0052cc;
      font-weight: 600;
      text-decoration: none;
      float: right;
      font-size: 1rem;
      transition: color 0.3s ease;
    }
    a.logout-link:hover {
      color: #003d99;
      text-decoration: underline;
    }
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 12px;
      background-color: transparent;
    }
    th, td {
      text-align: left;
      padding: 12px 18px;
      vertical-align: top;
    }
    th {
      background-color: #e6f0ff;
      color: #004080;
      font-weight: 700;
      font-size: 1rem;
      border-top-left-radius: 12px;
      border-top-right-radius: 12px;
      user-select: none;
    }
    tr {
      background: #f9fbff;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      border-radius: 12px;
      transition: background-color 0.3s ease;
    }
    tr:hover {
      background: #e1eaff;
    }
    tr td:first-child {
      font-weight: 600;
      color: #003366;
      cursor: pointer;
      transition: color 0.3s ease;
    }
    tr td:first-child:hover {
      color: #0052cc;
      text-decoration: underline;
    }
    form {
      margin: 0;
    }
    select, input[type="text"] {
      font-size: 1rem;
      padding: 8px 12px;
      border-radius: 8px;
      border: 1.5px solid #ccc;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      width: 160px;
    }
    select:focus, input[type="text"]:focus {
      outline: none;
      border-color: #004080;
      box-shadow: 0 0 8px rgba(0, 64, 128, 0.4);
    }
    input[type="submit"] {
      background: linear-gradient(45deg, #0052cc, #003d99);
      border: none;
      color: white;
      font-weight: 700;
      padding: 8px 18px;
      border-radius: 25px;
      cursor: pointer;
      transition: background 0.3s ease, box-shadow 0.3s ease;
      font-size: 1rem;
      margin-left: 10px;
    }
    input[type="submit"]:hover {
      background: linear-gradient(45deg, #003d99, #00264d);
      box-shadow: 0 6px 20px rgba(0, 61, 153, 0.6);
    }
    .comment-box {
      background: #f0f4ff;
      border-left: 4px solid #004080;
      padding: 10px 15px;
      margin: 8px 0;
      border-radius: 8px;
      font-size: 0.9rem;
      color: #003366;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    }
    .comment-box b {
      color: #00264d;
    }
    /* Add comment form styling */
    form.add-comment {
      margin-top: 12px;
      display: flex;
      gap: 12px;
      align-items: center;
    }
    form.add-comment input[type="text"] {
      flex: 1;
      border-radius: 25px;
      padding: 10px 20px;
      border: 1.5px solid #ccc;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      font-size: 1rem;
    }
    form.add-comment input[type="text"]:focus {
      border-color: #004080;
      box-shadow: 0 0 10px rgba(0, 64, 128, 0.5);
      outline: none;
    }
    form.add-comment input[type="submit"] {
      margin-left: 0;
      padding: 10px 25px;
      border-radius: 25px;
      font-weight: 700;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Your Tasks</h2>

    <a href="<%= request.getContextPath() %>/auth/logout" class="logout-link">Logout</a>

    <table>
      <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Start</th>
        <th>Due</th>
        <th>Actions</th>
      </tr>
      <%
        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
        User user = (User) session.getAttribute("loggedInUser");
        if (tasks != null) {
            for (Task t : tasks) {
      %>
        <tr>
          <td><a href="<%= request.getContextPath() %>/tasks/<%= t.getId() %>"><%= t.getTitle() %></a></td>
          <td><%= t.getDescription() != null ? t.getDescription() : "" %></td>
          <td><%= t.getStatus() %></td>
          <td><%= t.getStartDate() %></td>
          <td><%= t.getDueDate() %></td>
          <td>
            <form action="<%= request.getContextPath() %>/user/updateStatus" method="post" style="display:inline;">
              <input type="hidden" name="taskId" value="<%= t.getId() %>"/>
              <select name="status">
                <option value="PENDING" <%= t.getStatus() == com.worknest.model.TaskStatus.PENDING ? "selected" : "" %>>Pending</option>
                <option value="IN_PROGRESS" <%= t.getStatus() == com.worknest.model.TaskStatus.IN_PROGRESS ? "selected" : "" %>>In Progress</option>
                <option value="COMPLETED" <%= t.getStatus() == com.worknest.model.TaskStatus.COMPLETED ? "selected" : "" %>>Completed</option>
              </select>
              <input type="submit" value="Update"/>
            </form>
          </td>
        </tr>
        <tr>
          <td colspan="6">
            <b>Comments:</b>
            <%
              List<Comment> comments = t.getComments();
              if (comments != null && !comments.isEmpty()) {
                for (Comment c : comments) {
            %>
              <div class="comment-box">
                <b><%= c.getUser() != null ? c.getUser().getUsername() : "Unknown" %>:</b> <%= c.getContent() %>
              </div>
            <%
                }
              } else {
            %>
              <div class="comment-box">No comments yet.</div>
            <%
              }
            %>

            <!-- Add comment form -->
            <form action="<%= request.getContextPath() %>/user/addComment" method="post" class="add-comment">
              <input type="hidden" name="taskId" value="<%= t.getId() %>"/>
              <input type="text" name="content" placeholder="Add a comment..." required />
              <input type="submit" value="Add" />
            </form>
          </td>
        </tr>
      <%
            }
        }
      %>
    </table>
  </div>
</body>
</html>
