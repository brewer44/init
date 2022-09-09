###############
### Aliases ###
###############
#Everyday Aliases
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias ls='ls -G'
alias l='ls -lh'
alias ll='ls -alh'
alias la='ls -A'
alias grep='grep  --color=auto'

###############
### Prompts ###
###############
# User specific environment and startup programs
Green='\[\e[0;32m\]'        # Green
Yellow='\[\e[1;93m\]'   #Light Yellow
Blue='\[\e[0;34m\]'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\[\e[0;36m\]'         # Cyan
White='\e[0;37m'        # White
BRed='\[\e[1;31m\]'         # Red
BGreen='\[\e[1;32m\]'       # Green
BYellow='\[\e[1;33m\]'      # Yellow
BBlue='\[\e[1;34m\]'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

URed='\e[4;31m'     # URed
UGreen='\e[4;32m'   # UGreen
UYellow='\e[4;33m'  # UYellow
UBlue='\e[4;34m'    # UBlue
UPurple='\e[4;35m'  # UPurple
UCyan='\e[4;36m'    # UCyan
UWhite='\e[4;37m'   # UWhite

Normal='\[\033[00m\]'
Orange='\[\033[38;5;2081;208m\]'

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
          gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
          return 0
  fi
  echo -e $gitver
}

user_color () {
        color=""
        if [[ ${EUID} == 0 ]] ; then
                color="${BRed}"
        else
                color="${Orange}"
        fi
        echo -ne $color
}

branch_color ()
{
        if git rev-parse --git-dir >/dev/null 2>&1
        then
                color=""
                if git diff --quiet 2>/dev/null >&2
                then
                        color="\[\033[38;5;029;m\]"
                else
                        color="\[\033[38;5;226m\]"
                fi
        else
                return 0
        fi
        echo -ne $color
}

PS1="${BRed}\u:\h ${Cyan}\W\$ ${Normal}"

ssh-add -A &> /dev/null
#export GOPATH=$(go env GOPATH)
#export PATH=$PATH:$(go env GOPATH)/bin

#scb() {
# ssh to another host via a jumphost; legacy use
#	ssh -i ~/.ssh/ssh_key bjohnson@$1@$jump_host
#}

#netops() {
# ssh tunnel via the jump host. Used for looking at prod stuff while its locked in a prod network; legacy
#	ssh -D7070 -o ServerAliveInterval=5 bjohnson@target_host@jump_host
#}

cleanup() {
  #make sure that your branches are all listed; might make a test to list branches before clean up
	git checkout master
	git branch --merged | grep -v '\*\|master\|develop' | xargs -n 1 git branch -D
	git remote prune origin
}

pod_clean() {
  #in the current context clean up all pods that are in a failed state
	echo "List of pods in a bad state"
	kubectl get pod -A --field-selector="status.phase==Failed"
	sleep 5
	echo "To clean this up run: "
	echo "kubectl delete pod -A --field-selector="status.phase==Failed""	
	#source: https://gist.github.com/ipedrazas/9c622404fb41f2343a0db85b3821275d
}

# function deleteEvictedPods() {
#     environments=(
#         development
#         staging
#         production
#         traefik
#         kube-system
#         kube-public
#         kube-node-lease
#         default
#     )

#     for environment in "${environments[@]}"
#     do
#         echo "==================================================================================="
#         echo "Removing evicted pods for namespace: \"${environment}\""
#         echo "---------------------------------------------------"

#         for each in $(kubectl get pods -n ${environment} | grep Evicted | awk '{print $1}');
#         do
#             kubectl delete pods $each -n ${environment}
#         done
#         echo "==================================================================================="
#         echo "\n"
#     done
# }

# vscode plugin
export PATH="/usr/local/bin/:${PATH}"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
HISTFILESIZE=10000000

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

set -o vim
export EDITOR=vim
