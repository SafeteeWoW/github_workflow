# Build zlib,
# and build reference programs (zdeflate, puff) in LibDeflate which depend on zlib
# LibDeflate requires these reference program for testing

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

function RunCmd {
  $command = $args[0]
  if ($args.Length -gt 1) {
    $arguments = $args[1..($args.Length - 1)]
    & $command @arguments
  } else {
    & $command
  }
  if ($LastExitCode -ne 0) {
    Write-Error "Exit code $LastExitCode while running $command $arguments"
  }
}

function BuildZlib {
  Set-Location
  $file = "zlib1211.zip"
  RunCmd curl --retry 10 --retry-delay 10 --location http://www.zlib.net/${file} -o ${file}
  RunCmd unzip -o -d . ${file}
  Set-Location zlib-1.2.11
  RunCmd nmake /f win32\Makefile.msc
}

function main () {
  BuildZlib
}

main
