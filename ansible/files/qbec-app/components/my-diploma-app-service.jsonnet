local objects = import '../functions/objects.libsonnet';
local p = import '../params.libsonnet';
local params = p.components['my-diploma-app-service'];

objects.service(params.name, params.pod_name, params.type, params.port, params.nodePort)
