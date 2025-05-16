podlog () {
  local pod=($(oc get pods --all-namespaces -o wide | fzf | awk '{print $1, $2}'))
  echo oc logs -n ${pod[1]} ${pod[2]}
  oc logs -n ${pod[1]} ${pod[2]}
}
