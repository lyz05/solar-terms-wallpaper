function Save-BingTodayImage()
{
    #��ӦͼƬ����API
    $bingImageApi ='http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=zh-cn'
    $bingUri = 'http://www.bing.com/'
 
    # ��ȡͼƬ����
    [xml]$bingImageXml = (Invoke-WebRequest -Uri $bingImageApi).Content
    Write-Host " ����ͼƬ���£� $( $bingImageXml.images.image.copyright ) "
    $imgLink = '{0}{1}' -f $bingUri , $bingImageXml.images.image.url
 
    # ���غͱ���ͼƬ
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
 
# ��ȡ���ձ�Ӧ����ͼƬ
$image=Save-BingTodayImage
echo $image
#����Ϊ����ǽֽ
Set-DesktopWallPaper -imagePath $image