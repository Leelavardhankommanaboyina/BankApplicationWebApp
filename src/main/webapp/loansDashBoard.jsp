<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loans Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #fff;
            text-align: center;
            margin-top: 50px;
            overflow-x: hidden;
        }
        .navbar {
            display: flex;
            align-items: center;
            background-color: #000000;
            padding: 10px;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
            justify-content: space-between;
            height: 50px;
            box-shadow: 0 5px 8px rgba(0, 0, 0, 0.2);
        }
        .navbar img.home-icon {
            height: 35px;
            width: 35px;
            border-radius: 50%;
            margin-left: 10px;
        }
        .profile-container {
            position: relative;
            display: inline-block;
            margin-right: 40px; /* Adjusted for better visibility */
        }
        .profile-container i {
            font-size: 18px;
            margin-right: 8px;
        }
        .profile-container span {
            font-size: 16px;
            color: white;
            cursor: pointer;
        }
        .profile-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #1c1c1c;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            border-radius: 5px;
            z-index: 1;
            width: 150px;
        }
        .profile-container:hover .profile-dropdown-content {
            display: block;
        }
        .profile-dropdown-content form {
            margin: 0;
            padding: 10px;
        }
        .logout-btn {
            display: block;
            width: 100%;
            padding: 10px;
            font-size: 14px;
            background-color: #ff0000;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #cc0000;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            margin-top: 100px;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .card {
            background-color: #6c757d;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: calc(20% - 20px);
            box-sizing: border-box;
            color: #fff;
            text-align: center;
            transition: transform 0.5s, box-shadow 0.5s;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .card h3 {
            margin-top: 20px;
            font-size: 22px;
        }
        .card p {
            font-size: 16px;
            margin-top: 10px;
        }
        /* Sparkling lights effect */
        .card::before {
            content: '';
            position: absolute;
            top: -100px;
            left: -100px;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(255,255,0,0.2) 20%, transparent 70%);
            opacity: 0.5;
            transition: background-color 0.3s ease;
        }
        .card:hover::before {
            background: radial-gradient(circle, rgba(255,255,0,0.6) 20%, transparent 70%);
            animation: sparkle 3s linear infinite;
        }
        @keyframes sparkle {
            0% {
                transform: translateX(0) translateY(0);
            }
            100% {
                transform: translateX(200%) translateY(200%);
            }
        }
        .slideshow-container {
            width: 30%;
            margin: 40px auto;
            overflow: hidden;
            position: relative;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .slideshow-container img {
            width: 100%;
            display: none;
            border-radius: 10px;
            cursor: pointer;
        }
        .slideshow-container img.active {
            display: block;
            animation: fade 1.5s;
        }
        @keyframes fade {
            from {opacity: 0.4;}
            to {opacity: 1;}
        }
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            border-radius: 0 3px 3px 0;
            user-select: none;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .next {
            right: 0;
            border-radius: 0 0 0 0;
        }
        .prev {
            left: 0;
            border-radius: 3px 3px 0 0;
        }
    </style>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="customer-dashboard.jsp">
            <img src="bankLogo.jpeg" alt="Home" class="home-icon">
        </a>
        <div class="profile-container">
            <span>
                <i class="fas fa-user-circle"></i>
                <%= session.getAttribute("username") %>
            </span>
            <div class="profile-dropdown-content">
                <form action="index.jsp" method="post">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </div>
        </div>
    </div>

    <div class="container">
        <h2>Welcome to Loans Section</h2>
        
        <div class="card-container">
            <div class="card" onclick="window.location.href='userLoans.jsp'">
                <h3>Your Loans</h3>
            </div>
            <div class="card" onclick="window.location.href='loanTypes.jsp'">
                <h3>Available Loans</h3>
            </div>
            <div class="card" onclick="window.location.href='loanPayment.jsp'">
                <h3>Pay Loan Amount</h3>
            </div>
            <div class="card" onclick="window.location.href='personalEMICalculator.jsp'">
                <h3>EMI Calculator</h3>
            </div>
        </div>
        
        <!-- Slideshow container -->
        <div class="slideshow-container">
            <img src="image2.jpeg" class="active" alt="Slideshow Image 1" onclick="window.location.href='personalLoan.jsp'">
            <img src="image3.jpeg" alt="Slideshow Image 2" onclick="window.location.href='Loan.jsp'">
            <img src="image4.jpeg" alt="Slideshow Image 3" onclick="window.location.href='homeLoan.jsp'">
            
            <!-- Next and previous buttons -->
            <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
            <a class="next" onclick="changeSlide(1)">&#10095;</a>
        </div>
    </div>

    <script>
        let slideIndex = 0;
        const slides = document.querySelectorAll('.slideshow-container img');

        function showSlides() {
            slides.forEach((slide, index) => {
                slide.classList.remove('active');
                if(index === slideIndex) {
                    slide.classList.add('active');
                }
            });

            slideIndex = (slideIndex + 1) % slides.length;
            setTimeout(showSlides, 4000); // Change image every 3 seconds
        }

        function changeSlide(n) {
            slideIndex = (slideIndex + n + slides.length) % slides.length;
            slides.forEach(slide => slide.classList.remove('active'));
            slides[slideIndex].classList.add('active');
        }

        showSlides();
    </script>
</body>
</html>
