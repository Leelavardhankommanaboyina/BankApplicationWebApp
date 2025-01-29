<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Banking Application</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100%;
            overflow: hidden;
            background-color: black;
            color: white;
        }

        .video-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -2;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 5px 15px;
            width: 95%;
            position: fixed;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            height: 50px;
        }

        .navbar-left {
            display: flex;
            align-items: center;
        }

        .navbar-left img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
            margin-right: 10px;
            border: 2px solid white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .navbar-left img:hover {
            transform: scale(1.1);
        }

        .navbar-right {
            display: flex;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-size: 18px;
            transition: background-color 0.3s, transform 0.3s;
            border-radius: 5px;
        }

        .navbar a:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }

        .navbar a.active {
            background-color: #0056b3;
        }

        .star-field {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
            perspective: 800px;
            transform-style: preserve-3d;
        }

        .star {
            position: absolute;
            background-color: white;
            width: 5px;
            height: 5px;
            border-radius: 50%;
            animation: moveStar 3s linear infinite;
        }

        @keyframes moveStar {
            from {
                transform: translateZ(1000px) translateX(0) translateY(0);
                opacity: 1;
            }
            to {
                transform: translateZ(-1000px) translateX(0) translateY(0);
                opacity: 0;
            }
        }

        .image-container {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 150px;
            height: 100px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            padding: 5px;
        }

        .image-container img {
            position: absolute;
            width: 150%;
            height: 150%;
            max-height: 100%;
            object-fit: cover;
            transition: opacity 1s ease-in-out, transform 1s ease-in-out;
            border-radius: 5px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
        }

        .image-container img.hidden {
            opacity: 0;
        }

        /* Welcome Text */
        .welcome-text {
            position: fixed;
            top: 75px;
            left: 20px;
            font-size: 28px;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            z-index: 1000;
            opacity: 0;
            white-space: nowrap;
            overflow: hidden;
            border-right: 2px solid white; /* Cursor effect */
        }

        .center-logo {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotateX(0deg) rotateY(0deg);
            width: 300px;
            height: 300px;
            background-image: url('bankLogo.jpeg');
            background-size: cover;
            background-repeat: no-repeat;
            animation: rotateLogo 8s infinite linear;
            perspective: 800px;
        }

        /* 3D Rotate Effect */
        @keyframes rotateLogo {
            0% {
                transform: translate(-50%, -50%) rotateX(0deg) rotateY(0deg);
            }
            50% {
                transform: translate(-50%, -50%) rotateX(360deg) rotateY(360deg);
            }
            100% {
                transform: translate(-50%, -50%) rotateX(720deg) rotateY(720deg);
            }
        }

    </style>
</head>

<body>
    <!-- Video Background -->
    <video autoplay muted loop class="video-background">
        <source src="homepage.mp4" type="video/mp4">
    </video>

    <!-- Welcome Text -->
    <div class="welcome-text" id="welcomeText">Welcome to Bank Application</div>

    <!-- Center Logo -->
    <div class="center-logo"></div>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <a href="admin-login.jsp">
            <img src="bankLogo.jpeg" alt="Home" class="home-icon">
        </a>
            <span>Banking Application</span>
        </div>
        <div class="navbar-right">
            <a href="customer-login.jsp">Login</a>
            <a href="#about">About</a>
            <a href="contactUs.jsp">Contact</a>
            <a href="registerform.jsp">Apply for New Account</a>
        </div>
    </div>

    <!-- Starfield container -->
    <div class="star-field"></div>

    <!-- Slideshow Images -->
    <div class="image-container">
        <img src="bank1.jpeg" class="slide" style="opacity: 1;">
        <img src="bank2.jpeg" class="slide hidden">
        <img src="bank3.jpeg" class="slide hidden">
    </div>

    <script>
        let currentIndex = 0;
        const images = document.querySelectorAll('.image-container img');
        const totalImages = images.length;

        function showNextImage() {
            images[currentIndex].classList.add('hidden');
            currentIndex = (currentIndex + 1) % totalImages;
            images[currentIndex].classList.remove('hidden');
        }

        setInterval(showNextImage, 3000);

        const starField = document.querySelector('.star-field');
        const numStars = 100;

        for (let i = 0; i < numStars; i++) {
            let star = document.createElement('div');
            star.classList.add('star');
            star.style.left = `${Math.random() * 100}vw`;
            star.style.top = `${Math.random() * 100}vh`;
            star.style.animationDuration = `${Math.random() * 5 + 1}s`;
            starField.appendChild(star);
        }

        // Typing effect for welcome text
        const textElement = document.getElementById('welcomeText');
        const text = textElement.textContent;
        textElement.textContent = '';
        textElement.style.opacity = '1';
        let index = 0;

        function typeWriter() {
            if (index < text.length) {
                textElement.textContent += text.charAt(index);
                index++;
                setTimeout(typeWriter, 100); // Adjust the speed here
            }
        }

        setTimeout(typeWriter, 500); // Delay before starting the effect
    </script>
</body>

</html>
