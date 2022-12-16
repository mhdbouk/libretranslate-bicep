param($registryName, $registryUrl)

$exists = az acr repository list --name $registryName --query "[?@ == 'libretranslate']" | convertfrom-json
if ($exists.length -eq 0) {
    az acr login --name $registryName
    docker pull libretranslate/libretranslate:latest
    docker tag libretranslate/libretranslate:latest $registryUrl/libretranslate:latest
    docker push $registryUrl/libretranslate:latest
}
else {
    Write-Host "libretranslate already exists in $($registryName) ACR."
}