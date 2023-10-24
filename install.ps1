# Bật windows Sandbox feature
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

$folderPath = Join-Path C: "WindowsSandbox"

# Kiểm tra xem thư mục đã tồn tại chưa
if (-not (Test-Path -Path $folderPath -PathType Container)) {
    # Nếu chưa tồn tại, thì tạo thư mục "test"
    New-Item -Path $folderPath -ItemType Directory
}

# Sao chép tất cả các thư mục và tệp tin từ thư mục hiện tại đến đường dẫn đích
Copy-Item -Path .\* -Destination $folderPath -Recurse

# Hỏi người dùng chọn 1 (Offline) hoặc 2 (Online)
$luaChon = Read-Host "Enter 1 to run in Offline mode or 2 to run in Online mode (+ Elastic)."

# Kiểm tra lựa chọn và thực hiện tệp .wsb tương ứng
if ($luaChon -eq 1) {
    $duongDan = "C:\WindowsSandbox\windows-sandbox-offline.wsb"
}
elseif ($luaChon -eq 2) {
    $duongDan = "C:\WindowsSandbox\windows-sandbox-elastic.wsb"
}
else {
    Write-Host "Lựa chọn không hợp lệ. Vui lòng nhập 1 hoặc 2."
    exit
}

# Mở tệp .wsb
Invoke-Item -Path $duongDan