## Disaster recovery (DR) notes

This is a simple DR strategy for the stack in this workspace:
- Cloud Run (PHP container)
- Cloud SQL (MySQL)
- GCS (static assets + Terraform state)
- Artifact Registry (container images)
- GitHub Actions (build/deploy)

### What can go wrong
- Region outage (e.g. europe-west3 not reachable)
- Someone deletes / breaks Cloud Run service
- Cloud SQL instance corrupted / deleted
- GCS bucket deleted / objects removed
- Bad deploy (broken container image)

### Backups / recovery sources
- **Cloud SQL**
  - Turn on automated backups
  - Keep a separate “break-glass” admin account for restore operations.
- **Static files**
  - Source of truth is the repo. The bucket is just a cache/copy.
  - If the bucket is deleted, Terraform + the deploy workflow can recreate and re-upload.
- **Container images**
  - Artifact Registry holds versions/tags. Keep a few last known-good tags.
  - If needed, you can redeploy an older tag from the registry.
- **Terraform state**
  - State is stored in GCS. Enable bucket versioning (recommended) so accidental deletes are recoverable.

### DR approach
We treat infra as code and data as the hard part.

#### 1) “Fast rollback” (most common)
If the app is down after a deploy:
- Redeploy last known good image tag to Cloud Run (prod promote workflow can re-run with an older tag).
- If only static assets broke, re-run the static sync step.

#### 2) Recreate service in same region
If Cloud Run service was deleted or misconfigured:
- Run Terraform apply for the environment to recreate the service + LB wiring.
- Redeploy the latest good image.

#### 3) Region-level recovery (bigger incident)
If the whole region is unhealthy:
- Stand up the same Terraform stack in a second region (keep the config ready; this is easier if variables are region-driven).
- Restore Cloud SQL into the new region
- Point DNS at the new load balancer IP

### Minimal runbook
1. Check if it’s a bad deploy:
   - Rollback to a previous container tag.
2. If Cloud Run service is missing:
   - `terraform apply` to recreate infra, then redeploy image.
3. If DB is broken:
   - Restore Cloud SQL from the latest backup (or PITR), update app env vars if endpoints changed.
4. Validate:
   - Hit LB URL/IP and check the health page.

### Production ideas
- Multi-region or active/passive setup for DB (depending on cost/complexity tolerance).
- Cloud SQL tighter backup policy.
- Alerting (uptime checks, error rate, latency) and log-based metrics.
- Separate service accounts/roles per workflow (least privilege).
- Enable bucket versioning for state and critical buckets.
