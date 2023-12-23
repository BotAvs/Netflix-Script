# Abrir el ficherin
$file = Get-Content "cuentas.txt"

# Bucle para probar las cuentas
for ($i = 0; $i -lt $cuentas.Count; $i++) {

    # Obtener datos
    $email = $cuentas[$i][0]
    $password = $cuentas[$i][1]

    # Abre la página web
    Start-Process "https://www.netflix.com/es/Login"

    # Esperar a que cargue
    $pageLoaded = (Get-Process "explorer" | Where-Object { $_.MainWindowTitle -eq "Netflix" }).MainWindowTitle
    while ($pageLoaded -ne "Netflix") {
        Start-Sleep 1
        $pageLoaded = (Get-Process "explorer" | Where-Object { $_.MainWindowTitle -eq "Netflix" }).MainWindowTitle
    }

    # Ingresa el correo electrónico
    $emailField = $page.FindElementById("email")
    $emailField.SendKeys($email)

    # Ingresa la contraseña
    $passwordField = $page.FindElementById("password")
    $passwordField.SendKeys($password)

    # Hace clic en el botón "Iniciar sesión"
    $loginButton = $page.FindElementById("login-button")
    $loginButton.Click()

    # Verifica si el inicio de sesión fue exitoso
    $isLoggedIn = (Get-Process "explorer" | Where-Object { $_.MainWindowTitle -eq "Netflix - Mi cuenta" }).MainWindowTitle
    if ($isLoggedIn) {
        # Inicio de sesión exitoso
        break
    }
}

# Si ninguna de las cuentas funcionó, muestra un error
if ($i -eq $cuentas.Count) {
    Write-Host "No se pudo iniciar sesión en ninguna de las cuentas"
}
