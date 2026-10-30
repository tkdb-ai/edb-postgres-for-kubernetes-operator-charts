Available options
The operator looks for the following environment variables to be defined in the ConfigMap/Secret:

Name    Description
* CERTIFICATE_DURATION    Determines the lifetime of the generated certificates in days. Default is 90.
* CLUSTERS_ROLLOUT_DELAY  The duration (in seconds) to wait between the roll-outs of different clusters during an operator upgrade. This setting controls the timing of upgrades across clusters, spreading them out to reduce system impact. The default value is 0 which means no delay between PostgreSQL cluster upgrades.
* CREATE_ANY_SERVICE  When set to true, will create -any service for the cluster. Default is false
* _NAMESPACE> (e.g. postgresql-operator-mutating-webhook-configuration-postgresql-operator-team-a and postgresql-operator-validating-webhook-configuration-postgresql-operator-team-a). Use this when running multiple namespaced operator instances on the same cluster to avoid name collisions. The operator does not create the suffixed configurations; you must create them before starting the operator with this flag enabled. If OPERATOR_NAMESPACE is not set when this flag is enabled, the operator will refuse to start. Default is false.
* EXPIRING_CHECK_THRESHOLD    Determines the threshold, in days, for identifying a certificate as expiring. Default is 7.
* EXTERNAL_BACKUP_ADDON_CONFIGURATION Configuration for the external-backup-adapter add-on. (See "Customizing the adapter" in Add-ons)
* INCLUDE_PLUGINS A comma-separated list of plugins to be always included in the Cluster's reconciliation.
* INHERITED_ANNOTATIONS   List of annotation names that, when defined in a Cluster metadata, will be inherited by all the generated resources, including pods
* INHERITED_LABELS    List of label names that, when defined in a Cluster metadata, will be inherited by all the generated resources, including pods
* INSTANCES_ROLLOUT_DELAY The duration (in seconds) to wait between roll-outs of individual PostgreSQL instances within the same cluster during an operator upgrade. The default value is 0, meaning no delay between upgrades of instances in the same PostgreSQL cluster.
* KUBERNETES_CLUSTER_DOMAIN   Defines the domain suffix for service FQDNs within the Kubernetes cluster. If left unset, it defaults to "cluster.local".
* MANAGE_WEBHOOK_CONFIGURATIONS   When set to true (default), the operator injects its CA bundle into the MutatingWebhookConfiguration and ValidatingWebhookConfiguration. Set to false when the CA bundle is injected externally, for example by cert-manager's CA injector or by GitOps. This is independent of the webhook serving certificate, which the operator always manages when it owns its PKI.
* METRICS_CERT_DIR    The directory where TLS certificates for the operator metrics server are stored. When set, enables TLS for the metrics endpoint on port 8080. The directory must contain tls.crt and tls.key files following standard Kubernetes TLS secret conventions. If not set, the metrics server operates without TLS (default behavior).
* MONITORING_QUERIES_CONFIGMAP    The name of a ConfigMap in the operator's namespace with a set of default queries (to be specified under the key queries) to be applied to all created Clusters
* MONITORING_QUERIES_SECRET   The name of a Secret in the operator's namespace with a set of default queries (to be specified under the key queries) to be applied to all created Clusters
* OPERATOR_IMAGE_NAME The name of the operator image used to bootstrap Pods. Defaults to the image specified during installation.
* PGBOUNCER_IMAGE_NAME    The name of the PgBouncer image used by default for new poolers. Defaults to the version specified in the operator.
* POSTGRES_IMAGE_NAME The name of the PostgreSQL image used by default for new clusters. Defaults to the version specified in the operator.
* PULL_SECRET_NAME    Name of an additional pull secret to be defined in the operator's namespace and to be used to download images
* STANDBY_TCP_USER_TIMEOUT    Defines the TCP_USER_TIMEOUT socket option in milliseconds for replication connections from standby instances to the primary. Default is 5000 (5 seconds). Set to 0 to use the system's default.
* WATCH_NAMESPACE Specifies the namespace(s) where the operator should watch for resources. Multiple namespaces can be specified separated by commas. If not set, the operator watches all namespaces (cluster-wide mode)
* EDB_LICENSE_KEY Default license key (to be used only if the cluster does not define one, and preferably in the Secret)
* ENABLE_INSTANCE_MANAGER_INPLACE_UPDATES When set to true, enables in-place updates of the instance manager after an update of the operator, avoiding rolling updates of the cluster (default false)
* ENABLE_REDWOOD_BY_DEFAULT   Enable the Redwood compatibility by default when using EPAS.
* ENABLE_WEBHOOK_NAMESPACE_SUFFIX When set to true, the operator looks up its MutatingWebhookConfiguration and ValidatingWebhookConfiguration under names suffixed with -<OPERATO
