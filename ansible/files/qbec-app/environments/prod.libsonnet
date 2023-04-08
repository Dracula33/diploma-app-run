
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    'my-diploma-app-deploy' +: {
      replicas: 3
    }
  }
}
