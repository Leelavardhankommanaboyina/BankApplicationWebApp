<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="description" content="Contact Your Bank's customer support for assistance with your account or any inquiries. Our support team is available Monday to Friday, 9:00 AM - 5:00 PM."/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Contact Us - Your Bank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-EnVjuZteEXYItMe9JbA9vptB6K4Ob+u/1IeJ71G8QgJzvQig1I5f3fjxk1Ck6UmLzfTFol1yK9WvFpK4aZEFbw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #0f0c29;
            background: linear-gradient(to right, #24243e, #302b63, #0f0c29);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
            overflow: hidden;
            color: #fff;
        }
        .container {
            max-width: 800px;
            width: 100%;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.8);
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
        }
        .intro {
            text-align: center;
            margin-bottom: 20px;
        }
        .intro h1 {
            margin-bottom: 10px;
        }
        .subtext {
            color: #ccc;
            margin-bottom: 20px;
        }
        .contact-card {
            margin-bottom: 20px;
            opacity: 0;
            animation: fadeIn 1s forwards;
        }
        .contact-card h2 {
            margin-top: 0;
        }
        .contact-details {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .contact-info {
            flex: 1 1 300px;
            margin-bottom: 20px;
        }
        .info {
            margin: 5px 0;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #03a9f4;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #0288d1;
        }
        .social-icons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
            opacity: 0;
            animation: fadeIn 1s forwards;
            animation-delay: 0.5s;
        }
        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            color: #fff;
            background-color: #007bb5;
            border-radius: 50%;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .social-icons a:hover {
            background-color: #005e8a;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .light {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 1000px;
            height: 1000px;
            background: #03a9f4;
            filter: blur(150px);
            transform: translate(-50%, -50%);
            animation: pulse 2s infinite;
            z-index: -1;
        }
        @keyframes pulse {
            0%, 100% {
                transform: translate(-50%, -50%) scale(1);
                opacity: 0.5;
            }
            50% {
                transform: translate(-50%, -50%) scale(1.2);
                opacity: 1;
            }
        }
        .back-button-container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="intro">
            <h1>Welcome to Our Banking Services</h1>
            <p>For any inquiries or assistance, please don't hesitate to contact our customer support team. We're here to help you with any questions you may have about our banking services.</p>
            <p><strong>Customer Service Hours:</strong></p>
            <ul>
                <li>Monday to Friday: 9:00 AM to 6:00 PM (EST)</li>
                <li>Saturday: 10:00 AM to 3:00 PM (EST)</li>
                <li>Sunday: Closed</li>
            </ul>
        </div>
        <div class="contact-card">
            <h2>Contact Customer Support</h2>
            <p class="subtext">Reach out to us for assistance with your account or any inquiries.</p>
            <div class="contact-details">
                <div class="contact-info">
                    <h3>Customer Service</h3>
                    <p class="info"><strong>Phone:</strong> <a href="tel:+123456789">+91 6302443581</a></p>
                    <p class="info"><strong>Email:</strong> <a href="mailto:phanindrakondepu@gmail.com">phanindrakondepu@gmail.com</a></p>
                </div>
                <div class="contact-info">
                    <h3>Headquarters</h3>
                    <p class="info"><strong>Address:</strong> Vadeswaram, Vijayawada, India</p>
                </div>
            </div>
            <p class="subtext">Our support team is available Monday to Friday, 9:00 AM - 5:00 PM.</p>
            <div class="contact-actions">
                <a href="https://web.whatsapp.com/" class="button">Live Chat</a>
            </div>
        </div>
        <div class="social-icons">
            <a href="https://www.instagram.com/phani_online_" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://web.telegram.org/" target="_blank"><i class="fab fa-telegram"></i></a>
            <a href="https://www.youtube.com/yourbank" target="_blank"><i class="fab fa-youtube"></i></a>
        </div>
       
    </div>
    <div class="light"></div>
</body>
</html>