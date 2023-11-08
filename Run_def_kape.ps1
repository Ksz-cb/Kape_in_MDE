$param = $args[0]
$default = '$MFT,$J,$LogFile'

cd C:\Users\Public\kape\kape\KAPE
mkdir collection

if ($($param.count) -eq 1){
    $default=$default+","+$param
    .\kape.exe --tsource C: --tdest C:\Users\Public\kape\kape\KAPE\collection --tflush --target $default
}
else
{
    if ($($param.count) -gt 1){
        for($i=0 ; $i -le $($param.count); $i++)
        {
        $default=$default+","+$param[$i]
        }
        $default=$default.Substring(0,$default.Length-1)
        .\kape.exe --tsource C: --tdest C:\Users\Public\kape\kape\KAPE\collection --tflush --target $default
    }

    else
        {
        .\kape.exe --tsource C: --tdest C:\Users\Public\kape\kape\KAPE\collection --target $default
        }
}



Compress-Archive -Force .\collection .\collection.zip
