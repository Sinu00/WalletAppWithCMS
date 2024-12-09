<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #0a0a0a;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            line-height: 1.6;
            background-image: 
                radial-gradient(at 27% 37%, hsla(215, 98%, 21%, 0.3) 0px, transparent 0%),
                radial-gradient(at 97% 21%, hsla(227, 100%, 24%, 0.25) 0px, transparent 50%),
                radial-gradient(at 52% 99%, hsla(210, 89%, 24%, 0.2) 0px, transparent 50%),
                radial-gradient(at 10% 29%, hsla(256, 96%, 24%, 0.15) 0px, transparent 50%),
                radial-gradient(at 97% 96%, hsla(38, 60%, 74%, 0.1) 0px, transparent 50%),
                radial-gradient(at 33% 50%, hsla(222, 67%, 73%, 0.1) 0px, transparent 50%);
        }

        .login-container {
            background-color: rgba(17, 24, 39, 0.8);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 400px;
            padding: 40px;
            text-align: center;
            backdrop-filter: blur(16px);
        }

        .login-logo {
            margin-bottom: 30px;
        }

        .login-logo img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.05));
        }

        .login-title {
            font-size: 24px;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 30px;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            background-color: rgba(31, 41, 55, 0.8);
            border: 1px solid rgba(55, 65, 81, 0.5);
            border-radius: 8px;
            color: #ffffff;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: rgba(59, 130, 246, 0.7);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .form-group label {
            position: absolute;
            top: -10px;
            left: 15px;
            background-color: rgba(17, 24, 39, 0.8);
            padding: 0 5px;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.6);
            transition: all 0.3s ease;
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label {
            top: -10px;
            font-size: 12px;
            color: rgba(59, 130, 246, 0.9);
        }

        .login-button {
            background: linear-gradient(to right, rgba(59, 130, 246, 0.8), rgba(79, 70, 229, 0.8));
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .login-button:hover {
            background: linear-gradient(to right, rgba(59, 130, 246, 0.9), rgba(79, 70, 229, 0.9));
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .login-button:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }

        .login-footer {
            margin-top: 20px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }

        .login-footer a {
            color: rgba(59, 130, 246, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .login-footer a:hover {
            color: rgba(79, 70, 229, 0.9);
        }

        .error-message {
            color: #ff4d4d;
            font-size: 14px;
            margin-top: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">
            <img src="/api/placeholder/80/80" alt="Company Logo">
        </div>
        <h2 class="login-title">Welcome Admin</h2>
        <p class="login-subtitle">Sign in to continue to your dashboard</p>
        
        <form id="loginForm" class="login-form" method="POST" action="adminauth">
            <div class="form-group">
                <input 
                    type="text" 
                    id="username" 
                    name="username" 
                    placeholder="Enter Your Username" 
                    required
                >
                <label for="username">Username</label>
            </div>
            
            <div class="form-group">
                <input 
                    type="password" 
                    id="password" 
                    name="password" 
                    placeholder="Enter Your Password" 
                    required
                >
                <label for="password">Password</label>
            </div>

			<div id="errorMessage" class="error-message">
				<%
				if (request.getAttribute("error") != null) {
				%>
				<%=request.getAttribute("error")%>
				<%
				}
				%>
			</div>


			<button type="submit" class="login-button">Sign In</button>
        </form>
    </div>

</body>
</html>