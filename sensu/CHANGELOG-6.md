
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic
Versioning](http://semver.org/spec/v2.0.0.html).

## [6.9.2] - 2023-03-08

### Fixed
- [Web] Fixed crash on Service Component detail page

## [6.9.1] - 2022-12-01

### Fixed
- Fixed Graphql Selectors bug that caused the entity page to show events for all entities
- [Web] Fixed the Github url for feedback suggestions on the catalogs view
- [Web] Reimplemented saved searches on the entity list view
- [Web] Fixed Web UI crash on Pipeline edit form
- [Web] Fixed XSS vulnerability in Check result outputs
- [Web] Removed erroneous links from edit page success messages

## [6.9.0] - 2022-11-01

### Fixed
- [Web] Fixed error handling Unauthorized errors while mutating resources.
- [Web] Saves searches can no longer be accidentally overwritten.
- [Web] Check view displays an indicator when the configured asset could
not be fetched.
- [Web] Fixed the generated searches for filtering list items.

### Changed
- [Web] Hides the Catalog Navigation item when the catalog feature is disabled.
- [Web] Added prompt for submitting feedback to the Sensu team when a Catalog
search comes back empty.
- [Web] Informs users about missing permission requirements.

### Added
- Adds a CyberArk Secrets Provider.

## [6.8.2] - 2022-10-06

### Added
- A sensu.io/output\_truncated\_bytes label is now applied to events when
the check output has been truncated due to a check's max\_output\_size
configuration.

### Fixed
- Bring back silence action button in the entities page.
- Newly created assets were not displayed until page was refreshed.
- Raw tab was not working for pipelines
- Fixed entity documentation link.
- Fixed error when deleting and re-adding an asset from asset page.
- Fixed error when adding a new check with leading white spaces.
- Fixed endless loading indicator in resource views.
- Fixed error when authorized user did not have an explicit username.

## [6.8.1] - 2022-09-13

### Fixed

- [Web] Handle case where an OIDC refresh token has expired by invoking the
sign-in dialog.

## [6.8.0] - 2022-08-24

### Added

- [Web] The backend node that responded is now displayed in the System Status
dialog. You may access the dialog with CTRL + PERIOD keyboard shortcut.
- [Web] Asset, hooks, secrets, and pipeline list views are now available.

### Changed
- Removed /api/enterprise/secrets/v2 API and supporting code.
- Updated the enterprise api routes to not accept traffic until the
`--api-serve-wait-time` delay expires.
- [Web] Configuration resources are now rendered in an infinite list.

### Fixed

- [Web] If check's issued at date is null, "N/A" is now printed instead of
"December 31, 1969".

## [6.7.5] - 2022-08-10

### Security
- Updated the package graphql-go/graphql to address [CVE-2022-37315](https://nvd.nist.gov/vuln/detail/CVE-2022-37315); a malicious actor may craft a query that can crash the backend instance.

## [6.7.4] - 2022-07-15

### Changed
- Build with Go 1.17.12 to fix several CVEs. See Go release notes for details.

## [6.7.3] - 2022-07-07

### Added
- Added a new built-in `integration_base_url`` variable for Catalog
`resource_patches` and `post_install` content.

### Fixed
- Fixed a bug where BSM service component metadata was not added to generated events.
- Removed database constraint causing backends to crash when agents are ran on
hosts with many addresses associated with a single network interface.
- Fixed a bug where too many events were included in a BSM service component query.
- LDAP & Active Directory searches are no longer limited to 1,000 results.
- Catalog initial prompts are now validated against prompts.
- Fixed Catalog sort order.
- Sensu Plus source URL is no longer truncated.
- Web UI toast notifications are now rendered over all other content.

## [6.7.2] - 2022-05-12

### Changed
- [Web] Updated the Sensu Plus dialog copy to warn users not to use
the form when they have an existing Sumo Logic account.
- [Web] Sensu Plus post setup dialog Source URL copy button now uses a
toast notification.

### Fixed
- Fixed a backend crash when pruning core/v3 resources
- Implement an active poller for Postgres configuration changes.

## [6.7.1] - 2022-04-28

### Changed
- [Web] Tweaked the install button for Catalog Integrations.
- [Web] The Catalog Integrations list is now sorted alphabetically.
- [Web] Catalog styling tweaks.

### Fixed
- [Web] Fixed issue where resources installed by a Catalog Integration were not
overridden.

## [6.7.0] - 2022-04-21

### Added
- Backend metrics log and endpoint now include `sensu_go_etcd_cluster_leases`
metric. Tracks the count of current leases held by etcd to aide in debugging.
- Improved logging around TCPStreamHandler events
- Added resource types for /api/enterprise/secrets/v2
- Backend api for secrets v2 resources

### Changed
- BSM always uses the postgres round robin ringv2 implementation regardless of
the enable_round_robin flag on the active PostgresConfig
- sensu.CheckDependencies now supports arrays of strings and objects.

### Fixed
- Fixed bug where pipelines would hang after a pipeline/v1.TCPStreamHandler is
ran with max_connections set greater than zero.

## [6.6.6] - 2022-02-16

### Added
- Added error type to GraphQL metrics; primarily should help track down the
source of slow  queries.

### Fixed
- When "strict: true" is configured in store/v1.PostgresConfig, the postgres
provider will try to connect to an unavailable postgres server forever, instead
of giving up after 3 tries and reverting to etcd.
- Strict mode now checks whether the current user has CREATE privilege within
the current schema, not within the current database. This is a more precise
expression of the privileges actually needed to create and upgrade a sensu
database.
- The postgres provider now respects context cancellation and fails immediately
when a user issues a termination signal.
- Fixes issue where metrics were not recorded when an error occurred. Among
other things this meant that when a deadline was exceeded the duration was not
collected.

## [6.6.5] - 2022-02-03

### Changed
- Now built with Go 1.17.6. RHEL FIPS binaries now built with Go 1.16.12.
- Queries for multiple entity states, when using PostgreSQL, have been made more
efficient.
- [Web] Starting in v6.6.3, for performance reasons, filtering of entities stops
after 500 matches. In addition, with v6.6.5 and moving forward, if more than
500 entities match the filter, the web UI will display a message suggesting
there are more than 500 relevant entities.
- [Web] Federated clusters will now query remote clusters in parallel.
- [Web] Improved performance of GraphQL queries to the local cluster.
- [Web] Reduced potential cluster load by no longer invoking GraphQL field
resolvers when the query deadline has already been reached.

### Fixed
- Fixed bug in postgres round robin scheduling where notification routing
could be delayed after BSM service components are created or updated.
- Fixed bug in postgres config watcher where bsmd was not re-enabled correctly
on update.

## [6.6.4] - 2022-01-25

### Fixed
- Fixed bugs in BSM and round robin scheduling. When postgres round robin
scheduling is enabled, users will no longer see missed check executions.
- Fixed a bug where sensu-backend would crash if postgresql was taken offline
and started up again.
- Fixed a bug where ephemeral backend entity rows would fill up the entities
table in postgresql.
- BSM event selectors can no longer select events outside the ServiceComponent
namespace.
- [Web] Added X-Frame-Options header to tell browsers the web application cannot
be loaded within an iframe; loaded in this manner, it can be susceptible to
tailored click jacking attacks.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
- [Web] Added HSTS header if TLS has been configured; ensures the browser loads
the application and its requisite assets with a secure connection.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security
- [Web] Added X-Content-Type-Options: nosniff header to have browsers respect
the given Content-Type header when loading content referenced by a script tag.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
- Fixed a bug where HTTP requests were not properly cancelled after a context
deadline (timeout) had been exceeded.

## [6.6.3] - 2021-12-15

### Changed
- Reduced Postgres health check query cost, count(*) -> limit 1.
- [Web] To help reduce load on clusters, the default polling interval on the
entities list page has been changed to 30 seconds.

## [6.6.2] - 2021-12-08

### Fixed
- [Web] Fixed an issue where the dashboard was providing bad links for cluster
wide resources.

### Removed
- [Web] Removed the "Related Entities" card from events & entities views, this
feature was under-utilized and lead to significant memory consumption to
construct.

## [6.6.1] - 2021-11-29

### Fixed
- [Web] Clear silences dialog no longer expands to the entire frame

## [6.6.0] - 2021-11-25

### Added
- Added sorting support to the Postgres event store.
- [Web] A warning is now displayed when editing a resource when
gateway cluster is a newer version than the target cluster.

### Changed
- GraphQL is now able to leverage the Postgres event store for sorting
events and getting the total event count.
- [Web] Check output with ANSI color escape codes are now displayed
with the correct color.

## [6.5.5] - 2021-11-19

### Added
- Add a `--dashboard-write-timeout` flag to make the dashboard's HTTP write timeout configurable
- Add a `--api-write-timeout` flag to make the API's HTTP write timeout configurable

### Changed
- Vendor `sensu/sensu-go` @ 0d7faf33ec169b1de5f589a7a9d8ebf25da2e11c.

## [6.5.4] - 2021-10-30

### Changed
- Updated sensu-go api/core to v2.12.0
- Vendor `sensu/sensu-go` @ 74b07ee479968c11ff46d5283b13e02bd7e55888.

## [6.5.3] - 2021-10-29

### Changed
- Vendor `sensu/sensu-go` @ a1b14657e561cdd584b1a74fc6d3c132ac1c6d6d.

## [6.5.2] - 2021-10-28

### Fixed
- [Web] Omits unintended "__virtual" field from json/yaml representation of resources

## [6.5.1] - 2021-10-18

### Added
- [Web] Added support for Javascript mutators

### Fixed
- Fixed a bug that can result in an error being returned when listing entities
when the postgres store is enabled.
- [Web] Fixed issue with native datepicker that lead to issues while creating
silences
- [Web] Fixed bug blocking user's from editing service components
- [Web] Fixed redirect when deleting an entity

## [6.5.0] - 2021-10-12

### Added
- Added support for environment variable arguments in `sensuctl`.
- Added support for pipelines from sensu-go.
- Added the pipeline/v1.TCPStreamHandler type.
- Added the SumoLogic metrics handler.
- Added Prometheus metrics for TCPStreamHandler.

### Removed
- Event logging is now implemented in sensu-go.

## [6.4.3] - 2021-09-01

### Fixed
- Fix deadlock in the event log writer.

## [6.4.2] - 2021-08-31

### Added
- Add an `--event-log-parallel-encoders` flag to make parallel event log encoding configurable.

## [6.4.1] - 2021-08-24

### Fixed
- Fixed a number of issues present in sensu-go. See sensu-go CHANGELOG for details.
- The backend now works more reliably with older versions of federation and
sensuctl, due to omitting allowed_groups from the LDAP provider if the field
has not been populated.
- webd now logs at warn level when it starts up.

## [6.4.0] - 2021-06-23

### Fixed
- Fix context cancelled error when running OIDC login with sensuctl
- [Web] Entities without any associated events will display status as unknown
- The event logger no longer emits errors when targeting `stdout`

### Added
- [Web] Clickable components to the Dashboard.
- [Web] Added more in depth silence information to the event details page
- [Web] Order and page size are now persisted between pages via local storage

### Changed
- Made database schema migration errors more descriptive.
- [Web] Configuration views are now more easily editable and detailed

## [6.4.0] - 2021-06-23

### Added
- Remove extraneous auto-completion suggestions.
- [Web] Add the ability to configure certain parameters per page.
- Added `darwin/arm64` to the list of platforms we build sensu-agent & sensuctl
for.

### Fixed
- Fixed config deprecation warnings from being shown when deprecated config
options weren't set.
- Fixed string tokens being considered to be unexpected if they appeared right
  after the && operator in selector expressions.
- Invalid PostgresConfig resources can no longer be created.
- [Web] Events page default selector can now be set through the webconfig

### Changed
- PostgresConfig resources can no longer have a namespace attribute.
- Entity state is now stored in postgresql. (last_seen, system attributes). This
reduces write load on etcd. Existing entity state will not be migrated or removed.

## [6.3.0] - 2021-05-25

### Added
- Added support for agent transport rate limiting. See sensu-backend start --help
for more information.
- Added BSM evaluator.
- Added bsmd, the Business Service Monitoring daemon.
- Added "aggregate_check" RuleTemplate.
- Added explicit Name field to BSM rules.
- Include Postgres health information in agentd's health endpoint.
- [Web] Forms may now include example inputs.

### Fixed
- [Web] Ensure that the error dialog is readable when using dark mode.
- Postgres batching now works correctly.

### Changed
- Migrated event store from github.com/lib/pq to github.com/jackc/pgx.

## [6.2.7] - 2021-04-01

### Fixed
- Fixed a potential deadlock in metricsd that could occur when performing an
internal restart.

## [6.2.6] - 2021-03-24

### Fixed
- Fixed a bug where postgres round robin scheduling would use a separate postgres
connection for each subscription. Round robin scheduling now uses exactly one extra
postgres connection.
- Enterprise API endpoints now better validate their POST/PUT inputs

## [6.2.5] - 2021-02-02

### Fixed
- Fixed a bug where occurrences_watermark wouldn't increment for non-zero events
when using the postgres store.

## [6.2.4] - 2021-01-28

### Fixed
- federation/v1.Cluster now appears in 'sensuctl describe-type all'.
- Fixed a performance issue that affected the web ui when using the postgres store.

## [6.2.3] - 2021-01-20

### Fixed
- Fixed a number of issues present in sensu-go. See sensu-go CHANGELOG for details.

## [6.2.2] - 2021-01-14

### Fixed
- Fixed a bug where postgres round robin scheduling would be enabled in all cases.
- Fixed a bug where round robin scheduling would not work if the combination of
namespace and check name were longer than 63 characters.

## [6.2.1] - 2021-01-08

### Fixed
- Fixed a bug where 'sensuctl prune hook' and 'sensuctl prune check' did not
behave as intended.
- Fixed a bug where postgres couldn't be enabled on some systems that had been
upgraded from 5.x.
- [Web] fixed a bug where entities managed by a sensu agent were still able to be edited

## [6.2.0] - 2020-12-17

### Added
- Added support for the memberOf attribute in LDAP authentication provider.
- Added the ability to omit types when pruning resources.
- Added support for round-robin scheduling on postgres instead of etcd.
- Allow OIDC authentication via `sensuctl configure`.
- Added BSM RuleTemplate.
- Added BSM ServiceComponent.
- Added core/v3 resource API machinery.

### Fixed
- The pruning API and its `sensuctl` interface now need less broad permissions
to work.
- sensuctl will no longer error when SSL certificates for the Vault provider do
not exist on the local system.

### Changed
- Changed sensuctl commands that only contain subcommands to exit with status
code 46 when no arguments or incorrect arguments are given.
- The sensuctl command descriptions now have consistent capitalization.
- Warning messages about approaching a license's entity or entity class limit
are now only displayed for users with create or update permissions to licenses.
- Refactored entity limiter.

## [6.1.4] - 2020-12-16

## Fixed
- Fixed a number of issues present in sensu-go. See sensu-go CHANGELOG for details.

## [6.1.3] - 2020-11-09

### Fixed
- Fixed a bug where event updates would fail with a message about occurrences
being NULL, when using the postgres event store.

## [6.1.2] - 2020-10-28

### Changed
- Vendor `sensu/sensu-go` @ 27af473a8dd3293096708dfcec35e2d98baf1863.

## [6.1.1] - 2020-10-22

### Fixed
- Properly handle hooks while pruning resources.
- Fixed a bug where selector '!=' would return incorrect results for label
selectors when no labels are defined.

## [6.1.0] - 2020-10-05

### Added
- Added support for the memberOf attribute in LDAP authentication provider.

## [6.1] - 2020-10-05

### Added
- Added "strict" field to PostgresConfig to ease debugging of incorrect
configuration and database permissions.
- Support custom secrets engine path in Vault secrets.
- Added TLS configuration to the `Cluster` resource to allow additional CA
certificates and insecure mode to be specified.
- Added a `types` query parameter for listing polymorphic resources via the API.
- The alpine-based Docker image now has multi-arch support with support for the
linux/386, linux/amd64, linux/arm64, linux/arm/v6, linux/arm/v7, linux/ppc64le,
and linux/s390x platforms.
- Added the `disable_offline_access` configuration attribute to the OIDC
authentication provider, which removes the default `offline_access` scope.

### Fixed
- Fixed a bug in `sensuctl dump` where polymorphic resources (ex. secrets providers
and authentication providers) could dump other providers of the same type.
- [Web] New search/filter box functionality, improved syntax and suggestions
- Check output no longer gets truncated in the event log file when the
max output size is set and the postgres event store is enabled.
- `sensuctl prune` now handles multi-file/multi-url input correctly.
- Fixed a bug where postgres errors could cause the backend to panic.
- Fixed a bug where postgres would refuse to store event with a negative check status.

### Changed
- Improved logging around OIDC authentication providers.
- Added indexed field and label selectors to the postgres store. Querying the
postgres event store with field and label selectors is now an order of magnitude
more performant.

## [5.21.2] - 2020-08-31

### Fixed
- Fixed a bug where postgres errors could cause the backend to panic.

## [5.21.1] - 2020-08-05
*No changelog for this release.*

## [6.0.0] - 2020-08-04

### Added
- Secondary groups are now passed to sysvinit services' chroot.
- Added sensu.CheckDependencies Sensu Query Expression.
- Added sensu.FetchEvent(entity, check) and sensu.ListEvents() to the JS
filter execution environment. Users can now query the Sensu event store for
other events within the filter namespace.
- Added freebsd/arm and linux/s390x to the targets we build sensu-agent and
sensuctl for.
- Added linux/ppc64le to the targets we build sensu-agent, sensu-backend, and
sensuctl for.
- Added linux packaging for 386, arm64, armv5 (armel), armv6 (armhf),
armv7 (armhf), mips64le (hardfloat), mips (hardfloat), mipsle (hardfloat),
ppc64le, and s390x. (see https://github.com/sensu/sensu-enterprise-go/pull/1147
for more information)

### Changed
- Automated CGO builds for darwin_amd64.
- AppVeyor is now triggered directly from a CircleCI step rather than cmake.
- Add support for the memberOf attribute of Active Directory.
- Package revisions are now set to CircleCI pipeline number instead of job
number.
- Refactored our package tooling to allow for building packages for additional
platforms.
- Docker images now set their own defaults for `SENSU_BACKEND_URL`,
`SENSU_BACKEND_API_URL`, `SENSU_BACKEND_ETCD_INITIAL_CLUSTER`,
`SENSU_BACKEND_ETCD_ADVERTISE_CLUSTER`,
`SENSU_BACKEND_ETCD_INITIAL_ADVERTISE_PEER_URLS`,
`SENSU_BACKEND_ETCD_LISTEN_CLIENT_URLS`, and `ETCD_LISTEN_PEER_URLS`.
- Upgraded Go version from 1.13.7 to 1.13.15.
- Upgraded etcd version from 3.3.17 to 3.3.22.

### Fixed
- Provide more descriptive errors for federation in the WebUI.
- Fix label selectors with multiple requirements for events.
- Fixed an issue where broken secrets providers wouldn't surface their errors.

## [5.21.0] - 2020-06-10

### Added
- Added support to retrieve the serialized json license file for handler executions.
- Added entity class limits and entity class counts to license metadata.
- Added entity class counts as Tessen metrics.
- Added new OpenSSL-linked builds for sensu-agent & sensu-backend.
- Added `--require-openssl` and `--require-fips` flags to sensu-agent &
sensu-backend (OpenSSL-linked binaries only).

### Changed
- Updated the `sensuctl license info` tabular title to reflect entity class counts/limits in
addition to the total entity count/limit.

## [5.20.2] - 2020-05-26

### Changed
- Temporarily disable process discovery in the agent

## [5.20.1] - 2020-05-15

### Fixed
- Fixed a bug where the event & keepalive gauges could not be retrieved when
PostgreSQL was used for event storage.
- The libc implementation is now properly referenced in the federated dashboard.
- No longer capitalize the process names in the Web UI.
- The entity float type is no longer displayed in the Web UI.
- The display of % for CPU and memory usage has been fixed in the Web UI.

## [5.20.0] - 2020-05-12

### Added
- Added metricsd to collect metrics for the Web UI.
- Added PostgreSQL metrics suite to let metricsd collect metrics about events
stored in PostgreSQL.
- The current entity count and license limit have been added to the license
metadata.
- Adds `--discover-processes` flag and populates `processes` field in
`entity.system` if enabled.
- Set `Edition` version attribute to `enterprise`.
- Added `EntityClassLimits` to the license struct to map entity limits by the entity class.
- Added `--entity-class-limits` to the sensu-license command to generate licenses with specific
entity class limits.
- Enforce soft entity class limits (warning banners).
- Enforce hard entity class limits (restrict new entities)
- [Web] Added ability to configure application defaults.
- [Web] Added federated HUD.
- [Web] Added process and additional system information to entity details view.

### Fixed
- Database connections are no longer leaked after queries to the cluster health
API.

## [5.19.3] - 2020-04-30

### Fixed
- The backend no longer leaks goroutines on internal restart.

## [5.19.2] - 2020-04-27

### Added
- Added sql database connection pool options to store/v1.PostgresConfig.
- Added Ubuntu 19.10 (Eoan Ermine) and 20.04 (Focal Fossa) to the list of
packagecloud repositories we upload deb packages to.

## [5.19.1] - 2020-04-13

### Fixed
- Fixed a bug where the postgres store would be enabled too late on startup,
leading to keepalive bugs and possibly other bugs.

## [5.19.0] - 2020-03-26

### Added
- Added `PostgresHealth` information to the `/health` endpoint.
- Added `matches` as an operator for api filtering selectors.
- Added agent & sensuctl builds for `linux` architectures: `mips`, `mipsle`,
`mips64` and `mips64le` (both `softfloat` and `hardfloat`).
- [Web] Added ability to save, recall, and delete searches.
- Added `sensuctl prune` command.
- Added Tessen metrics for auth providers, secrets & secrets providers.

## Fixed
- Fixed a bug where event.Check.State was not set for events passing through
the pipeline, or for events written to the event log.

## [5.18.1] - 2020-03-10

## Fixed
- Fixed a bug where OIDC login can result in a nil pointer panic.
- Fixed a bug that was causing SQL migrations to fail on PostgresQL 12.

## [5.18.0] - 2020-02-20

### Changed
- Updated Go version from 1.13.5 to 1.13.7.

### Fixed
- Field and label selectors now accept single and double quotes to identify
strings.

## [5.17.2] - 2020-02-19

### Fixed
- Fixed a panic on backend restart.

## [5.17.1] - 2020-01-31

### Changed
- Vendor `sensu/sensu-go` @ 9c0a793f79e4a4f874cf0f1868e98e295d931822

### Fixed
- [Web] Re-enables polling on the silences view

## [5.17.0] - 2020-01-28

### Added
- Added the secret resource.
- Added the secrets provider resource `secrets/v1.Provider`.
- Added the HTTP API for secrets provider management `/api/enterprise/secrets/v1/providers`.
- Implemented the built-in `Env` secrets provider.
- Added `sensuctl secret` subcommands for `list`, `info`, and `delete`.
- Added the vault secret provider
- Added `PERMISSION.pdf` to the Chocolatey packages.
- Added the ability to override the cluster admin username & password for
`sensu-backend init` in Docker.
- UPN binding support has been re-introduced via the `default_upn_domain`
configuration attribute.

### Fixed
- Upgraded the size of the events auto-incremented id in the postgres store.
This allows storing many more events, and also fixes an issue where the
sequence can be exhausted.
- Fixed a bug where the event check state was not present when using the
postgresql event store.
- Agent TLS authentication does not require a license.
- Fixed a bug where OIDC auth tokens were unable to be refreshed in the web app.

## [5.16.1] - 2019-12-18

### Fixed
- Fixed a performance regression that was introduced in 5.15.0, which would
cause the API to timeout past 20k agent sessions.

## [5.16.0] - 2019-12-11

### Added
- [Web] Added ability to authenticate with OIDC.
- Added sensu-backend init.
- Label selectors now match the event's check & entity labels.
- Added `solaris/amd64` to the list of targets we build sensu-agent tarball
releases for.

### Changed
- The entity limit warning message is now displayed less aggressively and the
  warning threshold is proportional to the entity limit.

### Fixed
- Queries with no results return an empty array.
- `agent.yml.example` file shipped with Sensu Agent for Windows packages now
uses DOS-style line endings.
- Fixed a bug where replicators with multiple comma-separated URLs would not connect.

## [5.15.0] - 2019-11-18

### Added
- Added support for federation replicators.
- Added support for the federation cluster registration api.
- MSI & NuGet builds for sensu-cli (sensuctl).
- MSI & NuGet installations now add the bin dir to system PATH on Windows.
- Added a hard entity limiter middleware to restrict PUT/POST for entities
and events if the entity limit has been reached.
- Added a hard agent limiter middleware to restrict new agent websocket
connections if the entity limit has been reached.
- Added API endpoint for /license (DELETE).
- [Web] Added ability to view resources across clusters in the federation.

### Removed
- Removed support for UPN binding without a binding account or anonymous
binding.
- Removed limitd in favor of a simplified EntityLimiter (which uses the
resource cache).

### Changed
- Updated the entity limit middleware headers with context about hard entity limits,
and added headers to warn users if they are approaching the limit (at 75%).
- [Web] Pull new entity limit warning from response headers.
- Decreased the free entity limit from 1000 to 100.

## [5.14.2] - 2019-11-04

### Added
- Added `el/8` to the list of package repositories we upload to.

## [5.14.1] - 2019-10-16

### Fixed
- Fixed a bug where sensuctl would erroneously warn of entity limits for
unlimited licenses.
- Fixed a bug where the `oidc` authentication providers would not be properly
loaded on start-up.

## [5.14.0] - 2019-10-08

### Added
- Added support for mutual TLS authentication between agents and backends.
- Added support for CRL URLs for mTLS authentication.

### Fixed
- sensuctl can now create federation resources.
- sensuctl on Windows can now create postgres resources.
- Fixed a bug where event metrics would be ignored when using the postgres store.

## Changed
- Updated Go version from 1.12.3 to 1.13.1.

## [5.13.2] - 2019-09-19

### Fixed
- Make sure metrics handlers fire when using the PostgreSQL store.

## [5.13.1] - 2019-09-10

### Fixed
- Fixed the `oidc` authentication provider resource.

## [5.13.0] - 2019-09-09

### Added
- Added the `Sensu-Entity-Warning` header for all API requests (via a middleware).
- Added an entity limit warning banner on all tabular `sensuctl list` commands if the
free/license entity limit has been exceeded.
- Added the federation API


### Fixed
- Fixed a bug where silences would not expire on event resolution.

## [5.12.0] - 2019-08-22

### Added
- Added `freebsd/386` and `freebsd/amd64` binary builds for sensu-agent & sensuctl.
- Injects `auth` and `license` as possible `sensuctl dump` options.
- [Web] Added support for virtual fields in the form generator
- Added OIDC authentication provider.
- Added new `sensuctl login` command, with an `oidc` subcommand.

### Changed
- `.tar.gz` and `.zip` releases no longer have `-enterprise` in the name.
- The project now uses Go modules instead of dep for dependency management.
- Updated goreleaser to v0.114.1 & now using import paths for ldflags as required by go modules.
- [Web] Namespace selector now uses user-namespaces endpoint (and the oss endpoint as a backup)

## [5.11.1] - 2019-07-18

### Changed
- Vendor `sensu/sensu-go` @ 79890a9d509ff219af400af2816adcdd4a8c2592

### Fixed
- Fixed access token renewal when UPN format binding was enabled.

## [5.11.0] - 2019-07-10

### Added
- Added `debian/buster` to the list of package repositories we upload to.
- Added support for LDAP UPN authentication (Active Directory only).
- Added support for including nested groups in LDAP group searches (Active Directory only).
- [Web] Allow users to manage (view, create, edit, delete) Event Filter resources via the dashboard.
- [Web] Allow users to manage (view, create, edit, delete) Mutator resources via the dashboard.
- Added /user-namespaces route to deliver a curated list of namespaces the user has access to.

### Fixed
- [Web] Creating a Check or Handler within the same namespace with a duplicate name now throws an error instead updating the existing resource.

### Changed
- Updated goreleaser to v0.112.1 & added support for zip archives.

### Removed
- Removed `el/5` from the list of package repositories we upload to.

## [5.10.2] - 2019-06-27

### Fixed
- Fixed an issue where license expiration could lead to a backend crash

## [5.10.1] - 2019-06-25

### Changed
- Vendor `sensu/sensu-go` @ b2f432747653965c48ea806ee4852cd4916be22f

## [5.10.0] - 2019-06-18

### Added
- Added a `SetNamespace(string)` function to enterprise resources to satisfy the `Resource` interface.
- [Web] Added filtering input fields to each resource (Checks, Entities, Events, Handlers, and Silences).
- Added the postgresql event store.
- [Web] Publish tessen metrics for homepage tile click events.
- [Web] Form generator allows for branching logic and requirements. Uses dependencies/dependants for displaying fields.
- [Web] Form generator no longer sends empty strings/arrays/etc

### Changed
- [Web] Un-licensed users can delete entities
- [Web] Updating the embedded assets no longer requires `node` & `yarn`.

### Fixed
- [Web] Links on the "Incidents Tile" and "Entities Tile" on the dashboard homepage now correctly filter events when navigating to their respective pages.
- [Web] Ensure that editing a resource triggers a refetch of the resource so that the edit dialoque is up-to-date.
- [Web] Normalize empty arrays on form submit, so that creating resources does not cause users to submit empty strings within array fields.
- [Web] Remove recursive defaults when updating a resource to allow users to properly update array field values.
- [Web] Use new filter syntax on homepage; avoids having to filter entire set of events.
- [Web] Set upper limit of events & entities fetched on the homepage from 1k to 100k.
- Allow RBAC rules for license resource be applied
- [Web] Properly reflect current count of keepalives on landing page.

## [5.9.0] - 2019-05-29

### Added
- GraphQL fields that previously accepted JS statements for filtering will now
accept field and label selectors.
- Added a field to the license struct and license generation command that allows
licensed users to opt out of Tessen.
- [Web] Added the ability to create a Handler resource from the dashboard
- Added raw event logging functionality
- [Web] Added the ability to edit or delete a Handler resource from the dashboard.
- Added Ubuntu 19.04 (Disco Dingo) to the list of packagecloud repositories we
upload deb packages to.

### Changed
- Vendor `sensu/sensu-go` @ 5ffdd07
- Vendor `sensu/web` @ SHA a25de7f
- Updated embedded web app assets 612288b...a25de7f

## [5.8.0] - 2019-05-22

### Added
- Added entity limits to the license struct and license generation command.
- Added entity limit banner for limited licenses
- Added a README for the Form Generator

### Changed
- Vendor sensu/web @ SHA e8642b2
- Updated embedded web app assets 87a4066...612288b

## [5.7.0] - 2019-05-09

### Added
- Added LimitD, a backend daemon that collects and maintains a history of the total entity count.
- Added EntityLimiter, an API middleware that appends `Sensu-Entity-Limit` and `Sensu-Entity-Count`
headers to all `/api/core` and `/api/enterprise` responses.
- [Web] Added banner to display entity limit & count, if cluster is over limit.
- Added tooling to produce Windows packages for sensu-agent.

### Changed
Updated the sensu-agent entrypoint to support the changes in sensu-go
related to Windows services.

### Fixed
- The API returns an error message if label and field selectors are used without
a license, instead of ignoring the query parameters.

## [5.6.0] - 2019-04-30

### Fixed
- Fixed incorrect checbox state in header of emtpy list views. (Visual bug)
- Avoid "Failed to fetch" errors on landing page.

### Added
- Added label selector filtering as a licensed feature
- Added field selector filtering as a licensed feature
- Added `--field-selector` and `--label-selector` support to `sensuctl`
- Ability to edit a check
- Ability to create a check
- Ability to delete checks and entities
- Add support for LDAP/AD anonymous binding
- Add support for mutual TLS for the LDAP and AD auth providers

## [5.5.1] - 2019-04-17

### Added
- [Web] form generator for building form
- [Web] initial check form schema

### Changed
- Updated Go version from 1.11.5 to 1.12.3.
- sensu-go updated, contains bugfixes

## [5.5.0] - 2019-04-03

### Changed
- sensu-go updated, contains tessen

## [5.4.0] - 2019-03-27

### Added

- Set up enterprise web-ui app
- Serve enterprise specific dashboard assets.
- [Web] added new homepage

## [5.3.0] - 2019-03-07

### Added
- Added the Active Directory authentication provider.

### Fixed
- DNS resolution in alpine linux containers is now done with the built-in Go
resolver. Previously, the binaries would attempt to use the glibc resolver,
which is not present in MUSL.

## [5.2.1] - 2019-02-11

### Fixed
- Revendored sensu-go to include a fix that addressed a regression in
proxy check execution.

## [5.2.0] - 2019-02-06

### Added
- Added a watcher, as a licensed feature, to manage the list of enabled
providers in the Authenticator.
- Add Debian 8 (jessie) & Debian 9 (stretch) to the platforms we build packages
for.
- Added the LDAP authentication provider.
- Added the `authentication/v2` API group.
- Added a generic store.
- Added a generic CLI client.
- Added a generic API controller.

### Changed
- Use Goreleaser for tarball & binary builds.
- Moved the license API to `licensing/v2` API group.

### Fixed
- Fixed Ubuntu package naming & release version.
- The license is now stored with its signature for validation.

## 5.1.1

### Added
- Added the sensu-license command to generate license files.
- Added a test job in CircleCI.
- Added sensuctl auth command.
- Added support for authentication providers in `sensuctl create`.

### Changed
- Regenerated the private/public keypair for license files.
- Refactoring of the licensing package.
- Updated Go version from 1.10 to 1.11.5.
- Updated sensu-go to d8a8a46e85c9bf24d46858126a21866d40b283ba.

## 5.1.0

### Added
- Add Ubuntu 14.04 (trusty) to the platforms we build packages for.

### Changed
- Updated sensu-go to 3731bcda2c40b39f162675dad0fa269b761e9da5.

### Fixed
- Prevent a panic when using an external etcd cluster.
- Fixed run & log paths in sysvinit scripts for agent & backend.

## 5.0.1

### Changed
- Updated sensu-go to 0150bbc.

## 5.0.0

### Added
- First release of sensu-enterprise-go. Includes sensu-go vendored at a specific
SHA. In the future, sensu-go will be vendored at a tag.
