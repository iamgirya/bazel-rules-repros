# Bazel rules repros

Minimal repros for bugs in Bazel rules that I report upstream. Each directory is a
standalone Bazel module with its own `README.md` and `run.sh`; run it from that directory.

| Repro | Rules | Upstream |
| --- | --- | --- |
| [`registry_patches_ignored`](rules_swift_package_manager/registry_patches_ignored) | rules_swift_package_manager | `configure_package` patches are ignored for registry packages |
