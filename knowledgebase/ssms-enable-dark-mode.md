# Enable SSMS Dark Mode

## For SSMS 18

Run the following script in PowerShell as Administrator

**WARNING! Make sure to review this code and understand what it does before running it. It is possible that with each update of SSMS, the following code might need to be reviewed and adjusted, else it might break something.**

You will need to run this script each time you update SSMS as each update will reset the `ssms.pkgundef` file

```ps
powershell -Command "(gc 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef') -replace '\[\`$RootKey\`$\\Themes\\{1ded0138-47ce-435e-84ef-9ec1f439b749}\]', '//[`$RootKey`$\Themes\{1ded0138-47ce-435e-84ef-9ec1f439b749}]' | Out-File 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef'"
```

