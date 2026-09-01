# latiq-deploy — moved

**Latiq is now open source (Apache 2.0), and its deployment artifacts live in the
main repository:**

### → https://github.com/neonexia/latiq/tree/main/deploy

This repo existed only because `neonexia/latiq` used to be private and you could
not fetch a compose file from it. That is no longer the case. **Everything here is
frozen and will not be updated.**

## Run Latiq

No clone needed — published images, Docker or Podman:

```sh
curl -O https://raw.githubusercontent.com/neonexia/latiq/main/deploy/docker-compose.yml
docker compose up -d          # or: podman compose up -d
```

Admin CLI:

```sh
curl -fsSL https://raw.githubusercontent.com/neonexia/latiq/main/deploy/install.sh | sh
```

Embedded, in Python:

```sh
pip install latiq
```

Start here for the full picture, including the multi-node cluster and the
Iceberg/MinIO fixture:
**https://github.com/neonexia/latiq/blob/main/deploy/README.md**

## About the files still in this repo

`docker-compose.yml` and `install.sh` are kept so existing links and bookmarks
keep working. They are snapshots taken at **latiq v0.1.0** and both now point at
`neonexia/latiq` for images and release assets, so they still function — but they
will not receive fixes. Use the links above instead.

The `cli-latest` release on this repo also stays published, so CLI installers
downloaded before the move keep resolving. New installs get their binaries from
[`neonexia/latiq`](https://github.com/neonexia/latiq/releases).
