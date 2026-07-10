# latiq-deploy

Run [Latiq](https://github.com/neonexia/latiq) — an agent-native data system — via
Docker **or** Podman. **No repo clone, two commands:**

```bash
curl -O https://raw.githubusercontent.com/neonexia/latiq-deploy/main/docker-compose.yml
docker compose up -d          # or:  podman compose up -d
```

Same published images, same topology (control plane + 2 pond nodes + a gateway),
either runtime — the compose is pure images + ports, no local files. Then:

- **Agents (MCP, no SDK):** point any MCP client at `http://localhost:51510/mcp`.
- **Programs (Python SDK):**
  ```bash
  pip install latiq
  ```
  ```python
  import latiq
  db = latiq.connect("grpc://localhost:51400", query_gateway="grpc://localhost:51500")
  work = db.create_pond(name="work")
  work.query(sql="CREATE TABLE t AS SELECT 42 AS n")
  print(work.query(sql="SELECT * FROM t").to_pandas())
  ```
  (Or `latiq.connect("local")` for a fully in-process cluster — no containers at all.)

Pin versions: `LATIQ_IMAGE=ghcr.io/neonexia/latiq:<tag> LATIQ_GATEWAY_IMAGE=ghcr.io/neonexia/latiq-gateway:<tag> docker compose up -d`.

Stop: `docker compose down` (add `-v` to wipe pond data).

This compose is generated from the Latiq repo and kept in sync by its release
pipeline. Source: `neonexia/latiq` (`deploy/latiq-compose.yml`).
