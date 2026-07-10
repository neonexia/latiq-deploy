# latiq-deploy

Run [Latiq](https://github.com/neonexia/latiq) — an agent-native data system — via
Docker. **No repo clone, two commands:**

```bash
curl -O https://raw.githubusercontent.com/neonexia/latiq-deploy/main/docker-compose.yml
docker compose up -d
```

That starts a control plane + 2 pond nodes behind a gateway, using published
images. Then:

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
  (Or `latiq.connect("local")` for a fully in-process cluster — no docker at all.)

Pin a version: `LATIQ_IMAGE=ghcr.io/neonexia/latiq:<tag> docker compose up -d`.

Stop: `docker compose down`. Wipe data too: `docker compose down -v`.

This compose is generated from the Latiq repo and kept in sync by its release
pipeline. Source: `neonexia/latiq` (`deploy/latiq-compose.yml`).
