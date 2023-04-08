
// this file has the baseline default parameters
{
  components: {
    'my-diploma-app-deploy': {
      name: 'my-diploma-app-deploy',
      pod_name: 'diploma-app',
      replicas: 1,
      image_name: std.extVar("app_image_name"),
      image_tag: std.extVar("app_image_tag"),
    },
    'my-diploma-app-service': {
      name: 'my-diploma-service',
      pod_name: 'diploma-app',
      type: 'NodePort',
      port: 80,
      nodePort: 32000
    },
  },
}
