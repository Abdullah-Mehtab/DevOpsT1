# DevOpsT1

## Project
Simple static site hosting for `public/index.html`.

## CI (Continuous Integration)
- Workflow: `.github/workflows/ci.yml`
- Trigger: `push` to branch `main`.
- Steps:
  - install `tidy` HTML validator
  - run `tidy -qe public/index.html`
  - run custom script `ci-scripts/check_index.sh`
  - build zip artifact `deploy.zip`
  - upload artifact as `deploy-artifact`

## CD (Continuous Deployment)
- Workflow: `.github/workflows/cd.yml`
- Trigger: `workflow_run` (fires after CI `CI Pipeline` completes successfully)
- Runs on: **self-hosted runner** (label: `self-hosted`, `linux`, `x64`)
- Steps:
  - download artifact via `actions/download-artifact`
  - unpack artifact and copy to `DEPLOY_DIR` (set in workflow env)
  - restart nginx and verify with `curl`

## How to run locally
1. Ensure nginx installed and started: `sudo apt install -y nginx && sudo systemctl enable --now nginx`
2. Move your index to `public/index.html`, `git add/commit/push`.
3. Check CI logs on GitHub Actions.
4. Setup self-hosted runner on the machine where you want to run CD (see repo settings -> Actions -> Runners).

## Notes
- Self-hosted runner must be registered under repo `DevOpsT1` and be online to pick up CD jobs.
- Runner must have permissions to write to deploy folder and restart nginx (we used a restricted sudoers file for `systemctl restart nginx`).
