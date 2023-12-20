echo "Connecting to myLaptop"
$Server=<"ip of the server">
$Port="3389"
$User=<"username">
$Password=<"password">
cmdkey /add:$Server /user:$User /pass:$Password
mstsc /v:${Server:$Port}
