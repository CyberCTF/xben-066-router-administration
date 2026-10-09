# Upstream

| | |
| --- | --- |
| Project | XBOW validation benchmarks |
| Repository | https://github.com/xbow-engineering/validation-benchmarks |
| Benchmark | `benchmarks/XBEN-066-24` (Router Administration) |
| Version | main (the repository has no releases) |
| Commit | a16cb1ba0701b20d63913846536fc7b0672082af |
| Licence | Apache-2.0 (LICENSE and NOTICE at the repository root, copied here) |

| Here | validation-benchmarks path |
| --- | --- |
| `build/hrs-admin-router/app/` | [`benchmarks/XBEN-066-24`](https://github.com/xbow-engineering/validation-benchmarks/tree/a16cb1ba0701b20d63913846536fc7b0672082af/benchmarks/XBEN-066-24) except `haproxy/` |
| `build/haproxy/app/` | [`benchmarks/XBEN-066-24/haproxy`](https://github.com/xbow-engineering/validation-benchmarks/tree/a16cb1ba0701b20d63913846536fc7b0672082af/benchmarks/XBEN-066-24/haproxy) |

The vendored folder is that commit's benchmark folder, unchanged, without its Git history, canary
strings included. The flag is the one upstream's Makefile builds with (`common.mk`: `FLAG{` + the
SHA-256 of `XBEN-066-24` + `}`), passed there as the `FLAG` build argument; Isoloom builds without build
arguments, so the overlay `build/hrs-admin-router/Dockerfile` (the benchmark's `app/Dockerfile`, its COPY sources
pointed into `app/`) makes that value the argument's default.

The other machines:

- `db`: `build/db/Dockerfile` (see its header comment).
- `haproxy`: the benchmark's `haproxy/` folder is vendored unchanged in `build/haproxy/app/` (moved out of `build/hrs-admin-router/app/`, as its overlay `build/haproxy/Dockerfile` needs it in its build context; see the header comment).
- `mitmproxy`: `build/mitmproxy/Dockerfile` (see its header comment).

To update, replace the vendored folder with a newer commit's benchmark folder, then change this file.
