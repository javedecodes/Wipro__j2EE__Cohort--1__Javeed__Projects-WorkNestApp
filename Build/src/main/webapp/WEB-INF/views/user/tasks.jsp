<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Task Detail</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css" />
  <style>
    body {
      background-color: #f0f4fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
      line-height: 1.6;
      margin: 0;
      padding: 30px 20px;
    }
    .container {
      max-width: 900px;
      margin: auto;
      background: #ffffff;
      padding: 30px 40px;
      border-radius: 16px;
      box-shadow: 0 15px 35px rgba(0,0,0,0.1);
      border: 1px solid #e1e8f7;
    }
    a {
      color: #1a73e8;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }
    a:hover {
      color: #0046c3;
      text-decoration: underline;
    }
    h2 {
      font-weight: 800;
      color: #004080;
      font-size: 2.4rem;
      margin-bottom: 25px;
      letter-spacing: 1px;
      text-align: center;
    }
    h3 {
      font-weight: 700;
      font-size: 1.8rem;
      color: #003366;
      margin-bottom: 12px;
    }
    h4 {
      font-weight: 700;
      font-size: 1.3rem;
      color: #004080;
      margin-top: 40px;
      margin-bottom: 18px;
      border-bottom: 2px solid #c6dafc;
      padding-bottom: 6px;
    }
    p {
      font-size: 1.05rem;
      margin-bottom: 12px;
      color: #4a4a4a;
    }
    p strong {
      color: #00264d;
    }
    ul {
      list-style-type: none;
      padding-left: 0;
      max-height: 250px;
      overflow-y: auto;
      border: 1px solid #e1e8f7;
      border-radius: 10px;
      background: #f9fbff;
      box-shadow: inset 0 2px 6px rgba(0,0,0,0.05);
    }
    ul li {
      padding: 14px 18px;
      margin: 0;
      border-bottom: 1px solid #d7e0fb;
      font-size: 1rem;
      color: #34495e;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    ul li:last-child {
      border-bottom: none;
    }
    ul li strong {
      color: #2c3e50;
      margin-right: 8px;
    }
    ul li time {
      font-size: 0.85rem;
      color: #8a98b5;
      font-style: italic;
      white-space: nowrap;
      margin-left: 15px;
    }
    form table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 15px;
      margin-top: 10px;
    }
    form td {
      vertical-align: middle;
    }
    form td:first-child {
      width: 90px;
      font-weight: 600;
      color: #004080;
      font-size: 1rem;
    }
    form input[type="text"], form textarea, form input[type="password"] {
      width: 100%;
      padding: 12px 15px;
      font-size: 1rem;
      border-radius: 12px;
      border: 1.8px solid #d0d7e9;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      box-sizing: border-box;
    }
    form input[type="text"]:focus, form textarea:focus, form input[type="password"]:focus {
      border-color: #1a73e8;
      box-shadow: 0 0 10px rgba(26, 115, 232, 0.5);
      outline: none;
    }
    input[type="submit"] {
      background: linear-gradient(135deg, #1a73e8, #0046c3);
      border: none;
      color: white;
      font-weight: 700;
      padding: 12px 30px;
      font-size: 1.1rem;
      border-radius: 30px;
      cursor: pointer;
      margin-top: 15px;
      transition: background 0.4s ease, box-shadow 0.3s ease;
      box-shadow: 0 5px 15px rgba(26,115,232,0.4);
      display: block;
      margin-left: auto;
    }
    input[type="submit"]:hover {
      background: linear-gradient(135deg, #0046c3, #003399);
      box-shadow: 0 8px 25px rgba(0, 70, 195, 0.6);
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Task Detail</h2>
    <p><a href="<%= request.getContextPath() %>/user/dashboard">&larr; Back to Dashboard</a></p>
    
    <h3><%= ((com.worknest.model.Task)request.getAttribute("task")).getTitle() %></h3>
    <p><strong>Description:</strong> <%= ((com.worknest.model.Task)request.getAttribute("task")).getDescription() %></p>
    <p><strong>Status:</strong> <%= ((com.worknest.model.Task)request.getAttribute("task")).getStatus() %></p>

    <h4>Comments</h4>
    <ul>
      <% for(Object cObj : (java.util.List)request.getAttribute("comments")) {
           com.worknest.model.Comment c = (com.worknest.model.Comment)cObj; %>
        <li>
          <span><strong><%= c.getUser().getUsername() %>:</strong> <%= c.getContent() %></span>
          <time>(at <%= c.getCreatedAt() %>)</time>
        </li>
      <% } %>
    </ul>

    <h4>Add Comment</h4>
    <form:form method="post" action="<%= request.getContextPath() %>/tasks/<%= ((com.worknest.model.Task)request.getAttribute("task")).getId() %>/comment" modelAttribute="comment">
      <table>
        <tr>
          <td>Comment:</td>
          <td><form:input path="content" cssClass="input-comment"/></td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="submit" value="Add Comment"/>
          </td>
        </tr>
      </table>
    </form:form>
  </div>
</body>
</html>
