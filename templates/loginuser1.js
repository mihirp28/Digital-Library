document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form from submitting normally
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    
    console.log('Logging in with:', username, password);
    // Here you would normally handle the login logic, possibly making an AJAX request to your server
});
