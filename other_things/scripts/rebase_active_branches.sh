# Rebase actives branches
# Script by LeMagnesium (20/12/15)
# @param : Branches to rebase from master
# Must be ran from the root of the repo or a subdirectory

for branch in $( git branch ); do
	if [ branch != "master" ];
	then
		git checkout $branch
		git rebase master
		git push -f origin $branch
	fi
done

git checkout master
