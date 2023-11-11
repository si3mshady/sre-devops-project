# Sensu Enterprise Edition

[![CircleCI](https://circleci.com/gh/sensu/sensu-enterprise-go.svg?style=svg&circle-token=7dc7a54efd6715ffc74bfc0371b0191a4a05f244)](https://circleci.com/gh/sensu/sensu-enterprise-go)

Sensu is an open source monitoring tool for ephemeral infrastructure
and distributed applications. It is an agent based monitoring system
with built-in auto-discovery, making it very well-suited for cloud
environments. Sensu uses service checks to monitor service health and
collect telemetry data. It also has a number of well defined APIs for
configuration, external data input, and to provide access to Sensu's
data. Sensu is extremely extensible and is commonly referred to as
"the monitoring router".

To learn more about Sensu, [please visit the website](https://sensu.io/).

## Building packages

```
mkdir ../obj
cd ../obj
cmake ../sensu-enterprise-go
make VERBOSE=1
make sensu-packages
```

## Publishing CircleCI Orbs

### Development Versions

Anyone in the GitHub organization can publish development versions of orbs.
These versions will expire after 90 days and should not be used in the `main` or
`release/` branches. A dev version can be published by running the following,
specifying the orb name & dev version:

``` sh
circleci orb pack src | circleci orb publish - sensu/orb@dev:version
```

### Stable Versions

For now, CircleCI limits the publishing of CircleCI orbs to GitHub Organization
administrators. If a new release of any of our CircleCI orbs is needed, please
contact one of the GitHub Organization admins:
* [Justin][justin-slack]
* [Sean][sean-slack]
* [Cameron][cameron-slack]
* [Anthony][anthony-slack]
* [Caleb][caleb-slack]

**NOTE:** If an orb needs to be published and the GitHub Organization admins
cannot be reached via Slack, contact [Justin][justin-slack] via SMS/Phone.

Orbs can be published by checking out the latest code from the orb repository
and then running the following, specifying the orb name & dev version & whether
or not to use a major, minor, or patch level version bump:

``` sh
circleci orb pack src | circleci orb publish promote sensu/orb@dev:version bump-type
```

[justin-slack]: https://sensu.slack.com/team/U053FL3SK
[sean-slack]: https://sensu.slack.com/team/U051E44V1
[cameron-slack]: https://sensu.slack.com/team/U0562RSF2
[anthony-slack]: https://sensu.slack.com/team/U054A5JD7
[caleb-slack]: https://sensu.slack.com/team/U02L65BU5
