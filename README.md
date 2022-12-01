# IT4IPM Apigee Config repo

This repo contains the configuration for Apigee org (apigee-prod-0ad9). Based on the branch the concerning changes are automatically via Github actions deployed to the corresponding environment/ org.

## Manually config deployment

Deployment of the config

```sh
./prepare-local-deployment.sh
mvn clean install -ntp -B -Px-cicd -Dbearer=$(gcloud auth print-access-token)
```

## Examples

See for more info: https://github.com/apigee/apigee-config-maven-plugin/tree/master/samples/EdgeConfig

### Environment config

```json
env/{env}..
aliases.json:
[
  {
    "alias": "testSelfSignedCert",
    "keystorename": "testKeyStorename",
    "format": "selfsignedcert",
    "keySize": "2048",
    "sigAlg": "SHA256withRSA",
    "subject": {
      "commonName": "testcommonName"
    },
    "certValidityInDays": "60"
  }
]

keystores.json:
[
  {
    "name": "testKeyStorename"
  }
]


kvms.json:
[
  {
    "entry": [
      {
        "name": "COMPANY",
        "value": "example.com"
      },
      {
        "name": "PREFIX",
        "value": "EXMPL"
      }
    ],
    "name": "backend_account_config"
  }
]

references.json:
[
  {
    "name": "sampleReference",
    "refers": "testKeyStorename",
    "resourceType": "KeyStore"
  }
]

targetServers.json:
[
  {
    "name": "Enterprisetarget",
    "host": "example.com",
    "isEnabled": true,
    "port": 8080
  },
  {
    "name": "ESBTarget",
    "host": "enterprise.com",
    "isEnabled": true,
    "port": 8080
  }
]

```

### Org config

```json
org/..
apiProducts.json:
[
  {
    "name": "weatherProduct",
    "displayName": "weatherProduct",
    "description": "weatherProduct",
    "apiResources": ["/**", "/"],
    "approvalType": "auto",
    "attributes": [
      {
        "name": "description",
        "value": "json Product"
      },
      {
        "name": "developer.quota.limit",
        "value": "10000"
      },
      {
        "name": "developer.quota.interval",
        "value": "1"
      },
      {
        "name": "developer.quota.timeunit",
        "value": "month"
      }
    ],
    "environments": ["test"],
    "proxies": ["forecastweatherapi"],
    "quota": "10000",
    "quotaInterval": "1",
    "quotaTimeUnit": "month",
    "scopes": []
  }
]

developerApps.json:
{
  "grant@enterprise.com": [
    {
      "apiProducts": ["weatherProduct"],
      "callbackUrl": "http://weatherapp.com",
      "name": "grantoneapp",
      "scopes": []
    },
    {
      "apiProducts": ["weatherProduct"],
      "callbackUrl": "http://weatherapp.com",
      "name": "granttwoapp",
      "scopes": []
    }
  ],
  "hugh@example.com": [
    {
      "apiProducts": ["weatherProduct"],
      "callbackUrl": "http://weatherapp.com",
      "name": "hughapp",
      "scopes": []
    }
  ]
}

developers.json:
[
  {
    "attributes": [],
    "email": "hugh@example.com",
    "firstName": "Hugh",
    "lastName": "Jack",
    "userName": "hughexample"
  },
  {
    "attributes": [],
    "email": "grant@enterprise.com",
    "firstName": "Grant",
    "lastName": "Smith",
    "userName": "grantsmith"
  }
]

```
