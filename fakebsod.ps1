Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Screen {
    [DllImport("user32.dll")]
    public static extern int SetForegroundWindow(IntPtr hWnd);
}
"@ -Language CSharp

$bsodImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Windows_10_BSOD.svg/1024px-Windows_10_BSOD.svg.png"
$bsodImagePath = "$env:TEMP\fakebsod.jpg"

# Baixa a imagem da tela azul
Invoke-WebRequest -Uri $bsodImageUrl -OutFile $bsodImagePath

# Cria um formulário de tela cheia
Add-Type -AssemblyName System.Windows.Forms
$bsodForm = New-Object System.Windows.Forms.Form
$bsodForm.WindowState = "Maximized"
$bsodForm.FormBorderStyle = "None"
$bsodForm.TopMost = $true
$bsodForm.BackColor = "Black"

# Adiciona a imagem ao formulário
$bsodImage = New-Object System.Windows.Forms.PictureBox
$bsodImage.Dock = "Fill"
$bsodImage.Image = [System.Drawing.Image]::FromFile($bsodImagePath)
$bsodImage.SizeMode = "StretchImage"

$bsodForm.Controls.Add($bsodImage)

# Traz para frente e exibe
$bsodForm.Show()
[Screen]::SetForegroundWindow($bsodForm.Handle)
Start-Sleep 10  # Mantém a tela azul por 10 segundos
$bsodForm.Close()
