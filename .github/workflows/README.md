# HTML Party App

A fun web application with interactive party effects.

## CI/CD Pipeline

### CI Pipeline (Continuous Integration)
- Triggered on every push to the main branch
- Steps:
  1. Checkout code
  2. List files for debugging
  3. Basic HTML validation
  4. Create deployment package (zip file)
  5. Upload artifact for CD pipeline

### CD Pipeline (Continuous Deployment)
- Triggered after successful CI completion
- Runs on self-hosted runner
- Steps:
  1. Download artifact from CI pipeline
  2. Unzip to deployment directory
  3. Set proper permissions
  4. Configure nginx
  5. Restart nginx web server
  6. Verify deployment

## How to Run
1. The application is automatically deployed to the server after pushing to main
2. Access via http://your-server-ip
