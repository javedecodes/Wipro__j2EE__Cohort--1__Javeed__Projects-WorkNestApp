<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css" />
  <style>
    body {
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #fff;
      height: 100vh;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    .container {
      background: #fff;
      color: #333;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      padding: 40px 35px 50px;
      max-width: 400px;
      width: 100%;
      text-align: center;
      transition: box-shadow 0.3s ease;
    }
    .container:hover {
      box-shadow: 0 15px 40px rgba(0,0,0,0.35);
    }
    h2 {
      margin-bottom: 30px;
      font-weight: 700;
      color: #004080;
      letter-spacing: 1.3px;
      font-size: 2rem;
    }
    form p {
      text-align: left;
      margin-bottom: 20px;
      font-weight: 600;
      font-size: 1rem;
      color: #004080;
    }
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #cce0ff;
      border-radius: 12px;
      font-size: 1rem;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    input[type="text"]:focus,
    input[type="password"]:focus {
      outline: none;
      border-color: #004080;
      box-shadow: 0 0 10px rgba(0, 64, 128, 0.4);
    }
    .btn {
      background: linear-gradient(45deg, #0066cc, #004080);
      border: none;
      padding: 14px 30px;
      color: white;
      font-weight: 700;
      font-size: 1.1rem;
      border-radius: 30px;
      cursor: pointer;
      width: 100%;
      box-shadow: 0 6px 15px rgba(0, 102, 204, 0.5);
      transition: background 0.3s ease, box-shadow 0.3s ease;
      margin-top: 10px;
    }
    .btn:hover {
      background: linear-gradient(45deg, #004080, #00264d);
      box-shadow: 0 8px 25px rgba(0, 64, 128, 0.7);
    }
    p.error-msg {
      color: #d93025;
      font-weight: 600;
      margin-bottom: 15px;
      font-size: 0.95rem;
      background: #fdecea;
      border-radius: 8px;
      padding: 10px 15px;
      box-shadow: 0 2px 6px rgba(217, 48, 37, 0.3);
    }
    p.register-link {
      margin-top: 25px;
      font-size: 1rem;
      color: #004080;
    }
    p.register-link a {
      color: #0066cc;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }
    p.register-link a:hover {
      color: #003d80;
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Login</h2>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p class="error-msg"><%= error %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/auth/login" method="post">
      <p>Username or Email:</p>
      <input type="text" name="usernameOrEmail" placeholder="Enter username or email" required />

      <p>Password:</p>
      <input type="password" name="password" placeholder="Enter password" required />

      <input type="submit" value="Login" class="btn" />
    </form>

    <p class="register-link">No account? <a href="<%= request.getContextPath() %>/auth/register">Register here</a></p>
  </div>
</body>
</html>
