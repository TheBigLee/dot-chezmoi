alias pacclean='sudo pacman -Rns $(sudo pacman -Qtdq)'
alias ip='ip --color'
alias please='sudo $(fc -ln -1)'
alias ka='kubectl --as cluster-admin'
alias ls='exa --group-directories-first -g --time-style long-iso'
if [[ -n $commands[kubecolor] ]]; then alias kubectl=kubecolor; fi
alias ghcr="echo $GITHUB_REG_TOKEN | docker login ghcr.io -u TheBigLee --password-stdin "
alias vim=nvim
