<%@ page import="java.util.List" %>
<%@ page import="com.worknest.model.Task" %>
<%@ page import="com.worknest.model.User" %>
<%@ page import="com.worknest.model.Comment" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css" />
  <style>
    /* Container */
    .container {
      max-width: 1200px;
      margin: 40px auto;
      padding: 0 20px 40px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }

    h2, h3 {
      color: #004080;
      font-weight: 700;
      margin-bottom: 20px;
      letter-spacing: 1.2px;
    }

    /* Buttons */
    .btn {
      display: inline-block;
      background: linear-gradient(45deg, #0066cc, #004080);
      color: white;
      padding: 10px 18px;
      border: none;
      border-radius: 30px;
      cursor: pointer;
      font-weight: 600;
      font-size: 0.9rem;
      box-shadow: 0 4px 12px rgba(0, 102, 204, 0.4);
      transition: background 0.3s ease, box-shadow 0.3s ease;
      text-decoration: none;
    }
    .btn:hover {
      background: linear-gradient(45deg, #004080, #00264d);
      box-shadow: 0 6px 20px rgba(0, 64, 128, 0.6);
    }

    /* Table */
    table {
      border-collapse: separate;
      border-spacing: 0 12px;
      width: 100%;
      margin-bottom: 30px;
    }

    th, td {
      padding: 12px 18px;
      background: #f8faff;
      border-bottom: 1px solid #ddd;
      vertical-align: top;
      text-align: left;
    }

    th {
      background: #004080;
      color: #fff;
      font-weight: 600;
      font-size: 1rem;
      border-radius: 12px 12px 0 0;
      box-shadow: inset 0 -3px 6px rgba(0,0,0,0.15);
    }

    tr:hover td {
      background: #e6f0ff;
    }

    /* Card sections */
    .card {
      background: #f0f5ff;
      padding: 30px 30px 40px;
      border-radius: 15px;
      box-shadow: 0 6px 15px rgba(0, 64, 128, 0.1);
      margin-bottom: 50px;
      transition: box-shadow 0.3s ease;
    }
    .card:hover {
      box-shadow: 0 8px 25px rgba(0, 64, 128, 0.2);
    }

    /* Forms */
    form label {
      display: block;
      font-weight: 600;
      margin-bottom: 8px;
      color: #004080;
    }
    form input[type="text"],
    form input[type="date"],
    form textarea,
    form select {
      width: 100%;
      padding: 10px 14px;
      margin-bottom: 20px;
      border: 2px solid #cce0ff;
      border-radius: 10px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    form input[type="text"]:focus,
    form input[type="date"]:focus,
    form textarea:focus,
    form select:focus {
      border-color: #004080;
      outline: none;
      box-shadow: 0 0 8px rgba(0, 64, 128, 0.4);
    }
    form textarea {
      resize: vertical;
      min-height: 80px;
    }

    /* Status badges */
    .status-badge {
      display: inline-block;
      padding: 6px 15px;
      border-radius: 25px;
      font-weight: 700;
      font-size: 0.9rem;
      color: #fff;
      text-transform: uppercase;
      letter-spacing: 1px;
      user-select: none;
      box-shadow: 0 3px 8px rgba(0,0,0,0.15);
      transition: background 0.3s ease;
    }
    .status-pending {
      background: #f39c12; /* orange */
    }
    .status-inprogress {
      background: #2980b9; /* blue */
    }
    .status-completed {
      background: #27ae60; /* green */
    }
    .status-delayed {
      background: #c0392b; /* red */
    }

    /* Comment box */
    .comment-box {
      margin-left: 20px;
      padding: 10px 15px;
      border-left: 4px solid #004080;
      margin-top: 10px;
      background-color: #dce9ff;
      font-size: 0.9rem;
      border-radius: 6px;
      color: #003366;
      box-shadow: 0 1px 5px rgba(0,0,0,0.05);
    }

    /* Confirmation form button */
    form input[type="submit"].btn {
      width: auto;
      padding: 8px 18px;
      font-weight: 700;
      font-size: 0.9rem;
      border-radius: 25px;
    }

    hr {
      border: none;
      height: 1px;
      background: #004080;
      opacity: 0.1;
      margin: 50px 0;
    }

    /* Responsive */
    @media (max-width: 900px) {
      .container {
        padding: 20px;
        margin: 20px auto;
      }
      table, th, td {
        font-size: 0.9rem;
      }
      form input[type="text"],
      form input[type="date"],
      form textarea,
      form select {
        font-size: 0.9rem;
      }
    }
  </style>
</head>
<body>
  <div class="container">

    <h2>Admin Dashboard</h2>

    <p><a href="<%= request.getContextPath() %>/auth/logout" class="btn">Logout</a></p>

    <!-- Users Section -->
    <div class="card">
      <h3>All Users</h3>
      <table>
        <tr>
          <th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Action</th>
        </tr>
        <%
          List<User> users = (List<User>) request.getAttribute("users");
          if (users != null) {
              for (User u : users) {
        %>
        <tr>
          <td><%= u.getId() %></td>
          <td><%= u.getUsername() %></td>
          <td><%= u.getEmail() %></td>
          <td><%= u.getRole() %></td>
          <td>
            <form action="<%= request.getContextPath() %>/admin/deleteUser" method="post" 
                  onsubmit="return confirm('Are you sure you want to delete user <%= u.getUsername() %>?');" style="display:inline">
              <input type="hidden" name="userId" value="<%= u.getId() %>" />
              <input type="submit" value="Delete" class="btn" />
            </form>
          </td>
        </tr>
        <%
              }
          }
        %>
      </table>
    </div>

    <hr/>

    <!-- Assign Task Section -->
    <div class="card">
      <h3>Assign New Task</h3>
      <form action="<%= request.getContextPath() %>/admin/assignTask" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required />

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea>

        <label for="startDate">Start Date:</label>
        <input type="date" id="startDate" name="startDate" required />

        <label for="dueDate">Due Date:</label>
        <input type="date" id="dueDate" name="dueDate" required />

        <label for="assignedUserId">Assign to User:</label>
        <select id="assignedUserId" name="assignedUserId" required>
          <option value="">--Select User--</option>
          <%
            if (users != null) {
              for (User u : users) {
          %>
            <option value="<%= u.getId() %>"><%= u.getUsername() %></option>
          <%
              }
            }
          %>
        </select>

        <input type="submit" value="Assign Task" class="btn" />
      </form>
    </div>

    <hr/>

    <!-- Tasks Section -->
    <div class="card">
      <h3>All Tasks</h3>
      <table>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Start Date</th>
          <th>Due Date</th>
          <th>Assigned User</th>
          <th>Status</th>
        </tr>
        <%
          List<Task> tasks = (List<Task>) request.getAttribute("tasks");
          if (tasks != null) {
              for (Task t : tasks) {
        %>
        <tr>
          <td><%= t.getId() %></td>
          <td><%= t.getTitle() %></td>
          <td><%= t.getDescription() != null ? t.getDescription() : "" %></td>
          <td><%= t.getStartDate() %></td>
          <td><%= t.getDueDate() %></td>
          <td><%= t.getAssignedUser() != null ? t.getAssignedUser().getUsername() : "Unassigned" %></td>
          <td>
            <span class="status-badge
              <%
                if (t.getStatus() != null) {
                  switch (t.getStatus().name().toLowerCase()) {
                    case "pending": out.print(" status-pending"); break;
                    case "inprogress": out.print(" status-inprogress"); break;
                    case "completed": out.print(" status-completed"); break;
                    case "delayed": out.print(" status-delayed"); break;
                    default: break;
                  }
                }
              %>">
              <%= t.getStatus() != null ? t.getStatus().name() : "N/A" %>
            </span>
          </td>
        </tr>
        <tr>
          <td colspan="7">
            <b>Comments:</b><br/>
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
              <div class="comment-box">No comments available.</div>
            <%
              }
            %>
          </td>
        </tr>
        <%
              }
          }
        %>
      </table>
    </div>

  </div>
</body>
</html>
