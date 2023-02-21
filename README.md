# Setup a New Developer Computer
This script will help with the quick setup and installation of tools and applications for new developers at Vendasta. Tested in Mac OS 10.14 to 12. This script works on both Intel and M1/M2 Macs. 

You can run this script multiple times without issue. You can also run it on a partially set-up computer and it will only install what is missing.

The script will create/modify `.bash_profile` and `.zprofile` with path and autocomplete sources. If you do run it on an already set-up computer, please check these files for any duplicated paths/imports/etc.

<br>

Looking to use this script at your own company? Check out the [tips for using the script at your own company](#tips-for-using-the-script-at-your-own-company) section.

<br>

## Quick Install Instructions

Paste the command below in a Mac OS Terminal:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/vendasta/setup-new-computer-script/master/setup-new-computer.sh)"
```

## Manual Install Instructions

* Download the script `setup-new-computer.sh` to your home folder
* Open Terminal and navigate to where you saved it
* Make the script executable:
   ```sh
   chmod +x ./setup-new-computer.sh
   ```
* Run the script:
   ```sh
   ./setup-new-computer.sh
   ```

* Some installs will need your password
* You will be prompted to fill out your git email and name. Use the email and name you use for Github


<br><br>


## Post Installation Instructions
After you have run the script, please complete the following steps to finish setting up your computers:

   
1. **Github Command-line SSH Authentication**\
   Git is now configured to use SSH by default for github urls. You will need to generate and add an SSH key to your Github account or you will run into errors. Do the following to authorize Github on your computer:
   - [Generate an SSH key for your new computer][generate key]
   - [Add the SSH public key to your Github account][add to github]
     
   [generate key]: https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
   [add to github]: https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
   
   <br>

2. **Vendasta specific tools**\
   Follow our onboarding document to complete your setup:
   - [Onboarding New Developers - Setup New Developer’s Computer - Next Steps][nextsteps]
   
   [nextsteps]: https://vendasta.jira.com/wiki/spaces/RD/pages/199032984/Onboarding+New+Developers#New-Dev%5BhardBreak%5DSetup-New-Developer%E2%80%99s-Computer-with-a-script

<br><br>


## Post Installation Tips

**Fix ZSH Errors**\
If you are using ZSH as your shell (default in newer Mac OS versions) you may get this error after running the setup script:
 
> zsh compinit: insecure directories, run compaudit for list.\
> Ignore insecure directories and continue [y] or abort compinit [n]?

You can fix this by running the following command in your terminal:
```sh
compaudit | xargs chmod g-w
```

<br>

**Setting Up Pycharm with Python 2.7**\
As Mac OS has recently removed the bundled copy of Python 2.7, please see [this help document on working with our Legacy Appengine projects](https://vendasta.jira.com/wiki/spaces/RD/pages/1688469847/Pycharm+Setup+for+Legacy+Appengine+Python+2.7)

<br>


**Installing Node versions**\
Use nvm to install and upgrade different versions of Node. [Official docs][nvm docs] \
We use the Node v18 at Vendasta.
```sh
# Install the latest version of Node 18 with NPM
nvm install 18

# Install a specific version of Node
nvm install 14      # or 10.10.0, 8.9.1, etc
```

<br>

**Upgrading Node and NPM**\
There is a handy command in your `.bash_profile` and `.zsh_profile` that will automatically upgrade to the latest version of Node 18 and NPM, plus it will re-install any global packages you have installed so you do not have to manually do it each time. Read more about it [here](https://vendasta.jira.com/wiki/spaces/RD/pages/212172883/Tips+and+Tricks#Easily-Update-Node-and-NPM-(using-NVM)-Terminal)
```sh
node-upgrade 18        # update node 18 and reinstall all global packages
```

<br>

**Switching Node Versions**\
Use nvm to switch between installed versions of Node. [Official docs][nvm docs]
```sh
# To switch to the latest Node
nvm use node        # "node" is an alias for the latest version

# Switch to long term support (lts) version of Node
nvm use --lts
 
# To switch to a specific verison of Node
nvm use 11          # or 10.10.0, 8.9.1, etc
```

[nvm docs]: https://github.com/nvm-sh/nvm/blob/master/README.md#usage

<br>
  
**Keeping your tools up-to-date**\
Homebrew can keep your command-line tools and languages up-to-date.
```sh
# List what needs to be updated
brew update
brew outdated
 
# Upgrade a specific app/formula (example: git)
brew upgrade git

# Upgrade everything
brew upgrade
  
# List previous versions installed (example: git)
brew switch git list
 
# Roll back to a currently installed previous version (example: git 2.25.0)
brew switch git 2.25.0
```


<br>
<br>

---
## What's Installed

### Shell Profile Setup (Bash and Zsh)
<details>
  <summary>.bash_profile</summary>
  The following will be added to your ~/.bash_profile
	
   ```sh
# --------------------------------------------------------------------
# Begin Bash autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------

# Supress "Bash no longer supported" message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Start Homebrew
if [[ "$(uname -p)" == "arm" ]]; then
    # Apple Silicon M1/M2 Macs
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel Macs
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Bash Autocompletion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# Google Cloud SDK
[ -e "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ] && 
	source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
[ -e "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ] && 
	source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# Golang
export GOPRIVATE="github.com/vendasta"
export GOPROXY="direct"
export GO111MODULE="on"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# NVM
# This needs to be after "Setting up Path for Homebrew" to override Homebrew Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node
# Increases the default memory limit for Node, so larger Anglar prjects can be built
export NODE_OPTIONS=--max_old_space_size=12000

# Update Node to selected version and reinstall previous packages
node-upgrade() {
    new_version=${1:?"Please specify a version to upgrade to. Example: node-upgrade 18"}
    prev_ver=$(nvm current)
    nvm install "$new_version"
    nvm reinstall-packages "$prev_ver"
    nvm alias default "$new_version"
    # nvm uninstall "$prev_ver"
    nvm cache clear
}

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------
   ```
</details>

<details>
  <summary>.zprofile</summary>
  The following will be added to your ~/.zprofile
	
   ```sh
# --------------------------------------------------------------------
# Begin ZSH autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------

# Start Homebrew
if [[ "$(uname -p)" == "arm" ]]; then
    # Apple Silicon M1/M2 Macs
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel Macs
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Brew Autocompletion
if type brew &>/dev/null; then
    fpath+=$(brew --prefix)/share/zsh/site-functions
fi

# Zsh Autocompletion
# Note: must run after Brew Autocompletion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
fpath=(/usr/local/share/zsh-completions $fpath)

# Google Cloud SDK
[ -e "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ] &&     source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
[ -e "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ] &&     source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Golang
export GOPRIVATE="github.com/vendasta"
export GOPROXY="direct"
export GO111MODULE="on"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# NVM 
# This needs to be after "Setting up Path for Homebrew" to override Homebrew Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] &&     source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] &&     source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node
# Increases the default memory limit for Node, so larger Anglar prjects can be built
export NODE_OPTIONS=--max_old_space_size=12000

# Update Node to selected version and reinstall previous packages
node-upgrade() {
    readonly new_version=${1:?"Please specify a version to upgrade to. Example: node-upgrade 18"}
    prev_ver=$(nvm current)
    nvm install "$new_version"
    nvm reinstall-packages "$prev_ver"
    nvm alias default "$new_version"
    # nvm uninstall "$prev_ver"
    nvm cache clear
}

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------
   ```
</details>


### Command-line tools and languages
<details>
  <summary>Xcode CLI Development Tools</summary>
  
   ```sh
   xcode-select --install
   ```
</details>


<details>
  <summary>Homebrew (brew)</summary>
  
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
   # Fix brew insecure directories warning (zsh)
   chmod go-w "$(brew --prefix)/share"
   ```
</details>


<details>
  <summary>Bash (with Bash Completions)</summary>
  
   ```sh
   brew install bash
   brew install bash-completion
   ```
</details>


<details>
  <summary>Zsh Completions</summary>
  
   ```sh
   brew install zsh-completions
   ```
</details>


<details>
  <summary>Git</summary>
  
   ```sh
   brew install git
   ```
</details>

 
 
 ### Languages
 <details>
  <summary>Go</summary>
  
   ```sh
   mkdir -p ~/go
   brew install go
   go env -w GOPRIVATE="github.com/vendasta"
   ```
</details>


<details>
  <summary>Node (from nvm, with npm, nx, husky, Angular CLI, Node-Sass, and Node-Gyp)</summary>
  
```sh
getLastestNVM() {
    # From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
    # Get latest release from GitHub api | Get tag line | Pluck JSON value
    curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | 
        grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/'
}
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(getLastestNVM)/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 18
npm install --location=global @angular/cli
npm install --location=global nx
npm install --location=global husky
npm install --location=global node-sass
npm install --location=global node-gyp
```
  We will also create a new file called `~/.huskyrc` and fill it with:
```
# --------------------------------------------------------------------
# Begin Husky autogenerated content from setup-new-computer.sh   vX
# --------------------------------------------------------------------

# This loads nvm.sh and sets the correct PATH before running hook

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
   

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   vX
# --------------------------------------------------------------------

```
  
</details>


<details>
  <summary>Ruby</summary>
  
```sh
brew install ruby
```
</details>
	   

<details>
  <summary>Google Cloud Components</summary>
  
```sh
brew install --cask google-cloud-sdk
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
if [ -e ~/google-cloud-sdk ]; then
    echo "✔ ~/google-cloud-sdk exists. Skipping"
else
    echo "✔ Creating ~/google-cloud-sdk symlink"
    ln -s "$(brew --prefix)/Caskroom/google-cloud-sdk" ~/google-cloud-sdk &>/dev/null
    # make a convenience symlink at the install path for google-cloud-sdk when installed manually
fi
gcloud components install app-engine-go --quiet
gcloud components install app-engine-python --quiet
gcloud components install app-engine-python-extras --quiet
gcloud components install kubectl --quiet
gcloud components install docker-credential-gcr --quiet
```
</details>


### Applications

<details>
  <summary>Slack</summary>
  
```sh
brew install --cask slack
```
</details>


<details>
  <summary>Firefox</summary>
  
```sh
brew install --cask firefox
```
</details>


<details>
  <summary>Google Chrome</summary>
  
```sh
brew install --cask google-chrome
```
</details>


<details>
  <summary>Docker for Mac</summary>

```sh
brew install --cask docker
```
</details>


<details>
  <summary>Postman</summary>

```sh
brew install --cask postman
```
</details>


### Optional IDEs and Tools

<details>
  <summary>Visual Studio Code</summary>
  
```sh
brew install --cask visual-studio-code
```
</details>


<details>
  <summary>Jetbrains Toolbox</summary>
  
```sh
brew install --cask jetbrains-toolbox
```
</details>


<details>
  <summary>Pycharm</summary>
  
```sh
brew install --cask pycharm
```
</details>


<details>
  <summary>Goland</summary>
  
```sh
brew install --cask goland
```
</details>


<details>
  <summary>WebStorm</summary>
  
```sh
brew install --cask webstorm
```
</details>


<details>
  <summary>Sublime Text</summary>
  
```sh
brew install --cask sublime-text
```
</details>


<details>
  <summary>iTerm2</summary>
  
```sh
brew install --cask iterm2
```
</details>


### System Tweaks

<details>
  <summary>General: Expand save and print panel by default</summary>
  
```sh
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
```
</details>

<details>
  <summary>General: Save to disk (not to iCloud) by default</summary>
  
```sh
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
```
</details>

<details>
  <summary>General: Avoid creating .DS_Store files on network volumes</summary>
  
```sh
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
```
</details>

<details>
  <summary>Typing: Disable smart quotes and dashes as they cause problems when typing code</summary>
  
```sh
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
```
</details>

<details>
  <summary>Typing: Disable press-and-hold for keys in favor of key repeat</summary>
  
```sh
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```
</details>

<details>
  <summary>Finder: Show status bar and path bar</summary>
  
```sh
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true	
```
</details>

<details>
  <summary>Finder: Disable the warning when changing a file extension</summary>
  
```sh
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
```
</details>

<details>
  <summary>Finder: Show the ~/Library folder</summary>
  
```sh
chflags nohidden ~/Library
```
</details>

<details>
  <summary>Safari: Enable Safari’s Developer Settings</summary>
  
```sh
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
```
</details>

<details>
  <summary>Chrome: Disable the all too sensitive backswipe on Trackpads and Magic Mice</summary>

```sh
# Note: The chrome defaults can cause your Chrome browser to display a message stating
# that Chrome is "Managed by your organization" when it isn't
# 
# To view policies that are affecting this message, view the following pages:
# chrome://policy and chrome://management/
# 
# To quickly remove Chrome default overrides, run the following commands:
# defaults delete com.google.Chrome
# defaults delete com.google.Chrome.canary
#
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false	
```
</details>

<details>
  <summary>Chrome: Use the system print dialog and expand dialog by default</summary>
  
```sh
# Note: The chrome defaults can cause your Chrome browser to display a message stating
# that Chrome is "Managed by your organization" when it isn't
# 
# To view policies that are affecting this message, view the following pages:
# chrome://policy and chrome://management/
# 
# To quickly remove Chrome default overrides, run the following commands:
# defaults delete com.google.Chrome
# defaults delete com.google.Chrome.canary
#
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
```
</details>



### Set up Git

<details>
  <summary>Configure git to always ssh when dealing with https github repos</summary>
  
```sh
git config --global url."git@github.com:".insteadOf https://github.com/
# you can remove this change by editing your ~/.gitconfig file
```
</details>


<details>
  <summary>Set Git to store credentials in Keychain</summary>
  
```sh
git config --global credential.helper osxkeychain
```
</details>


<details>
  <summary>Set git display name and email</summary>
  
```sh
if [ -n "$(git config --global user.email)" ]; then
  echo "✔ Git email is set to $(git config --global user.email)"
else
  read -p 'What is your Git email address?: ' gitEmail
  git config --global user.email "$gitEmail"
fi

if [ -n "$(git config --global user.name)" ]; then
  echo "✔ Git display name is set to $(git config --global user.name)"
else
  read -p 'What is your Git display name (Firstname Lastname)?: ' gitName
  git config --global user.name "$gitName"
fi
```
</details>


<br>
	   
---   

<br>


## Tips for using the script at your own company

This script helps new developers at Vendasta setup their laptops quicker, letting them hit the ground running. Before, it could take 2-5 days to install and configure everything, leading to a frustrating first week. With this script and fast internet, the process can be done in under 30 min.
	   
I have tried to make this script simple and useful. You will want to customize the installation and configuration to match the tools and services you use at your company.
	   
- At Vendasta, we are using Go, Angular, and Google Cloud. You most likely do not use all of these, so remove, change, and tweak to meet your needs.
- We lock our Node version at 18 (using NVM) for best compatibility with Angular and NX. You will likely want to change this. 
- To customize the [welcome logo](https://github.com/vendasta/setup-new-computer-script/blob/47b7c97f21b293e143a0566cafecec2cfc69c528/setup-new-computer.sh#L74-L90) and add a bit of style, I used the handy [Text to ASCII Art Generator](https://patorjk.com/software/taag/#p=testall&f=Isometric1&t=Vendasta)
- When you update the script, remember to update the readme "What's Installed" section too
- Be sure to update both the `.bash_profile` and `.zprofile`
- This is MIT licensed, so be sure to include the [LICENSE file](https://github.com/vendasta/setup-new-computer-script/blob/master/LICENSE)
- Let me know! It is good to know if you find this helpful


## Resources and inspiration

The following examples were helpful in building this script.
	
* macOS Dev Setup\
  https://github.com/nicolashery/mac-dev-setup
* dev-setup\
  https://github.com/donnemartin/dev-setup#dev-setup
* thoughtbot/laptop\
  https://github.com/thoughtbot/laptop


## Testing in Virtual Machines

I recommend testing your script on a fresh Mac VM to make sure your changes will work properly. Installing on a clean Mac install will let you find problems you may not see if you run the script repeatedly on your own computer.

- Testing in Intel Macs - Install Intel Mac OS VMs with Virtualbox \
  https://github.com/myspaghetti/macos-virtualbox
- Testing on M1/M2 Macs - Install VirtualBuddy to run Mac OS VMs using Apple's Virtualization.framework \
  https://github.com/insidegui/VirtualBuddy

