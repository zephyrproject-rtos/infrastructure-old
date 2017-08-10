Zephyr Infrastructure
#####################

The Zephyr project uses the shippable CI infrastructure for CI and deployment
of code, documentation and release deployment. For detailed information about
the CI system visit http://docs.shippable.com/.

In the Zephyr project, the following repositories are used for creating the
overall CI infrastructure:

Pipelines: https://github.com/zephyrproject-rtos/ci-pipelines
  Used to define shippable jobs and resources and integrations.

Docker Files: https://github.com/zephyrproject-rtos/ci-dockerfiles
  Used for build a Zephyr specific Docker image that can be used as the baseline
  for all CI jobs. This docker image has all needed Zephyr dependencies
  including SDK.

CI Tests: https://github.com/zephyrproject-rtos/ci-test
  Used for daily CI builds that have full coverage (build and run).


The core of the CI system is the shippable.yml configuration available in every
project to be tested in the CI system. The file defines the environment and has
the needed scripting to run the Zephyr tests.

