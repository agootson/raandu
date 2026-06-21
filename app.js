// ========================================
// RAANDU APP.JS
// Frontend MVP
// ========================================

console.log("Welcome to Raandu");

// -------------------------
// Registration Validation
// -------------------------

function validateRegistration(event) {

    const password =
        document.getElementById("password");

    const confirmPassword =
        document.getElementById("confirmPassword");

    if (!password || !confirmPassword)
        return true;

    if (password.value !== confirmPassword.value) {

        alert("Passwords do not match.");

        event.preventDefault();

        return false;
    }

    const user = {

        username:
            document.getElementById("username")?.value || "User",

        email:
            document.getElementById("email")?.value || ""
    };

    localStorage.setItem(
        "raanduUser",
        JSON.stringify(user)
    );

    alert("Registration successful.");

    return true;
}

// -------------------------
// Login
// -------------------------

function login(event) {

    event.preventDefault();

    localStorage.setItem(
        "raanduLoggedIn",
        "true"
    );

    alert("Welcome back!");

    window.location.href =
        "feed.html";
}

// -------------------------
// Logout
// -------------------------

function logout() {

    localStorage.removeItem(
        "raanduLoggedIn"
    );

    window.location.href =
        "index.html";
}

// -------------------------
// Create Post
// -------------------------

function createPost() {

    const postInput =
        document.getElementById("postInput");

    const feed =
        document.getElementById("feed");

    if (!postInput || !feed)
        return;

    const content =
        postInput.value.trim();

    if (content === "") {

        alert(
            "Write something first."
        );

        return;
    }

    const post = {

        text: content,

        timestamp:
            new Date().toLocaleString(),

        likes: 0
    };

    let posts =
        JSON.parse(
            localStorage.getItem(
                "raanduPosts"
            )
        ) || [];

    posts.unshift(post);

    localStorage.setItem(
        "raanduPosts",
        JSON.stringify(posts)
    );

    postInput.value = "";

    renderPosts();
}

// -------------------------
// Render Posts
// -------------------------

function renderPosts() {

    const feed =
        document.getElementById("feed");

    if (!feed)
        return;

    let posts =
        JSON.parse(
            localStorage.getItem(
                "raanduPosts"
            )
        ) || [];

    feed.innerHTML = "";

    posts.forEach((post, index) => {

        const postDiv =
            document.createElement("div");

        postDiv.className = "post";

        postDiv.innerHTML = `

            <div class="post-header">

                <strong>
                    Village Member
                </strong>

                <span>
                    ${post.timestamp}
                </span>

            </div>

            <p>
                ${post.text}
            </p>

            <div class="post-actions">

                <button
                    onclick="likePost(${index})">

                    ❤️ ${post.likes}

                </button>

            </div>
        `;

        feed.appendChild(postDiv);
    });
}

// -------------------------
// Like Post
// -------------------------

function likePost(index) {

    let posts =
        JSON.parse(
            localStorage.getItem(
                "raanduPosts"
            )
        ) || [];

    if (!posts[index])
        return;

    posts[index].likes++;

    localStorage.setItem(
        "raanduPosts",
        JSON.stringify(posts)
    );

    renderPosts();
}

// -------------------------
// Load Profile
// -------------------------

function loadProfile() {

    const user =
        JSON.parse(
            localStorage.getItem(
                "raanduUser"
            )
        );

    if (!user)
        return;

    const username =
        document.getElementById(
            "profileUsername"
        );

    if (username)
        username.textContent =
            user.username;
}

// -------------------------
// Startup
// -------------------------

document.addEventListener(
    "DOMContentLoaded",
    () => {

        renderPosts();

        loadProfile();

        const registerForm =
            document.getElementById(
                "registerForm"
            );

        if (registerForm) {

            registerForm.addEventListener(
                "submit",
                validateRegistration
            );
        }

        const loginForm =
            document.getElementById(
                "loginForm"
            );

        if (loginForm) {

            loginForm.addEventListener(
                "submit",
                login
            );
        }
    }
);
