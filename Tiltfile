k8s_yaml(helm("charts/convex-helm", name="convex", values="dev/values-dev.yaml"))

k8s_resource(
    "convex-convex-helm-backend",
    port_forwards=[
        port_forward(3210, 3210, name="Backend API"),
        port_forward(3211, 3211, name="HTTP Actions"),
    ],
)

k8s_resource(
    "convex-convex-helm-dashboard",
    port_forwards=[
        port_forward(6791, 6791, name="Dashboard"),
    ],
)
