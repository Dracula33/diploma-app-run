{
  deployment(name, pod_name, replicas, image, tag)::
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: name,
      labels: {
        app: name
      }
    },
    spec: {
      replicas: replicas,
      selector: {
        matchLabels: {
          app: pod_name
        }
      },
      template: {
        metadata: {
          labels: {
            app: pod_name
          }
        },
        spec: {
          containers: [
            {
              local image_tag = if tag != '' then tag else 'latest',
              image: image + ':' + image_tag,
              name: pod_name,
              imagePullPolicy: 'IfNotPresent'
            }
          ]
        }
      }
    }
  },
  service(name, pod_name, type, port, nodePort)::
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: name,
    },
    spec: {
      type: type,
      ports: [
        {
          name: pod_name,
          port: port,
          [if type == 'NodePort' then 'nodePort'] : nodePort,
        }
      ],
      selector: {
        app: pod_name
      }
    }
  }
}
