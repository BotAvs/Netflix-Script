# Abrir el ficherin
$cuentas = Get-Content "cuentas.txt"

# Bucle para probar las cuentas
for ($i = 0; $i -lt $cuentas.Count; $i++) {

    #Bucle para sacar las lineas de cada cuenta
    foreach ($i in 0..($cuentas.Length - 1)) {
        $linea = $cuentas[$i]
        $email = $linea.Split(":")[0]
        $password = $linea.Split(":")[1]
    }
    
    ## Obtener datos
    ##$email = $cuentas[$i][0]
    ##$password = $cuentas[$i][1]

    # Abre la página web
    Start-Process -WindowStyle Hidden "chrome.exe" "https://www.netflix.com/es/login"
    # Esperar a que cargue

    Start-Sleep 3

    # Ingresa el correo electrónico
    $emailField = $page.FindElementByXPath('//*[@id="id_userLoginId"]')
    $emailField.SendKeys($email)

    # Ingresa la contraseña
    $passwordField = $page.FindElementByXPath('//*[@id="id_password"]')
    $passwordField.SendKeys($password)

    # Hace clic en el botón "Iniciar sesión"
    $loginButton = $page.FindElementByXPath("//*[@id='appMountPoint']/div/div[3]/div/div/div[1]/form/button")
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