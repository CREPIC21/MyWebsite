

let openModalBtn = document.querySelector(".open-modal");
let modal = document.querySelector(".modal");
let closeModalBtn = document.querySelector(".btn-close-modal");
let hamburgerMenuOpenBtn = document.querySelector(".hamb-menu");
let hamburgerNavbar = document.querySelector(".hamburger-style");
let hamburgerMenuCloseBtn = document.querySelector(".close-hamburger-navbar-btn");


openModalBtn.addEventListener("click", function() {
    modal.classList.add("modal-open");
});

closeModalBtn.addEventListener("click", function() {
    modal.classList.remove("modal-open");
});

hamburgerMenuOpenBtn.addEventListener("click", function() {
    console.log("Clicked");
    hamburgerNavbar.classList.add("hamburger-style-open");
    hamburgerMenuOpenBtn.classList.add("hamb-menu-hide");

})

hamburgerMenuCloseBtn.addEventListener("click", function() {
    hamburgerNavbar.classList.remove("hamburger-style-open");
    hamburgerMenuOpenBtn.classList.remove("hamb-menu-hide");
})