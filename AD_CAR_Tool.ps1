

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'

[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
<# 
.NAME
    AD_Groupe Check-Add-Remove
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(519,421)
$Form.text                       = "AD Group CAR Tool | Check - Add - Remove "
$Form.TopMost                    = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "AD Group CAR Tool"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(8,11)
$Label1.Font                     = New-Object System.Drawing.Font('Arial',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Check | Add | Remove - Users from AD Group"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(217,14)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$username                        = New-Object system.Windows.Forms.TextBox
$username.multiline              = $false
$username.width                  = 367
$username.height                 = 30
$username.location               = New-Object System.Drawing.Point(125,55)
$username.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',15)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Input Username:"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(11,63)
$Label3.Font                     = New-Object System.Drawing.Font('Arial',10)

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Choose AD Group"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(11,120)
$Label4.Font                     = New-Object System.Drawing.Font('Arial',10)

$groupename                      = New-Object system.Windows.Forms.ComboBox
$groupename.text                 = ""
$groupename.width                = 365
$groupename.height               = 20
@('Group name 1','Group name 2') | ForEach-Object {[void] $groupename.Items.Add($_)}
$groupename.location             = New-Object System.Drawing.Point(127,118)
$groupename.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$output                          = New-Object system.Windows.Forms.TextBox
$output.multiline                = $true
$output.width                    = 501
$output.height                   = 96
$output.location                 = New-Object System.Drawing.Point(8,280)
$output.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "Output"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(211,244)
$Label5.Font                     = New-Object System.Drawing.Font('Arial',15)

$check                           = New-Object system.Windows.Forms.Button
$check.text                      = "Check"
$check.width                     = 145
$check.height                    = 34
$check.location                  = New-Object System.Drawing.Point(8,172)
$check.Font                      = New-Object System.Drawing.Font('Arial',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$check.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$check.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Add"
$Button1.width                   = 145
$Button1.height                  = 34
$Button1.location                = New-Object System.Drawing.Point(181,172)
$Button1.Font                    = New-Object System.Drawing.Font('Arial',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Remove"
$Button2.width                   = 145
$Button2.height                  = 34
$Button2.location                = New-Object System.Drawing.Point(353,172)
$Button2.Font                    = New-Object System.Drawing.Font('Arial',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button2.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$Button2.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$Label6                          = New-Object system.Windows.Forms.Label
$Label6.text                     = "Tool Created By @_CooperDev"
$Label6.AutoSize                 = $true
$Label6.width                    = 25
$Label6.height                   = 10
$Label6.location                 = New-Object System.Drawing.Point(9,390)
$Label6.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "Admin Login"
$Button3.width                   = 130
$Button3.height                  = 30
$Button3.location                = New-Object System.Drawing.Point(368,383)
$Button3.Font                    = New-Object System.Drawing.Font('Arial',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button3.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Button3.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#bd10e0")

$Form.controls.AddRange(@($Label1,$Label2,$username,$Label3,$Label4,$groupename,$output,$Label5,$check,$Button1,$Button2,$Label6,$Button3))

$check.Add_Click({ check })
$Button1.Add_Click({ add })
$Button2.Add_Click({ remove })
$Button3.Add_Click({ adminlogin })

#region Logic 
function adminlogin { 
    
$global:cred = Get-Credential    
}




#endregion

#region Check
function check { 
$user = $username.Text
$groups = $groupename.text

try {
$output.AppendText("`r`nRunning Command")
foreach ($group in $groups) {
    $groupcheck = Get-ADGroupMember -Identity $groups -Recursive | Select -ExpandProperty SamAccountName 
     if ($groupcheck -contains $user) {
         $output.AppendText("`r`nUser $user Is In AD Group $groups")
         
     }
     else{
          $output.AppendText("`r`nUser $user Not In AD Group $groups")
     }
     
}
}
catch {
                $output.AppendText("`r`n$_.Exception.Message")
            }

}
#endregion

#region Add User 
function add {  
$user = $username.Text
$groups = $groupename.text

try {
    $output.AppendText("`r`nAdding User")
Add-ADGroupMember -Credential $global:cred -Identity $groups -Members $user -ErrorAction Stop
          $output.AppendText("`r`nUser $user Added To AD Group $groups")
}
catch {
                $output.AppendText("`r`n$_.Exception.Message")
            }

}


#endregion

#region Remove User
function remove {   
$user = $username.Text
$groups = $groupename.text

try {
    $output.AppendText("`r`nRemoveing User")
Remove-ADGroupMember -Credential $global:cred -Identity $groups -Members $user -Confirm:$False -ErrorAction Stop 
          $output.AppendText("`r`nUser $user Removed From AD Group $groups")
}
catch {
                $output.AppendText("`r`n$_.Exception.Message")
            }

}
#endregion

[void]$Form.ShowDialog()