# DevOpsT1 - Multi-Application Hosting Platform

A complete CI/CD pipeline implementation for hosting multiple web applications on a single Ubuntu server with automated deployment using GitHub Actions.

## 🚀 Applications Hosted (LOCALLY)

- **React App** (`xyz.com/react`) - Modern Vite React application
- **Python Flask App** (`xyz.com`) - Number guessing game API
- **WordPress Site** (`abc.com`) - CMS with automated config deployment
- **Static HTML App** (Port 6969) - Legacy application

## 📁 Project Structure

```
DevOpsT1/
├── .github/workflows/          # CI/CD pipelines
├── apps/
│   ├── reactapp/               # React application source
│   ├── pythonapp/              # Flask application + tests
│   └── wordpress/              # WordPress config template
├── configs/
│   ├── nginx/                  # Nginx server configurations
│   └── systemd/                # Systemd service files
└── public/                     # Static HTML app
```

## 🔧 CI/CD Pipelines

### React Application
- **CI Workflow**: `.github/workflows/react-ci.yml`
  - Trigger: push to main branch when changes in `apps/reactapp/**`
  - Steps:
    - Setup Node.js
    - Install dependencies with `npm install`
    - Build application with `npm run build`
    - Create artifact `react-build.zip`
    - Upload artifact as `react-artifact`

- **CD Workflow**: `.github/workflows/react-cd.yml`
  - Trigger: workflow_run after successful React CI completion
  - Runs on: self-hosted runner (labels: self-hosted, linux, x64)
  - Steps:
    - Download artifact using PAT authentication
    - Extract and deploy to `/var/www/reactapp/dist/` using rsync
    - Set proper ownership (`www-data:www-data`)
    - Deploy Nginx config and reload service

### Python Flask Application
- **CI Workflow**: `.github/workflows/python-ci.yml`
  - Trigger: push to main branch when changes in `apps/pythonapp/**`
  - Steps:
    - Setup Python
    - Install dependencies with `pip install -r requirements.txt`
    - Run tests with `pytest`
    - Create artifact `python-app.zip`
    - Upload artifact as `python-artifact`

- **CD Workflow**: `.github/workflows/python-cd.yml`
  - Trigger: workflow_run after successful Python CI completion
  - Runs on: self-hosted runner
  - Steps:
    - Download artifact using PAT authentication
    - Extract and deploy to `/var/www/pythonapp/`
    - Manage virtual environment and install dependencies
    - Set proper ownership and permissions
    - Restart `pythonapp` systemd service
    - Deploy Nginx config and reload service

### WordPress Application
- **CI Workflow**: `.github/workflows/wordpress-ci.yml`
  - Trigger: push to main branch when changes in `apps/wordpress/**`
  - Steps:
    - Validate `wp-config.php.template` contains required placeholders
    - Create artifact `wordpress-config.zip`
    - Upload artifact as `wordpress-artifact`

- **CD Workflow**: `.github/workflows/wordpress-cd.yml`
  - Trigger: workflow_run after successful WordPress CI completion
  - Runs on: self-hosted runner
  - Steps:
    - Download artifact using PAT authentication
    - Generate `wp-config.php` from template with GitHub Secrets
    - Deploy config to `/var/www/wordpress/`
    - Set secure file permissions
    - Deploy Nginx config and reload services (Nginx + PHP-FPM)

### Static HTML App
- **CI Workflow**: `.github/workflows/html-ci.yml`
  - Trigger: push to main branch when changes in `public/**`
  - Steps:
    - Validate HTML with tidy validator
    - Run custom validation script
    - Create artifact `deploy.zip`
    - Upload artifact as `deploy-artifact`

- **CD Workflow**: `.github/workflows/html-cd.yml`
  - Trigger: workflow_run after successful HTML CI completion
  - Runs on: self-hosted runner
  - Steps:
    - Download artifact using PAT authentication
    - Extract and deploy to `/var/www/devopst1/` using rsync
    - Set proper ownership
    - Restart Nginx and verify deployment

## ⚙️ Setup Requirements

### Server Environment
- Ubuntu server with self-hosted GitHub Actions runner
- Nginx, MySQL, PHP-FPM, Python, Node.js installed
- Passwordless sudo configured for deployment commands

### GitHub Secrets
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST` - WordPress database
- `PAT` - Personal Access Token for artifacts

## 🚦 How to Run

### Development
1. Clone the repository:
```bash
git clone git@github.com:Abdullah-Mehtab/DevOpsT1.git
cd DevOpsT1
```

2. Make changes to application code in respective `apps/` directories

3. Commit and push changes:
```bash
git pull origin main
git add .
git commit -m "Description of changes"
git push origin main
```

### Automated Deployment
Pushing to main branch automatically triggers the appropriate CI/CD pipeline based on changed paths.

## 📊 Monitoring

All pipeline runs are logged in GitHub Actions with detailed execution logs and status notifications.

## 🔗 Links

- **GitHub Repository**: https://github.com/Abdullah-Mehtab/DevOpsT1
- **Live Applications**: 
  - WordPress: abc.com
  - Python/React: xyz.com
  - HTML App: port 6969

---

**Maintained by Abdullah Mehtab** - [GitHub](https://github.com/Abdullah-Mehtab) | [Email](mailto:abdullahmehtab666@gmail.com)
