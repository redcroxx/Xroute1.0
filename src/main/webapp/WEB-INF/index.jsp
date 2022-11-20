<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Xroute 서버 점검</title>
<!-- Bootstrap core CSS -->
<link href="/css/bootstrap/all.min.css" rel="stylesheet" type="text/css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<style type="text/css">
/*!
 * Start Bootstrap - Coming Soon v5.0.9 (https://startbootstrap.com/theme/coming-soon)
 * Copyright 2013-2020 Start Bootstrap
 * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-coming-soon/blob/master/LICENSE)
 */
html {
	height: 100%
}

body {
	height: 100%;
	min-height: 35rem;
	position: relative;
	font-family: 'Source Sans Pro';
	font-weight: 300;
	background: url(/images/server.png) #002e66 no-repeat center center
		scroll;
	background-size: cover;
	background: url(/images/server.png) #002e66 no-repeat center center
		scroll;
}

h1, h2, h3, h4, h5, h6 {
	font-family: Merriweather;
	font-weight: 700
}

video {
	position: fixed;
	top: 50%;
	left: 50%;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
	transform: translateX(-50%) translateY(-50%);
	z-index: 0
}

@media ( pointer :coarse) and (hover:none) {
	body {
		background: url(/images/server.png) #002e66 no-repeat center center
			scroll;
		background-size: cover
	}
	body video {
		display: none
	}
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	height: 100%;
	width: 100%;
	background-color: #cd9557;
	opacity: .7;
	z-index: 1
}

.masthead {
	position: relative;
	overflow: hidden;
	padding-bottom: 3rem;
	z-index: 2;
}

.masthead .masthead-bg {
	position: absolute;
	top: 0;
	bottom: 0;
	right: 0;
	left: 0;
	width: 100%;
	min-height: 35rem;
	height: 100%;
	background-color: rgba(0, 46, 102, .8);
	transform: skewY(4deg);
	transform-origin: bottom right
}

.masthead .masthead-content h1 {
	font-size: 2.5rem
}

.masthead .masthead-content p {
	font-size: 1.2rem
}

.masthead .masthead-content p strong {
	font-weight: 700
}

.masthead .masthead-content .input-group-newsletter input {
	height: auto;
	font-size: 1rem;
	padding: 1rem
}

.masthead .masthead-content .input-group-newsletter button {
	font-size: .8rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 1px;
	padding: 1rem
}

@media ( min-width :768px) {
	.masthead {
		height: 100%;
		min-height: 0;
		width: 40.5rem;
		padding-bottom: 0
	}
	.masthead .masthead-bg {
		min-height: 0;
		transform: skewX(-8deg);
		transform-origin: top right
	}
	.masthead .masthead-content {
		padding-left: 3rem;
		padding-right: 10rem
	}
	.masthead .masthead-content h1 {
		font-size: 3.5rem
	}
	.masthead .masthead-content p {
		font-size: 1.3rem
	}
}

.social-icons {
	position: absolute;
	margin-bottom: 2rem;
	width: 100%;
	z-index: 2
}

.social-icons ul {
	margin-top: 2rem;
	width: 100%;
	text-align: center
}

.social-icons ul>li {
	margin-left: 1rem;
	margin-right: 1rem;
	display: inline-block
}

.social-icons ul>li>a {
	display: block;
	color: #fff;
	background-color: rgba(0, 46, 102, .8);
	border-radius: 100%;
	font-size: 2rem;
	line-height: 4rem;
	height: 4rem;
	width: 4rem
}

@media ( min-width :768px) {
	.social-icons {
		margin: 0;
		position: absolute;
		right: 2.5rem;
		bottom: 2rem;
		width: auto
	}
	.social-icons ul {
		margin-top: 0;
		width: auto
	}
	.social-icons ul>li {
		display: block;
		margin-left: 0;
		margin-right: 0;
		margin-bottom: 2rem
	}
	.social-icons ul>li:last-child {
		margin-bottom: 0
	}
	.social-icons ul>li>a {
		transition: all .2s ease-in-out;
		font-size: 2rem;
		line-height: 4rem;
		height: 4rem;
		width: 4rem
	}
	.social-icons ul>li>a:hover {
		background-color: #002e66
	}
}

.btn-secondary {
	background-color: #cd9557;
	border-color: #cd9557
}

.btn-secondary:active, .btn-secondary:focus, .btn-secondary:hover {
	background-color: #ba7c37 !important;
	border-color: #ba7c37 !important
}

.input {
	font-weight: 300 !important
}
</style>
</head>
<body>
    <div class="masthead">
        <div class="masthead-bg"></div>
        <div class="container h-100">
            <div class="row h-100">
                <div class="col-12 my-auto">
                    <div class="masthead-content text-white py-5 py-md-0">
                        <h2 class="mb-3">Xroute 서버 점검</h2>
                        <p class="mb-5">
                            <strong>01월 18일(월) 09:00 ~ 12:00</strong>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>