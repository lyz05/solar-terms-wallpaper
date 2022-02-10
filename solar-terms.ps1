function Save-BingTodayImage()
{
    # ��ȡͼƬ����
    $imgLink = "https://gcore.jsdelivr.net/gh/lyz05/solar-terms-wallpaper@main/image/%E5%A4%8F%E8%87%B3.jpg"
 
    # ���غͱ���ͼƬ
    $imageDir = "$HOME\Pictures\solar-terms"
    if( -not (Test-Path $imageDir) )
    {
        mkdir $imageDir | Out-Null
    }
    $imageFile = Join-Path $imageDir ( '{0}.jpg' -f 'wallpaper')
 
    Invoke-WebRequest -Uri $imgLink -OutFile $imageFile
 
    return $imageFile
}
 
Function Set-DesktopWallPaper($imagePath)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $imagePath
 RUNDLL32.EXE USER32.DLL UpdatePerUserSystemParameters ,1 ,True
}
 
# ��ȡ���ձ�Ӧ����ͼƬ
$image=Save-BingTodayImage
echo $image
#����Ϊ����ǽֽ
Set-DesktopWallPaper -imagePath $image