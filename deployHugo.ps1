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

function gitCommit {
        #pull changes
        git pull origin master 

        # Add changes to git.
        git add .

        git commit -m "$msg"

        # Push source and build repos.
        git push origin master
}

"...Deploying updates to GitHub..."

# Build the project.
hugo -t story # if using a theme, replace with `hugo -t <YOURTHEME>`

#push updates to hugo repo kumaro/kumarwrites-blog
gitCommit

# Go To Public folder (hugo generated static site folder)
cd public

#push to git hub pages repo kumaro/kumarwrites.github.io
gitCommit

# pop back to Hugo folder
cd ..