local objects = import '../functions/objects.libsonnet';
local p = import '../params.libsonnet';
local params = p.components['my-diploma-app-deploy'];

objects.deployment(params.name, params.pod_name, params.replicas, params.image_name, params.image_tag)
