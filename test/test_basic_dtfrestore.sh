. $HOME/scripts/basic.sh

if [ -f $HOME/.profile ]; then
	printf "\e[1;31mOops! .profile already exists\e[0m\n"
	exit 1
fi

dtfrestore $HOME/repos/base.git

if [ -f $HOME/.profile ]; then
	printf "\e[1;32mSuccess! .profile exists\e[0m\n"
else
	printf "\e[1;31mFailed! .profile does not exist\e[0m\n"
	exit 1
fi

touch .vimrc
git add .vimrc
git commit -m "Added .vimrc"
git push
git -C $HOME/repos/base.git/ ls-tree --name-only HEAD | grep .vimrc && SUCCESS=true || unset SUCCESS

if [ -z "$SUCCESS" ]; then
	printf "\e[1;31mFailed! .vimrc does not exist on remote\e[0m\n"
	exit 1
else
	printf "\e[1;32mSuccess! .vimrc exists on remote\e[0m\n"
fi

