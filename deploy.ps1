param (
    [Parameter(Mandatory=$true)][string]$msg
)

# abort if no changes to commit
If (-Not (git status --porcelain)) {
	"No changes to commit. Aborted!"
	# pop back to Hugo folder
	cd ..
	exit
}



# If a command fails then the deploy stops
$ErrorActionPreference = "Stop"

"...Deploying updates to GitHub..."

# Build the project.
hugo -t story # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
 #msg="rebuilding site $(Get-Date -format 'u')"
# if [ -n "$*" ]; then
# 	msg="$*"
# fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# pop back to Hugo folder
cd ..