# convex-helm

![Version: 0.2.4](https://img.shields.io/badge/Version-0.2.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/convex-helm)](https://artifacthub.io/packages/search?repo=convex-helm)

A Helm chart for deploying Convex backend platform to Kubernetes

**Homepage:** <https://convex.dev>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| janhoon | <janhoon97@gmail.com> | <https://github.com/janhoon> |

## Source Code

* <https://github.com/get-convex/convex-backend>

## Installation

```bash
helm repo add convex https://janhoon.github.io/convex-helm
helm repo update
helm install convex convex/convex-helm
```

## Quick Start

### Minimal (SQLite + local storage)

```yaml
urls:
  cloudOrigin: "https://convex-api.example.com"
  siteOrigin: "https://convex-actions.example.com"
```

### Production (PostgreSQL + S3)

```yaml
urls:
  cloudOrigin: "https://convex-api.example.com"
  siteOrigin: "https://convex-actions.example.com"

database:
  type: postgres
  postgresUrl: "postgresql://user:pass@host:5432"

storage:
  type: s3
  s3:
    region: us-east-1
    buckets:
      exports: my-convex-exports
      snapshotImports: my-convex-snapshot-imports
      modules: my-convex-modules
      files: my-convex-files
      search: my-convex-search
    existingSecret: convex-s3-credentials

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  backend:
    host: convex-api.example.com
    tls:
      - secretName: convex-backend-tls
        hosts:
          - convex-api.example.com
  actions:
    host: convex-actions.example.com
    tls:
      - secretName: convex-actions-tls
        hosts:
          - convex-actions.example.com
  dashboard:
    host: convex-dashboard.example.com
    tls:
      - secretName: convex-dashboard-tls
        hosts:
          - convex-dashboard.example.com
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backend.affinity | object | `{}` | Affinity rules for backend pods. |
| backend.extraEnv | list | `[]` | Additional environment variables for the backend container. |
| backend.extraEnvFrom | list | `[]` | Additional environment variables from secrets/configmaps. |
| backend.image.pullPolicy | string | `"IfNotPresent"` |  |
| backend.image.repository | string | `"ghcr.io/get-convex/convex-backend"` |  |
| backend.image.tag | string | `"latest"` |  |
| backend.livenessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/version","port":"api"},"initialDelaySeconds":30,"periodSeconds":30,"timeoutSeconds":5}` | Liveness probe configuration. |
| backend.nodeSelector | object | `{}` | Node selector for backend pods. |
| backend.podAnnotations | object | `{}` | Pod annotations. |
| backend.podLabels | object | `{}` | Pod labels. |
| backend.podSecurityContext | object | `{"fsGroup":1000}` | Pod-level security context. |
| backend.priorityClassName | string | `""` | Priority class name. |
| backend.readinessProbe | object | `{"failureThreshold":3,"httpGet":{"path":"/version","port":"api"},"initialDelaySeconds":10,"periodSeconds":10,"timeoutSeconds":5}` | Readiness probe configuration. |
| backend.replicaCount | int | `1` | Number of replicas. Convex backend is a stateful single-instance service. DO NOT set this above 1 — the backend does not support horizontal scaling. |
| backend.resources.limits.cpu | string | `"2"` |  |
| backend.resources.limits.memory | string | `"4Gi"` |  |
| backend.resources.requests.cpu | string | `"500m"` |  |
| backend.resources.requests.memory | string | `"1Gi"` |  |
| backend.securityContext | object | `{}` | Container-level security context. |
| backend.service.actionsPort | int | `3211` | HTTP actions port. |
| backend.service.annotations | object | `{}` |  |
| backend.service.apiPort | int | `3210` | Backend API port. |
| backend.service.type | string | `"ClusterIP"` | Service type for the backend. |
| backend.startupProbe | object | `{"failureThreshold":60,"httpGet":{"path":"/version","port":"api"},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5}` | Startup probe configuration (gives extra time on first boot for migrations). |
| backend.strategy | object | `{"type":"Recreate"}` | Deployment strategy. Recreate is recommended since only one instance can run. |
| backend.terminationGracePeriodSeconds | int | `60` | Termination grace period in seconds. |
| backend.tolerations | list | `[]` | Tolerations for backend pods. |
| backend.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| concurrency.actionsUserTimeoutSecs | string | `""` | Action timeout in seconds. |
| concurrency.documentRetentionDelay | string | `""` | Document retention delay in seconds. |
| concurrency.maxConcurrentMutations | string | `""` | Max concurrent mutations. |
| concurrency.maxConcurrentNodeActions | string | `""` | Max concurrent Node.js actions. |
| concurrency.maxConcurrentQueries | string | `""` | Max concurrent queries. |
| concurrency.maxConcurrentV8Actions | string | `""` | Max concurrent V8 actions. |
| dashboard.affinity | object | `{}` |  |
| dashboard.enabled | bool | `true` | Enable the Convex dashboard. |
| dashboard.extraEnv | list | `[]` | Additional environment variables for the dashboard container. |
| dashboard.extraEnvFrom | list | `[]` | Additional environment variables from secrets/configmaps. |
| dashboard.image.pullPolicy | string | `"IfNotPresent"` |  |
| dashboard.image.repository | string | `"ghcr.io/get-convex/convex-dashboard"` |  |
| dashboard.image.tag | string | `"latest"` |  |
| dashboard.livenessProbe.failureThreshold | int | `3` |  |
| dashboard.livenessProbe.httpGet.path | string | `"/"` |  |
| dashboard.livenessProbe.httpGet.port | string | `"http"` |  |
| dashboard.livenessProbe.initialDelaySeconds | int | `15` |  |
| dashboard.livenessProbe.periodSeconds | int | `30` |  |
| dashboard.livenessProbe.timeoutSeconds | int | `5` |  |
| dashboard.nodeSelector | object | `{}` |  |
| dashboard.podAnnotations | object | `{}` |  |
| dashboard.podLabels | object | `{}` |  |
| dashboard.podSecurityContext | object | `{}` |  |
| dashboard.priorityClassName | string | `""` |  |
| dashboard.readinessProbe.failureThreshold | int | `3` |  |
| dashboard.readinessProbe.httpGet.path | string | `"/"` |  |
| dashboard.readinessProbe.httpGet.port | string | `"http"` |  |
| dashboard.readinessProbe.initialDelaySeconds | int | `5` |  |
| dashboard.readinessProbe.periodSeconds | int | `10` |  |
| dashboard.readinessProbe.timeoutSeconds | int | `5` |  |
| dashboard.replicaCount | int | `1` |  |
| dashboard.resources.limits.cpu | string | `"500m"` |  |
| dashboard.resources.limits.memory | string | `"512Mi"` |  |
| dashboard.resources.requests.cpu | string | `"100m"` |  |
| dashboard.resources.requests.memory | string | `"256Mi"` |  |
| dashboard.securityContext | object | `{}` |  |
| dashboard.service.annotations | object | `{}` |  |
| dashboard.service.port | int | `6791` |  |
| dashboard.service.type | string | `"ClusterIP"` |  |
| dashboard.tolerations | list | `[]` |  |
| database.doNotRequireSsl | bool | `false` | Disable SSL requirement for database connections (useful for in-cluster databases). |
| database.existingSecret | string | `""` | Use an existing secret for the database URL. The secret must contain a key matching the database type: `postgres-url` or `mysql-url`. |
| database.mysqlUrl | string | `""` | MySQL connection string (without database name). Required if type is "mysql". Example: "mysql://user:pass@host:3306" |
| database.postgresUrl | string | `""` | PostgreSQL connection string (without database name). Required if type is "postgres". Example: "postgresql://user:pass@host:5432" |
| database.type | string | `"sqlite"` | Database backend: "sqlite", "postgres", or "mysql". |
| fullnameOverride | string | `""` | Override full chart name. |
| imagePullSecrets | list | `[]` |  |
| ingress.actions | object | `{"host":"","tls":[]}` | Ingress for HTTP actions (port 3211). |
| ingress.annotations | object | `{}` | Annotations for the ingress resource. |
| ingress.backend | object | `{"host":"","tls":[]}` | Ingress for the backend API (port 3210). |
| ingress.className | string | `""` | Ingress class name (e.g., "nginx", "traefik"). |
| ingress.dashboard | object | `{"host":"","tls":[]}` | Ingress for the dashboard (port 6791). |
| ingress.enabled | bool | `false` | Enable ingress resources. |
| instance | object | `{"existingSecret":"","name":"convex-self-hosted","secret":""}` | Instance configuration |
| instance.existingSecret | string | `""` | Pre-existing secret containing the instance secret under key `instance-secret`. If empty, a secret will be auto-generated on first deploy. |
| instance.name | string | `"convex-self-hosted"` | Name for this Convex instance. Also determines the database name (dashes become underscores). |
| instance.secret | string | `""` | Instance secret (hex string). Only used if existingSecret is empty. If left empty, the backend will auto-generate one and persist it to the data volume. |
| logging.level | string | `"info"` | Rust log level for the backend. Options: error, warn, info, debug, trace. |
| logging.redactLogsToClient | bool | `false` | Redact sensitive data from log output sent to clients. |
| metrics.enabled | bool | `false` | Enable the Prometheus metrics endpoint on the backend (/metrics on port 3210). |
| metrics.prometheusRule.enabled | bool | `false` | Create PrometheusRule resources for alerting. |
| metrics.prometheusRule.labels | object | `{}` | Additional labels for the PrometheusRule. |
| metrics.prometheusRule.namespace | string | `""` | Namespace for the PrometheusRule. Defaults to release namespace. |
| metrics.prometheusRule.rules | list | `[]` | Alert rules. See values below for examples. |
| metrics.serviceMonitor.enabled | bool | `false` | Create a ServiceMonitor resource for Prometheus Operator. |
| metrics.serviceMonitor.interval | string | `"30s"` | Scrape interval. |
| metrics.serviceMonitor.labels | object | `{}` | Additional labels for the ServiceMonitor (e.g., for Prometheus selector). |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling configs. |
| metrics.serviceMonitor.namespace | string | `""` | Namespace for the ServiceMonitor. Defaults to release namespace. |
| metrics.serviceMonitor.relabelings | list | `[]` | Relabeling configs. |
| metrics.serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| nameOverride | string | `""` | Override chart name. |
| networkPolicy.backendIngressRules | list | `[]` | Additional ingress rules for the backend. |
| networkPolicy.dashboardIngressRules | list | `[]` | Additional ingress rules for the dashboard. |
| networkPolicy.enabled | bool | `false` | Enable network policies. |
| persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for the PVC. |
| persistence.annotations | object | `{}` | Annotations for the PVC. |
| persistence.enabled | bool | `true` | Enable persistent storage. Required for SQLite and local file storage. |
| persistence.existingClaim | string | `""` | Use an existing PVC instead of creating one. |
| persistence.size | string | `"10Gi"` | Size of the persistent volume. |
| persistence.storageClassName | string | `""` | Storage class name. Leave empty for default. |
| podDisruptionBudget.enabled | bool | `false` | Enable PDB for the backend. |
| podDisruptionBudget.minAvailable | int | `1` | Min available pods. Since backend is single-instance, this protects against voluntary disruptions (e.g., node drains) by blocking them until you're ready. |
| serviceAccount.annotations | object | `{}` | Annotations for the service account. |
| serviceAccount.create | bool | `true` | Create a service account. |
| serviceAccount.name | string | `""` | Name of the service account. Auto-generated if empty. |
| storage.s3.accessKeyId | string | `""` | AWS access key ID. |
| storage.s3.buckets | object | `{"exports":"","files":"","modules":"","search":"","snapshotImports":""}` | S3 bucket names. All 5 are required when using S3 storage. |
| storage.s3.disableChecksums | bool | `false` | Disable S3 checksums (compatibility flag). |
| storage.s3.disableSse | bool | `false` | Disable server-side encryption (compatibility flag). |
| storage.s3.endpointUrl | string | `""` | S3 endpoint URL (for S3-compatible services like MinIO, R2, DigitalOcean Spaces). |
| storage.s3.existingSecret | string | `""` | Use an existing secret for S3 credentials. Must contain keys: `aws-access-key-id` and `aws-secret-access-key`. |
| storage.s3.forcePathStyle | bool | `false` | Force path-style addressing (required for MinIO). |
| storage.s3.region | string | `""` | AWS region for S3 buckets. |
| storage.s3.secretAccessKey | string | `""` | AWS secret access key. |
| storage.s3.sessionToken | string | `""` | Optional AWS session token. |
| storage.type | string | `"local"` | Storage backend: "local" or "s3". |
| telemetry.disableBeacon | bool | `false` | Disable anonymous usage telemetry beacon. |
| urls | object | `{"cloudOrigin":"http://127.0.0.1:3210","siteOrigin":"http://127.0.0.1:3211"}` | External URLs as seen by clients. Must be set for production deployments. |
| urls.cloudOrigin | string | `"http://127.0.0.1:3210"` | External URL for the backend API (port 3210). Used by SDKs to connect. |
| urls.siteOrigin | string | `"http://127.0.0.1:3211"` | External URL for HTTP actions endpoint (port 3211). |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)
