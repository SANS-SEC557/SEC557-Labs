for( $d = 1; $d -le 5; $d++){
    for( $l = 1; $l -le 4; $l++){
        $dirname = "Lab$d.$l"
        New-Item -Name ".\$dirname" -ItemType Directory
        Copy-Item -Path .\README.md -Destination $dirname
    }
}