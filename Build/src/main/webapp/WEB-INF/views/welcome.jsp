<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>WorkNest - Welcome</title>

  <!-- Google Fonts for premium feel -->
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;800&display=swap" rel="stylesheet">

  <style>
    /* Reset */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body, html {
      height: 100%;
      font-family: 'Montserrat', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #0f111a;
      color: #f0f4f8;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
      position: relative;
    }

    /* Animated tech grid background */
    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: radial-gradient(circle at center, #111827 0%, #0f111a 70%);
      z-index: 0;
    }

    /* Animated circuit grid pattern */
    .grid {
      position: fixed;
      top: 0; left: 0;
      width: 100%;
      height: 100%;
      background-image:
        linear-gradient(to right, #0f6f49 1px, transparent 1px),
        linear-gradient(to bottom, #0f6f49 1px, transparent 1px);
      background-size: 40px 40px;
      opacity: 0.12;
      animation: gridShift 20s linear infinite;
      z-index: 1;
      pointer-events: none;
    }

    @keyframes gridShift {
      0% {
        background-position: 0 0, 0 0;
      }
      100% {
        background-position: 40px 40px, 40px 40px;
      }
    }

    /* Floating glowing circles with neon tech colors */
    .background {
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      z-index: 2;
      overflow: hidden;
      pointer-events: none;
    }

    .circle {
      position: absolute;
      border-radius: 50%;
      background: rgba(15, 111, 73, 0.15);
      box-shadow: 0 0 40px 15px rgba(15, 111, 73, 0.7);
      animation: float 18s ease-in-out infinite;
      filter: blur(14px);
      mix-blend-mode: screen;
    }

    .circle:nth-child(1) {
      width: 320px; height: 320px;
      top: 15%;
      left: 10%;
      animation-delay: 0s;
    }
    .circle:nth-child(2) {
      width: 400px; height: 400px;
      top: 70%;
      left: 70%;
      animation-delay: 7s;
    }
    .circle:nth-child(3) {
      width: 180px; height: 180px;
      top: 45%;
      left: 45%;
      animation-delay: 13s;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0) translateX(0); }
      50% { transform: translateY(-35px) translateX(25px); }
    }

    /* Container with fade-in */
    .container {
      position: relative;
      z-index: 10;
      background-color: rgba(20, 30, 27, 0.85);
      padding: 60px 80px;
      border-radius: 25px;
      box-shadow: 0 20px 50px rgba(0, 255, 170, 0.6);
      max-width: 480px;
      width: 100%;
      text-align: center;
      backdrop-filter: blur(15px);
      -webkit-backdrop-filter: blur(15px);
      animation: fadeIn 1.2s ease forwards;
      opacity: 0;
      border: 1.5px solid rgba(0, 255, 170, 0.7);
    }

    @keyframes fadeIn {
      to { opacity: 1; }
    }

    h1 {
      font-size: 3.8rem;
      margin-bottom: 50px;
      letter-spacing: 2.5px;
      font-weight: 800;
      color: #00ffaa;
      text-shadow: 0 0 20px #00ffaa, 0 0 40px #00ffaa;
    }

    .btn {
      display: inline-block;
      margin: 15px 20px;
      padding: 18px 48px;
      font-size: 1.2rem;
      font-weight: 700;
      color: #0f111a;
      background: linear-gradient(135deg, #00ffaa, #005f3a);
      border: none;
      border-radius: 60px;
      cursor: pointer;
      text-decoration: none;
      box-shadow:
        0 10px 30px rgba(0, 255, 170, 0.8),
        0 6px 15px rgba(0, 95, 58, 0.8);
      transition: transform 0.25s ease, box-shadow 0.25s ease;
      user-select: none;
      letter-spacing: 1.2px;
      filter: drop-shadow(0 0 0.3rem #00ffaa);
    }

    .btn:hover,
    .btn:focus {
      background: linear-gradient(135deg, #005f3a, #00ffaa);
      box-shadow:
        0 14px 40px rgba(0, 95, 58, 0.9),
        0 10px 25px rgba(0, 255, 170, 0.95);
      transform: scale(1.07) translateY(-4px);
      outline: none;
      color: #0f111a;
      filter: drop-shadow(0 0 0.5rem #00ffaa);
    }

    @media (max-width: 480px) {
      .container {
        padding: 40px 30px;
      }
      h1 {
        font-size: 2.8rem;
        margin-bottom: 35px;
      }
      .btn {
        padding: 14px 36px;
        font-size: 1rem;
        margin: 12px 15px;
      }
    }
  </style>
</head>
<body>
  <div class="grid"></div>
  <div class="background">
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>
  </div>

  <div class="container" role="main" aria-label="Welcome to WorkNest">
    <h1>Welcome to WorkNest</h1>
    <a href="<%=request.getContextPath()%>/auth/login" class="btn" role="button" aria-label="Login">Login</a>
    <a href="<%=request.getContextPath()%>/auth/register" class="btn" role="button" aria-label="Register">Register</a>
  </div>
</body>
</html>
