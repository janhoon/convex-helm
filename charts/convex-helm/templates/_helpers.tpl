{{/*
Expand the name of the chart.
*/}}
{{- define "convex-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "convex-helm.fullname" -}}
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
{{- define "convex-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "convex-helm.labels" -}}
helm.sh/chart: {{ include "convex-helm.chart" . }}
{{ include "convex-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "convex-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "convex-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Backend labels.
*/}}
{{- define "convex-helm.backend.labels" -}}
{{ include "convex-helm.labels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{/*
Backend selector labels.
*/}}
{{- define "convex-helm.backend.selectorLabels" -}}
{{ include "convex-helm.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{/*
Dashboard labels.
*/}}
{{- define "convex-helm.dashboard.labels" -}}
{{ include "convex-helm.labels" . }}
app.kubernetes.io/component: dashboard
{{- end }}

{{/*
Dashboard selector labels.
*/}}
{{- define "convex-helm.dashboard.selectorLabels" -}}
{{ include "convex-helm.selectorLabels" . }}
app.kubernetes.io/component: dashboard
{{- end }}

{{/*
Service account name.
*/}}
{{- define "convex-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "convex-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Backend secret name (for instance secret).
*/}}
{{- define "convex-helm.secretName" -}}
{{- if .Values.instance.existingSecret }}
{{- .Values.instance.existingSecret }}
{{- else }}
{{- include "convex-helm.fullname" . }}
{{- end }}
{{- end }}

{{/*
Database secret name.
*/}}
{{- define "convex-helm.databaseSecretName" -}}
{{- if .Values.database.existingSecret }}
{{- .Values.database.existingSecret }}
{{- else }}
{{- printf "%s-database" (include "convex-helm.fullname" .) }}
{{- end }}
{{- end }}

{{/*
S3 secret name.
*/}}
{{- define "convex-helm.s3SecretName" -}}
{{- if .Values.storage.s3.existingSecret }}
{{- .Values.storage.s3.existingSecret }}
{{- else }}
{{- printf "%s-s3" (include "convex-helm.fullname" .) }}
{{- end }}
{{- end }}

{{/*
PVC name.
*/}}
{{- define "convex-helm.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- printf "%s-data" (include "convex-helm.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Backend internal URL for dashboard to connect to.
*/}}
{{- define "convex-helm.backendInternalUrl" -}}
http://{{ include "convex-helm.fullname" . }}-backend:{{ .Values.backend.service.apiPort }}
{{- end }}
