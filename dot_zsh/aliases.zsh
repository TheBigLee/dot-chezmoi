alias reload!='. ~/.zshrc'

alias -g G='| grep'
alias -g L='| less'

alias -s pdf=okular

alias pacclean='sudo pacman -Rns $(sudo pacman -Qtdq)'

alias ip='ip --color'
alias ipb='ip --color --brief'

alias sshop-update="cd ~ && ssh management1.corp.vshn.net 'sshop generate --local-host-config .ssh/sshop-export.conf --output-archive sshop.tgz' && scp management1.corp.vshn.net:sshop.tgz . && tar xzf sshop.tgz && rm sshop.tgz && cd -"

alias please='sudo $(fc -ln -1)'

alias k='kubectl'
alias ka='kubectl --as cluster-admin'
alias ls='exa --group-directories-first -g --time-style long-iso'

alias steward_argo="kubectl -n syn get secret steward -o jsonpath='{.data.token}' | base64 -d  | xclip -selection clipboard && kubectl -n syn port-forward svc/argocd-server 8080:80"
alias steward_argo_ocp4="kubectl --as cluster-admin -n syn get secret steward -o jsonpath='{.data.token}' | base64 -d  | xclip -selection clipboard && kubectl --as cluster-admin -n syn port-forward svc/argocd-server 8080:80"

alias boatswain='docker run --rm --env-file ${ENVFILE} -v ${HOST_KUBECONFIG}:/app/kubeconfig docker.io/projectsyn/boatswain:latest'
alias xc='xclip -selection clipboard'

alias kubectl=kubecolor

alias ghcr="echo $GITHUB_REG_TOKEN | docker login ghcr.io -u TheBigLee --password-stdin "

alias vim='nvim'

alias vimdiff='nvim -d'
