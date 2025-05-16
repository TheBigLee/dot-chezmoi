k8s_cluster() {
  eval $(cattledog kubeconfig-env ${1})
}

spks_switch_to_namespace () {
  k8s_cluster spks-dbaas-prod
  _namespace=$(k get compositemariadbdatabaseinstances.syn.tools | grep $1 | awk '{print $3}')
  _k8s_cluster=$(k get compositemariadbinstances.syn.tools | grep $_namespace | awk '{print $3}')
  k8s_cluster "spks-${_k8s_cluster}"
  kubens $_namespace
}

spks_get_namespace () {
  k8s_cluster spks-dbaas-prod
  _namespace=$(k get compositemariadbdatabaseinstances.syn.tools | grep $1 | awk '{print $3}')
  echo "Namespace: ${_namespace}"
}

mariadb_state () {
  if [ -z "$1" ]
  then
    echo "mariadb-0:"
    kubectl exec mariadb-0 -it -c mariadb-galera -- bash -c "mysql -u root --password=\$MARIADB_ROOT_PASSWORD -e \"SHOW STATUS LIKE 'wsrep_%';\"" | grep --color=auto "cluster_size\|cluster_status\|connected\|evs_state\|local_state_comment"
    echo "====================="
    echo "mariadb-1:"
    kubectl exec mariadb-1 -it -c mariadb-galera -- bash -c "mysql -u root --password=\$MARIADB_ROOT_PASSWORD -e \"SHOW STATUS LIKE 'wsrep_%';\"" | grep --color=auto "cluster_size\|cluster_status\|connected\|evs_state\|local_state_comment"
    echo "====================="
    echo "mariadb-2:"
    kubectl exec mariadb-2 -it -c mariadb-galera -- bash -c "mysql -u root --password=\$MARIADB_ROOT_PASSWORD -e \"SHOW STATUS LIKE 'wsrep_%';\"" | grep --color=auto "cluster_size\|cluster_status\|connected\|evs_state\|local_state_comment"
    echo "====================="
  else
    kubectl exec mariadb-$1 -it -c mariadb-galera -- bash -c "mysql -u root --password=\$MARIADB_ROOT_PASSWORD -e \"SHOW STATUS LIKE 'wsrep_%';\"" | grep --color=auto "cluster_size\|cluster_status\|connected\|evs_state\|local_state_comment"
  fi
}

argo_syn () 
{ 
    kubectl "$@" -n syn get secret steward -o jsonpath='{.data.token}' | base64 -d | xclip -selection clipboard;
    servicename=argocd-server;
    if ! kubectl -n syn get svc "$servicename" &> /dev/null; then
        servicename=syn-argocd-server;
    fi;
    kubectl "$@" -n syn port-forward "svc/$servicename" 8080:80 &
}
