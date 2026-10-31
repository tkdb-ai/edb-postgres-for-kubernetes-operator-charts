{{/*
Expand the name of the chart.
*/}}
{{- define "edb-database-cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "edb-database-cluster.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "edb-database-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "edb-database-cluster.labels" -}}
helm.sh/chart: {{ include "edb-database-cluster.chart" . }}
{{ include "edb-database-cluster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "edb-database-cluster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "edb-database-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name of the Cluster resource.
*/}}
{{- define "edb-database-cluster.clusterName" -}}
{{- default (include "edb-database-cluster.fullname" .) .Values.clusterName }}
{{- end }}

{{/*
Name of the application user Secret.
*/}}
{{- define "edb-database-cluster.appUserSecretName" -}}
{{- default (printf "%s-app-user" (include "edb-database-cluster.fullname" .)) .Values.secrets.appUser.name }}
{{- end }}

{{/*
Name of the superuser Secret.
*/}}
{{- define "edb-database-cluster.superuserSecretName" -}}
{{- default (printf "%s-superuser" (include "edb-database-cluster.fullname" .)) .Values.secrets.superuser.name }}
{{- end }}

{{/*
Name of the backup credentials Secret.
*/}}
{{- define "edb-database-cluster.backupSecretName" -}}
{{- default (printf "%s-backup-creds" (include "edb-database-cluster.fullname" .)) .Values.backup.credentials.name }}
{{- end }}

{{/*
Name of the sidecar scripts ConfigMap. Must match whatever
plugins[].parameters.configMapName is set to.
*/}}
{{- define "edb-database-cluster.sidecarScriptsConfigMapName" -}}
{{- default "supercronic-scripts" .Values.sidecarScripts.name }}
{{- end }}

{{/*
Look up an existing password value in a Secret, falling back to a freshly
generated random string. This keeps auto-generated passwords stable across
"helm upgrade" runs instead of rotating them on every install.
Usage: include "edb-database-cluster.getOrGeneratePassword" (dict "secretName" "my-secret" "key" "password" "context" .)
*/}}
{{- define "edb-database-cluster.getOrGeneratePassword" -}}
{{- $existing := lookup "v1" "Secret" .context.Release.Namespace .secretName }}
{{- if $existing }}
{{- index $existing.data .key | b64dec }}
{{- else }}
{{- randAlphaNum 24 }}
{{- end }}
{{- end }}
