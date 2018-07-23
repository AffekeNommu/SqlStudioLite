# SQL Studio Lite
#
# 2018 Made out of necessity. Corporate packaged app was not installing for me some days.
#
#Add form
Add-Type -AssemblyName System.Windows.Forms
#define the form
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "SQL Studio Lite"
#$Form.TopMost = $true
$Form.Width = 440
$Form.Height = 550
$Form.Add_Shown({   
#code here after form drawn if needed
})
#Connect to database and get data
function GetDataFromDB($query,$server,$db ,$user,$pass){
$conn=New-Object System.Data.SqlClient.SqlConnection
$connectionstring="Data Source=$server;database=$db;User id=$user;Password=$pass;"
$conn.ConnectionString=$connectionstring
$conn.Open()
$cmd=new-object System.Data.SqlClient.SqlCommand("$query",$conn)
$cmd.CommandTimeout=30
$ds=new-object System.Data.DataSet
$da=new-object System.Data.SqlClient.SqlDataAdapter($cmd)
[void]$da.Fill($ds)
$conn.Close()
#walk through the rows
for($i=0;$i -lt $ds.tables[0].rows.Count;$i++){
#walk through the columns
for($d=0;$d -lt $ds.tables[0].Columns.count;$d++){
#display the fields
$textBox2.Text+="$($ds.Tables[0].rows[$i][$d])"
#don't want a comma at end of row
if($d -lt ($ds.tables[0].Columns.count -1)){
$textBox2.Text+=","
}
}
#newline at end of row
$textBox2.Text+="`n`r`n`r"
}
}
#textbox for query
$textBox1 = New-Object system.windows.Forms.TextBox
$textBox1.Width = 400
$textBox1.Height = 200
$textBox1.Text="Query"
$textBox1.MultiLine=$true
$textBox1.enabled = $true
$textBox1.WordWrap = $false
$textbox1.ScrollBars="Both"
$textBox1.Anchor ='top, left,right'
$textBox1.location = new-object system.drawing.point(10,10)
$textBox1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox1)
#textbox for result
$textBox2 = New-Object system.windows.Forms.TextBox
$textBox2.Width = 400
$textBox2.Height = 200
$textBox2.Text="Result"
$textBox2.MultiLine=$true
$textBox2.enabled = $true
$textBox2.WordWrap = $false
$textbox2.ScrollBars="Both"
$textBox2.Anchor ='top,bottom,left,right'
$textBox2.location = new-object system.drawing.point(10,270)
$textBox2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox2)
#textbox for server - filled with default server
$textBox3 = New-Object system.windows.Forms.TextBox
$textBox3.Text="server\instance"
$textBox3.Width = 120
$textBox3.Height = 20
$textBox3.enabled = $true
$textBox3.location = new-object system.drawing.point(100,220)
$textBox3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox3)
#textbox for username
$textBox4 = New-Object system.windows.Forms.TextBox
$textBox4.Text="SQLUserName"
$textBox4.Width = 120
$textBox4.Height = 20
$textBox4.enabled = $true
$textBox4.location = new-object system.drawing.point(100,242)
$textBox4.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox4)
#textbox for password
$textBox5 = New-Object system.windows.Forms.MaskedTextBox
$textBox5.Width = 120
$textBox5.Height = 20
$textBox5.PasswordChar="*"
$textBox5.enabled = $true
$textBox5.location = new-object system.drawing.point(230,242)
$textBox5.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox5)
#textbox for database
$textBox6 = New-Object system.windows.Forms.TextBox
$textBox6.Text="database"
$textBox6.Width = 120
$textBox6.Height = 20
$textBox6.enabled = $true
$textBox6.location = new-object system.drawing.point(230,220)
$textBox6.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox6)
#the button that does the task
$button = New-Object system.windows.Forms.Button
$button.Text = "Execute"
$button.Width = 60
$button.Height = 40
$button.Add_Click({
#do the Open and display the results
#Get the ticket and instance number from the form
$query=$textBox1.Text
$textBox2.Text=""
GetDataFromDB $query $textBox3.Text $textBox6.Text $textBox4.Text $textBox5.Text
})
$button.Location = new-object system.drawing.point(10,220)
$Form.controls.Add($button)
#Start the form
[void]$Form.ShowDialog()
#clean up when X is hit
$Form.Dispose()
#We are done
