# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending


_k8s_cluster() { _files -W /home/bigli/.config/cattledog/kubeconfigs/ -/; }
compdef _k8s_cluster k8s_cluster
