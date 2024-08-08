# 创建所需的目录
$buildTmpDir = "build\tmp"
$buildDestDir = "build\windows\x64\runner\Release\BASS"

New-Item -Path $buildTmpDir -ItemType Directory -Force
New-Item -Path $buildDestDir -ItemType Directory -Force

# 定义要下载的文件及其URL
$files = @(
    "https://www.un4seen.com/files/bass24.zip",
    "https://www.un4seen.com/files/bassape24.zip",
    "https://www.un4seen.com/files/bassdsd24.zip",
    "https://www.un4seen.com/files/bassflac24.zip",
    "https://www.un4seen.com/files/bassmidi24.zip",
    "https://www.un4seen.com/files/bassopus24.zip",
    "https://www.un4seen.com/files/basswv24.zip"
)

# 下载文件并解压
foreach ($fileUrl in $files) {
    $fileName = Split-Path $fileUrl -Leaf
    $filePath = Join-Path -Path $buildTmpDir -ChildPath $fileName

    # 下载文件
    Invoke-WebRequest -Uri $fileUrl -OutFile $filePath

    # 解压文件
    Expand-Archive -Path $filePath -DestinationPath $buildTmpDir -Force
}

# 移动 DLL 文件到目标目录
$sourcePath = Join-Path -Path $buildTmpDir -ChildPath "x64\*"
Move-Item -Path $sourcePath -Destination $buildDestDir -Force
