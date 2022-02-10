function Save-BingTodayImage()
{
    #必应图片故事API
    $bingImageApi ='http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=zh-cn'
    $bingUri = 'http://www.bing.com/'
 
    # 获取图片链接
    [xml]$bingImageXml = (Invoke-WebRequest -Uri $bingImageApi).Content
    Write-Host " 今日图片故事： $( $bingImageXml.images.image.copyright ) "
    $imgLink = '{0}{1}' -f $bingUri , $bingImageXml.images.image.url
 
    # 下载和保存图片
    $imageDir = "$HOME\Pictures\Bing\"
    if( -not (Test-Path $imageDir) )
    {
        mkdir $imageDir | Out-Null
    }
    $imageFile = Join-Path $imageDir ( '{0}.jpg' -f $bingImageXml.images.image.fullstartdate)
 
    Invoke-WebRequest -Uri $imgLink -OutFile $imageFile
 
    return $imageFile
}
 
Function Set-DesktopWallPaper($imagePath)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $imagePath
 RUNDLL32.EXE USER32.DLL UpdatePerUserSystemParameters ,1 ,True
}
 
# 获取今日必应背景图片
$image=Save-BingTodayImage
echo $image
#设置为桌面墙纸
Set-DesktopWallPaper -imagePath $image