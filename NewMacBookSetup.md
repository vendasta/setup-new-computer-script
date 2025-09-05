# New MacBook Setup Guide

> **Updated for setup script v4.7.0** - Now includes Anaconda for Python development!

---

## 🚀 Quick Start

### 1. Run the Automated Setup Script

The setup script now handles most development tools automatically with **proper order of operations**:

```bash
chmod +x ./setup-new-computer.sh
./setup-new-computer.sh
```

### 🎨 **NEW: Customizable ASCII Logo**
When you run the script, you'll be prompted to enter custom text for the ASCII logo:
- **Enter any word/phrase** - Your custom text will be displayed in ASCII art  
- **Press ENTER** - Uses the default "vendasta" logo
- **Uses figlet** - Professional ASCII art generation (installed automatically)

**Examples:**
- Company name: "ACME Corp"
- Your name: "John Doe" 
- Project name: "Setup 2024"

### 🚦 **Script Execution Order:**
1. **🎨 Custom ASCII Logo** - Personalize your setup experience
2. **🛠️ Xcode CLI Tools** - Essential foundation for all development
3. **🔐 SSH Key Setup** - GitHub authentication configured early  
4. **🐚 Shell Configuration** - Oh My Zsh and profiles
5. **🍺 Homebrew** - Package manager installation
6. **⚡ Enhanced CLI Tools** - Modern utilities for improved productivity
7. **📦 All Development Tools** - Languages, IDEs, databases, etc.

### 2. What the Script Installs

The script now automatically installs:

#### 🛠️ **Development Tools**
- **Languages**: Go, Node.js (via NVM), Python, Rust, Java (OpenJDK), TypeScript
- **Package Managers**: npm, yarn, pnpm, poetry, pipenv, pipx
- **Version Control**: Git, Git LFS, tig, lazygit, GitHub CLI
- **IDEs**: VS Code, JetBrains Toolbox, PyCharm, GoLand, WebStorm, Sublime Text, Cursor
- **Go Tools**: golangci-lint, delve (debugger), goimports
- **Python Tools**: pyenv, black, isort, flake8, mypy (type checking)
- **TypeScript Tools**: ts-node, ESLint, Prettier, nodemon

#### 🌐 **Browsers**
- Google Chrome, Firefox, Chromium, Brave Browser

#### ☁️ **DevOps & Infrastructure**
- **Containers**: Docker Desktop, Kubernetes (kubectl, k9s, helm)
- Google Cloud SDK, Terraform, Ansible
- **API Testing**: Postman, Insomnia

#### 🎯 **Productivity Applications**
- **Window Management**: Rectangle
- **System Monitoring**: Stats
- **Communication**: Slack  
- **Organization**: Notion, Itsycal
- **AI Assistant**: ChatGPT
- **Launcher**: Alfred 5
- **Hardware**: Logi Options+ (Logitech peripherals)
- **Utilities**: Gitify, Enpass, Meld

#### 🐚 **Enhanced Command Line**
- **Shell**: Oh My Zsh with Powerlevel10k theme and plugins (syntax highlighting, autosuggestions, completions)
- **Modern CLI Tools**: bat, fd, ripgrep, fzf, tree, htop
- **Terminal Management**: tmux (multiplexer), tmuxinator (session manager)
- **Editors**: vim (enhanced)
- **ASCII Art**: figlet (customizable text banners)
- **Utilities**: jq, colordiff, wget, tldr, autojump

#### 🗄️ **Database Tools**
- **CLI Tools**: PostgreSQL client, Redis, MongoDB tools
- **GUI Applications**: DBeaver, RedisInsight, MongoDB Compass, TablePlus

---

## 📋 Manual Setup Required

### ✅ SSH Key Setup for GitHub (Now Automated!)

The script now **automatically generates and configures SSH keys** as the **second step** (right after Xcode CLI tools):

- ✅ **RUNS EARLY** - SSH setup happens before any Git operations
- ✅ Generates Ed25519 SSH key using your provided email
- ✅ Creates SSH config file automatically
- ✅ Adds key to SSH agent with keychain integration  
- ✅ Copies public key to clipboard
- ✅ Provides step-by-step instructions to add to GitHub
- ✅ Tests the SSH connection before continuing

**During script execution**, you'll be prompted to:
1. Provide your email for the SSH key
2. Add the key to GitHub (key is auto-copied to clipboard)
3. Visit: https://github.com/settings/ssh/new
4. Paste and save the key
5. Confirm completion before script continues

**Manual verification** (if needed):
```bash
# Test SSH connection
ssh -T git@github.com

# View your public key
cat ~/.ssh/id_ed25519.pub
```

---

## 🏢 Vendasta-Specific Setup

### Essential Tools (Automated)
- ✅ Go with GOPRIVATE configuration
- ✅ **Go Development Tools**: goimports, golangci-lint, air (live reload), delve (debugger)
- ✅ Vendasta CodeGen

### Manual Vendasta Setup

#### 1. Libpostal (for Web-Crawler)
```bash
git clone https://github.com/openvenues/libpostal
cd libpostal
./bootstrap.sh

# For M1 Macs, add --disable-sse2 flag
./configure --datadir=/Users/$(whoami)/go/src/github.com/vendasta/libpostal_data --disable-sse2

make -j4
sudo make install
```

#### 2. mscli Setup
```bash
cd your-projects-folder
git clone https://github.com/vendasta/mscli
cd mscli
git checkout master
git pull
go install -mod=vendor
```

#### 3. Google Cloud Authentication
```bash
# Required for E2E tests
gcloud auth application-default login
```

#### 4. Web-Crawler Environment
- GoLand: Set `ENVIRONMENT=demo` for local runs
- E2E tests: No `ENVIRONMENT` variable needed

---

## 🎨 Terminal & Shell Customization

### iTerm2 Color Schemes (Optional)
```bash
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git
cd iTerm2-Color-Schemes
tools/import-scheme.sh schemes/*
```

### Oh My Zsh Configuration

The script installs Oh My Zsh, Powerlevel10k theme, and essential plugins. After installation:

#### 1. Set Theme in `~/.zshrc`:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

#### 2. Configure Plugins in `~/.zshrc`:
```bash
plugins=(
  git
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  fzf
  web-search
  sudo
  jsontools
  docker
  history-search-multi-word
)
```

#### 3. Configure Powerlevel10k:
```bash
# Run the configuration wizard
p10k configure
```

#### 4. Add autojump integration (if not already present):
```bash
# Add to ~/.zshrc
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
```

### 🐍 **Anaconda: Complete Python Data Science Platform**

The script installs [Anaconda](https://www.anaconda.com/), a comprehensive Python distribution for data science and machine learning:

#### **What's Included:**
- **🐍 Python 3** - Latest stable Python with 1500+ pre-installed packages
- **📊 Jupyter Ecosystem** - Jupyter Notebook & JupyterLab for interactive computing
- **🔬 Spyder IDE** - Scientific Python development environment
- **📦 conda** - Package and environment manager
- **📈 Data Science Libraries** - pandas, numpy, matplotlib, scikit-learn, scipy, and more

#### **Manual Setup Required:**
After installation, add Anaconda to your PATH by adding one of these lines to your shell profile:

```bash
# For Apple Silicon Macs (M1/M2/M3)
export PATH="/opt/homebrew/anaconda3/bin:$PATH"

# For Intel Macs
export PATH="/usr/local/anaconda3/bin:$PATH"
```

#### **Getting Started:**
```bash
# Verify installation
conda --version
python --version

# Create a new environment
conda create -n myproject python=3.11

# Activate environment  
conda activate myproject

# Launch Jupyter Lab
jupyter lab
```

---

## 📱 Additional Applications (Optional)

### Productivity Tools (Not in Script)
- [ ] **Hidden Bar** - Menu bar organization
- [ ] **TopNotch** - Notch hider
- [ ] **WebCatalog** - Web app wrapper
  - Excalidraw, Google Chat, Jira, Confluence, Gmail
- [ ] **Calibre** - Ebook management
- [ ] **IrirunWebCam** - Use phone as webcam
- [ ] **TexMaker** - LaTeX editor
- [ ] **VLC** - Media player

### Development Tools (Advanced)
- [ ] **Nerd Fonts** - Enhanced terminal fonts
- [ ] **Anaconda** - Python data science
- [ ] **JupyterLab** - Interactive computing

---

## 🔧 Post-Installation Configuration

### 1. Restart Terminal
Open a new terminal window to load all new PATH configurations.

### 2. Verify Installations
```bash
# Check key tools
node --version
go version
python3 --version
git --version

# Test CLI tools
bat --version
fzf --version

# Test Anaconda
conda --version
jupyter --version
python --version
```

### 3. Configure Git (if not done by script)
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 4. Install Global npm Packages (if needed)
The script installs essential ones, but you might want additional:
```bash
npm install -g typescript eslint prettier
```

---

## 🚨 IMPORTANT: Shell Configuration Protection

### 🛡️ Automatic Backup System (v4.4.1+)

The script now **automatically backs up** all your shell configuration files before making any changes:
- `~/.bashrc` → `~/.bashrc.backup.TIMESTAMP`
- `~/.bash_profile` → `~/.bash_profile.backup.TIMESTAMP`  
- `~/.zshrc` → `~/.zshrc.backup.TIMESTAMP`
- `~/.zprofile` → `~/.zprofile.backup.TIMESTAMP`

### 🔧 Oh My Zsh Configuration Recovery

If you ran an **older version** of the script and lost your `.zshrc` configuration:

1. **Check for backups:**
   ```bash
   ls -la ~/.zshrc.backup.*
   ```

2. **Restore from backup:**
   ```bash
   # Find your most recent backup
   cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
   ```

3. **Manual recovery from your original setup:**
   - Look for your previous configurations in your backup files
   - The Google Cloud SDK lines should be in `~/.zprofile`, not `~/.zshrc`
   - Your personal aliases, functions, and exports can be re-added manually

---

## 🐛 Troubleshooting

### Common Issues

#### Java Not Found
The script installs OpenJDK, but you may need to set JAVA_HOME:
```bash
echo 'export JAVA_HOME=$(/usr/libexec/java_home)' >> ~/.zprofile
```

#### M1 Mac Build Issues
For native tools that don't support ARM64:
```bash
# Use Rosetta 2 for Intel compatibility
arch -x86_64 brew install package-name
```

#### Oh My Zsh Plugins Not Working
Ensure plugins are listed in `~/.zshrc` and restart terminal.

---

## 📚 Documentation Links

- [Setup Script Repository](https://github.com/vendasta/setup-new-computer-script)
- [Vendasta mscli](https://github.com/vendasta/mscli/blob/master/README.md#sdk-generation)
- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Oh My Zsh](https://ohmyz.sh/)
- [Homebrew](https://brew.sh/)

---

## ✅ Backup Checklist

Before running setup on a new machine:

- [ ] **Books** - Export/sync reading library
- [ ] **Dotfiles** - Backup shell configurations
- [ ] **SSH Keys** - Backup ~/.ssh directory
- [ ] **Application Settings** - Export configs from key apps
- [ ] **Development Projects** - Ensure all code is pushed to Git
- [ ] **Browser Data** - Sync bookmarks and extensions

---

*Last updated: January 2024 - Setup Script v4.7.0*