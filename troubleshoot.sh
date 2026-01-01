#
namespace=infra

kubectl -n $namespace run alpine --image alpine:latest --restart=Never --command -- tail -f //dev/null
k -n $namespace exec -ti pods/alpine -- sh
openssl s_client -connect my-dashboard-kong-proxy.dashboard.svc.cluster.local:443 -showcerts </dev/null 2>/dev/null|openssl x509 -noout -text
