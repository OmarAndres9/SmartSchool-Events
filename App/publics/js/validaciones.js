const nombre = document.getElementById("nombre");
const password = document.getElementById("password");
const loginForm = document.getElementById("LoginForm");
const UsuarioError = document.getElementById("UsuarioError");
const ContraseñaError = document.getElementById("ContraseñaError");

loginForm.addEventListener('submit', function(event) {
    event.preventDefault(); // Evita que se envíe el formulario si hay errores

    // Limpia mensajes anteriores
    UsuarioError.textContent = '';
    ContraseñaError.textContent = '';

    let isValid = true;

    // Validar nombre de usuario
    if (nombre.value.trim() === '') {
        UsuarioError.textContent = 'El nombre de usuario es obligatorio.';
        isValid = false;
    }

    // Validar contraseña
    if (password.value.trim() === '') {
        ContraseñaError.textContent = 'La contraseña es obligatoria.';
        isValid = false;
    }

    // Si todo está bien, se puede enviar
    if (isValid) {
        // Aquí puedes enviar el formulario o redirigir manualmente
        alert("Inicio de sesión exitoso ✅");
        // loginForm.submit(); // Si deseas permitir el envío
        window.location.href = "../Agenda escolar/Index.html";
    }
});
