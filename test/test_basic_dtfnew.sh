. $HOME/scripts/basic.sh

REPO=/home/shelly/repos/bare.git 
BRANCH=base

if [ ! -d "$REPO" ]; then
	git init -b $BRANCH --bare $REPO
fi

dtfnew $REPO

touch .bashrc
git add .bashrc
git commit -m "Added .bashrc"
git push -u origin HEAD
git -C $REPO ls-tree --name-only HEAD | grep .bashrc && SUCCESS=true || unset SUCCESS

if [ -z "$SUCCESS" ]; then
	printf "\e[1;31mFailed! .bashrc does not exist on remote\e[0m\n"
	exit 1
else
	printf "\e[1;32mSuccess! .bashrc exists on remote\e[0m\n"
fi

