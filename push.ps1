# Push the notes repo to GitHub. Run this in YOUR OWN interactive PowerShell
# window: the git credential manager needs a desktop to hand over the token
# (it cannot do that from a non-interactive shell).
#
# One-time: create an EMPTY public repo named gta6-pc-notes at
#   https://github.com/new   (do NOT add a README, .gitignore or licence)
# Then run:  powershell -ExecutionPolicy Bypass -File E:\vt\notes-gta6-pc\push.ps1
param(
  [string]$User = 'XiaMo233M',
  [string]$Repo = 'gta6-pc-notes',
  [string]$Proxy = 'http://127.0.0.1:10812'
)
$ErrorActionPreference = 'Continue'
Set-Location 'E:\vt\notes-gta6-pc'

git remote remove origin 2>$null
git remote add origin "https://github.com/$User/$Repo.git"
git remote -v

'--- pushing through the proxy (the credential manager may ask once) ---'
git -c "http.proxy=$Proxy" push -u origin HEAD 2>&1 | Select-Object -Last 8
if ($LASTEXITCODE -eq 0) {
  "OK  https://github.com/$User/$Repo"
  git -c "http.proxy=$Proxy" ls-remote --heads origin 2>&1 | Select-Object -First 3
} else {
  'push failed: check that the empty repo exists and that you are signed in as ' + $User
}
