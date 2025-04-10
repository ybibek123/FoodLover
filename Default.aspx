<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QuickBites._Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Custom CSS for all sections */
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('/Images/food-hero.jpg') center/cover no-repeat;
            height: 80vh;
            display: flex;
            align-items: center;
            color: white;
        }
        
        .btn-primary-custom {
            background-color: #6f42c1;
            border: none;
            padding: 12px 30px;
            font-size: 1.1rem;
        }
        
        .btn-primary-custom:hover {
            background-color: #E05E00;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .section-title {
            color: #6f42c1;
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: #6f42c1;
        }
        
        .item-card {
            transition: all 0.3s;
            border-radius: 10px;
            overflow: hidden;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .item-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        
        .discount-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #6f42c1;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
        }
        
        .rating {
            color: #FFC107;
        }
        
        .how-it-works-item {
            text-align: center;
            padding: 30px 15px;
            transition: all 0.3s;
        }
        
        .how-it-works-item:hover {
            background: #FFF5F0;
            border-radius: 10px;
        }
        
        .step-number {
            width: 60px;
            height: 60px;
            background: #6f42c1;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.5rem;
            font-weight: bold;
        }
    </style>

<!-- ======= Hero Section ======= -->
<section class="hero-section text-white py-5" style="background: url('https://i.ytimg.com/vi/7tdUCk9pLPw/hq720.jpg') center center / cover no-repeat; position: relative;">
    <!-- Overlay for better readability -->
    <div style="background: rgba(111, 66, 193, 0.6); position: absolute; top: 0; left: 0; right: 0; bottom: 0;"></div>

    <div class="container position-relative" style="z-index: 2;">
        <div class="row justify-content-center text-center">
            <div class="col-lg-9">
                <h1 class="display-4 fw-bold mb-4">Crave It. Click It. Eat It.</h1>
                <p class="lead mb-4">Delicious meals from your favorite restaurants—delivered to your doorstep fast.</p>
                <div class="d-flex gap-3 justify-content-center flex-wrap">
                    <a href="/Menu.aspx" class="btn btn-lg btn-light text-purple px-4 shadow-sm">
                        Order Now <i class="fas fa-utensils ms-2"></i>
                    </a>
                    <a href="#how-it-works" class="btn btn-outline-light btn-lg px-4">
                        How It Works
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- ======= About Section ======= -->
<section class="about-section py-5 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <!-- Enlarged Logo Image -->
            <div class="col-lg-6 mb-4 mb-lg-0 text-center">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpSLkDecVwpF0_ok6SGsQ7y4_Z7lj86ht22w&s"
                     class="img-fluid rounded-4 shadow-sm"
                     alt="About FoodLover"
                     style="max-width: 80%; height: auto;">
            </div>

            <!-- Text Content -->
            <div class="col-lg-6">
                <h2 class="mb-3 fw-bold text-purple">Why Choose <span style="color:#6f42c1;">FoodLover</span>?</h2>
                <p class="text-muted fs-5 mb-4">
                    Your go-to platform for fast, reliable, and tasty food delivery experiences.
                </p>
                <ul class="list-unstyled fs-5">
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-purple me-2"></i> Partnered with 100+ top-rated restaurants
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-purple me-2"></i> Lightning-fast delivery under 30 minutes
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-purple me-2"></i> 24/7 support for all your foodie needs
                    </li>
                </ul>
                <a href="/About.aspx" class="btn btn-primary-custom mt-4 px-4">Discover More</a>
            </div>
        </div>
    </div>
</section>



<!-- ======= Today's Specials ======= -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="section-title text-center text-purple">Today's Specials</h2>
        <p class="text-center lead mb-5">Handpicked favorites from Nepal’s top kitchens</p>
        
        <div class="row g-4">
            <!-- Chicken Momo -->
            <div class="col-lg-3 col-md-6">
                <div class="card item-card h-100 position-relative">
                    <span class="discount-badge">10% OFF</span>
                    <img src="https://www.foodpleasureandhealth.com/wp-content/uploads/2017/11/IMG_1847-1024x683.jpg" class="card-img-top" alt="Chicken Momo">
                    <div class="card-body">
                        <h5 class="card-title">Chicken Momo</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="rating">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star-half-alt text-warning"></i>
                                <i class="far fa-star text-warning"></i>
                                <small class="text-muted ms-2">(203)</small>
                            </div>
                            <span class="badge bg-success">Nepali</span>
                        </div>
                        <div class="price-options mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="momo_size" id="momo_8pcs" checked>
                                <label class="form-check-label" for="momo_8pcs">
                                    8 pcs: <span class="text-decoration-line-through text-muted">Rs. 180</span> <strong class="text-danger">Rs. 162</strong>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="momo_size" id="momo_12pcs">
                                <label class="form-check-label" for="momo_12pcs">
                                    12 pcs: <span class="text-decoration-line-through text-muted">Rs. 250</span> <strong class="text-danger">Rs. 225</strong>
                                </label>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>

            <!-- Newari Khaja Set -->
            <div class="col-lg-3 col-md-6">
                <div class="card item-card h-100 position-relative">
                    <span class="discount-badge">12% OFF</span>
                    <img src="data:image/jpeg;base64,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" class="card-img-top" alt="Newari Khaja Set">
                    <div class="card-body">
                        <h5 class="card-title">Newari Khaja Set</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="rating">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star-half-alt text-warning"></i>
                                <small class="text-muted ms-2">(121)</small>
                            </div>
                            <span class="badge bg-success">Nepali</span>
                        </div>
                        <div class="price-options mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="khaja_size" id="khaja_regular" checked>
                                <label class="form-check-label" for="khaja_regular">
                                    Regular Set: <span class="text-decoration-line-through text-muted">Rs. 350</span> <strong class="text-danger">Rs. 308</strong>
                                </label>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>

            <!-- Sel Roti with Aalu Tama -->
            <div class="col-lg-3 col-md-6">
                <div class="card item-card h-100 position-relative">
                    <span class="discount-badge">8% OFF</span>
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBDypj6umBrosDac9SDOAH0Ox5M8TF_Nv8UQ&s" class="card-img-top" alt="Sel Roti with Aalu Tama">
                    <div class="card-body">
                        <h5 class="card-title">Sel Roti & Aalu Tama</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="rating">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="far fa-star text-warning"></i>
                                <i class="far fa-star text-warning"></i>
                                <small class="text-muted ms-2">(54)</small>
                            </div>
                            <span class="badge bg-success">Traditional</span>
                        </div>
                        <div class="price-options mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="selroti_size" id="selroti_regular" checked>
                                <label class="form-check-label" for="selroti_regular">
                                    Set: <span class="text-decoration-line-through text-muted">Rs. 160</span> <strong class="text-danger">Rs. 147</strong>
                                </label>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>

<!-- Chicken Sekuwa (Out of Stock) -->
<div class="col-lg-3 col-md-6">
    <div class="card item-card h-100 position-relative" style="opacity: 0.6; pointer-events: none;">
        <span class="discount-badge bg-secondary">Out of Stock</span>
        <img src="https://media-cdn.tripadvisor.com/media/photo-m/1280/1c/dd/37/1a/chiura-tomato-pickle.jpg" class="card-img-top" alt="Chicken Sekuwa">
        <div class="card-body">
            <h5 class="card-title text-muted">Chicken Sekuwa</h5>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="rating text-muted">
                    <i class="fas fa-star text-warning"></i>
                    <i class="fas fa-star text-warning"></i>
                    <i class="fas fa-star text-warning"></i>
                    <i class="fas fa-star-half-alt text-warning"></i>
                    <i class="far fa-star text-warning"></i>
                    <small class="text-muted ms-2">(78)</small>
                </div>
                <span class="badge bg-secondary">Unavailable</span>
            </div>
            <div class="price-options mb-3 text-muted">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="sekuwa_size" id="sekuwa_half" disabled>
                    <label class="form-check-label" for="sekuwa_half">
                        Half: <span class="text-decoration-line-through">Rs. 280</span> <strong>Rs. 238</strong>
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="sekuwa_size" id="sekuwa_full" disabled>
                    <label class="form-check-label" for="sekuwa_full">
                        Full: <span class="text-decoration-line-through">Rs. 480</span> <strong>Rs. 408</strong>
                    </label>
                </div>
            </div>
            <div class="alert alert-danger text-center fw-bold py-1 mt-3 mb-0" style="font-size: 14px;">
                Out of Stock
            </div>
        </div>
    </div>
</div>


        <div class="text-center mt-5">
            <a href="/Menu.aspx" class="btn btn-outline-primary btn-lg">
                View Full Menu <i class="fas fa-chevron-right ms-2"></i>
            </a>
        </div>
    </div>
</section>


 <!-- ======= How FoodLover Works ======= -->
<section id="how-it-works" class="py-5 my-5 bg-white">
    <div class="container">
        <h2 class="section-title text-center" style="color: #6f42c1;">How FoodLover Works</h2>
        <p class="text-center lead mb-5">Savor your favorite dishes in 3 easy steps</p>
        
        <div class="row g-4 text-center">
            <!-- Step 1 -->
            <div class="col-md-4">
                <div class="how-it-works-item p-4 shadow-sm rounded bg-light h-100">
                    <div class="step-number display-4 fw-bold text-purple mb-3">1</div>
                    <h4 class="mb-3">Browse the Menu</h4>
                    <p>Explore our hand-curated dishes from the finest local kitchens — momo, sekuwa, dal bhat & more.</p>
                    <div class="mt-3">
                        <i class="fas fa-utensils fa-3x" style="color: #6f42c1;"></i>
                    </div>
                </div>
            </div>

            <!-- Step 2 -->
            <div class="col-md-4">
                <div class="how-it-works-item p-4 shadow-sm rounded bg-light h-100">
                    <div class="step-number display-4 fw-bold text-purple mb-3">2</div>
                    <h4 class="mb-3">Place Your Order</h4>
                    <p>Securely pay online or choose cash on delivery — we support multiple easy payment options.</p>
                    <div class="mt-3">
                        <i class="fas fa-credit-card fa-3x" style="color: #6f42c1;"></i>
                    </div>
                </div>
            </div>

            <!-- Step 3 -->
            <div class="col-md-4">
                <div class="how-it-works-item p-4 shadow-sm rounded bg-light h-100">
                    <div class="step-number display-4 fw-bold text-purple mb-3">3</div>
                    <h4 class="mb-3">Enjoy Swift Delivery</h4>
                    <p>Your food is freshly prepared and delivered hot to your doorstep in 30 minutes or less!</p>
                    <div class="mt-3">
                        <i class="fas fa-motorcycle fa-3x" style="color: #6f42c1;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ======= Feedback Section ======= -->
<section class="bg-light py-5">
    <div class="container">
        <h2 class="text-center mb-5">What Our Customers Say</h2>

        <!-- Review 1 -->
        <div class="bg-white p-4 mb-3 rounded shadow-sm">
            <p class="mb-1">"The delivery was super quick and the Chicken Momo was absolutely delicious!"</p>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0 text-muted">- Aayush Sharma</p>
                <div class="text-warning">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>
        </div>

        <!-- Review 2 -->
        <div class="bg-white p-4 mb-3 rounded shadow-sm">
            <p class="mb-1">"FoodLover makes dinner so easy, especially during work days. Love the Nepali thali!"</p>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0 text-muted">- Prerana Yadav</p>
                <div class="text-warning">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                </div>
            </div>
        </div>

        <!-- Review 3 -->
        <div class="bg-white p-4 mb-3 rounded shadow-sm">
            <p class="mb-1">"Satisfying experience every time. Highly recommend the Chicken Sekuwa!"</p>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0 text-muted">- Bishal Adhikari</p>
                <div class="text-warning">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    <i class="far fa-star"></i>
                </div>
            </div>
        </div>

        <!-- Review 4 -->
        <div class="bg-white p-4 mb-3 rounded shadow-sm">
            <p class="mb-1">"Best platform for authentic Nepali and Tilasmi Hotel meals. UI is also really cool!"</p>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0 text-muted">- Bimal Yadav</p>
                <div class="text-warning">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
        </div>

        <!-- Review 5 -->
        <div class="bg-white p-4 mb-3 rounded shadow-sm">
            <p class="mb-1">"Loved the speed and taste. The momo was juicy and packed with flavor!"</p>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0 text-muted">- Priya Rai</p>
                <div class="text-warning">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    <i class="far fa-star"></i>
                </div>
            </div>
        </div>
    </div>
</section>


</asp:Content>