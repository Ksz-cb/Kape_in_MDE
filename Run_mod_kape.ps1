$param = $args[0]
$default=""

cd C:\Users\Public\kape
mkdir collection

if ($($param.count) -eq 1){
    $default=$param
    .\kape.exe --tsource C: --tdest C:\Users\Public\kape\collection --tflush --target $default
}
else
{
    for($i=0 ; $i -lt $($param.count); $i++)
    {
    $default=$default + $param[$i]+","
    }
    $default=$default.Substring(0,$default.Length-1)
    .\kape.exe --tsource C: --tdest C:\Users\Public\kape\collection --tflush --target $default
}

Compress-Archive -Force .\collection .\collection.zip 