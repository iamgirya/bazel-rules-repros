# Bazel rules repros

Minimal repros for bugs in Bazel rules that I report upstream. Each directory is a
standalone Bazel module with its own `README.md` and `run.sh`; run it from that directory.

| Repro | Rules | Upstream |
| --- | --- | --- |
| [`registry_patches_ignored`](rules_swift_package_manager/registry_patches_ignored) | rules_swift_package_manager | [#2704](https://github.com/cgrindel/rules_swift_package_manager/issues/2704) `configure_package` patches are ignored for registry packages |
| [`excluded_files_not_included`](rules_swift_package_manager/excluded_files_not_included) | rules_swift_package_manager | Excluded files of a C target are missing from the build |
