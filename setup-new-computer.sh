#!/bin/bash

VERSION="v3.2.0"
#===============================================================================
# title           setup-new-computer.sh
# author          Joel Kesler 
#                 https://github.com/joelkesler
#===============================================================================
#   A shell script to help with the quick setup and installation of tools and 
#   applications for new developers at Vendasta.
# 
#   Quick Instructions:
#
#   1. Make the script executable:
#      chmod +x ./setup-new-computer.sh
#
#   2. Run the script:
#      ./setup-new-computer.sh
#
#   3. Some installs will need your password
#
#   4. You will be promted to fill out your git email and name. 
#      Use the email and name you use for Github
#
#   5. Follow the Post Installation Instructions in the Readme:
README="https://github.com/vendasta/setup-new-computer-script#post-installation-instructions"
#  
#===============================================================================


# IDEs to make availabe. Please also adjust code to brew cask install
options[0]="Visual Studio Code";    devtoolchoices[0]="+"
options[1]="Jetbrains Toolbox";     devtoolchoices[6]=""
options[2]="Pycharm";               devtoolchoices[1]=""
options[3]="Goland";                devtoolchoices[2]=""
options[4]="Webstorm";              devtoolchoices[3]=""
options[5]="Sublime Text";          devtoolchoices[4]=""
options[6]="iTerm2";                devtoolchoices[5]=""


#===============================================================================
#  Functions
#===============================================================================


printHeading() {
    printf "\n\n\n\e[0;36m$1\e[0m \n"
}

printDivider() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\n"
}

printError() {
    printf "\n\e[1;31m"
    printf %"$COLUMNS"s |tr " " "-"
    if [ -z "$1" ]      # Is parameter #1 zero length?
    then
        printf "     There was an error ... somewhere\n"  # no parameter passed.
    else
        printf "\n     Error Installing $1\n" # parameter passed.
    fi
    printf %"$COLUMNS"s |tr " " "-"
    printf " \e[0m\n"
}

printStep() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\nInstalling $1...\n";
    $2 || printError "$1"
}

printLogo() {
cat << "EOT"
                      _           _        
                     | |         | |       
 __   _____ _ __   __| | __ _ ___| |_ __ _ 
 \ \ / / _ \ '_ \ / _` |/ _` / __| __/ _` |
  \ V /  __/ | | | (_| | (_| \__ \ || (_| |
   \_/ \___|_| |_|\__,_|\__,_|___/\__\__,_|
 ------------------------------------------
    Q U I C K   S E T U P   S C R I P T


    NOTE:
    You can exit the script at any time by
    pressing CONTROL+C a bunch
EOT
}

showIDEMenuLoop() {
    # from https://serverfault.com/a/777849
    printLogo
    printHeading "Select Optional IDEs and Tools"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        echo ""
        for NUM in "${!options[@]}"; do
            echo "[""${devtoolchoices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
        done
        echo ""
}

writetoBashProfile() {
cat << EOT >> ~/.bash_profile


# --------------------------------------------------------------------
# Begin Bash autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------

# Supress "Bash no longer supported" message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Start Homebrew
if [[ "\$(uname -p)" == "arm" ]]; then
    # Apple Silicon M1/M2 Macs
    eval "\$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel Macs
    eval "\$(/usr/local/bin/brew shellenv)"
fi

# Bash Autocompletion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="\$(brew --prefix)"
  if [[ -r "\${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "\${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "\${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "\$COMPLETION" ]] && source "\$COMPLETION"
    done
  fi
fi

# Google Cloud SDK
[ -e "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ] && \
    source "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
[ -e "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ] && \
    source "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# Golang
export GOPRIVATE="github.com/vendasta"
export GOPROXY="direct"
export GO111MODULE="on"
export GOPATH=\$HOME/go
export GOBIN=\$GOPATH/bin
export PATH=\$PATH:\$GOBIN

# NVM
# This needs to be after "Setting up Path for Homebrew" to override Homebrew Node
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \
    source "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \
    source "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node
# Increases the default memory limit for Node, so larger Angular projects can be built
export NODE_OPTIONS=--max_old_space_size=12000

# Update Node to selected version and reinstall previous packages
node-upgrade() {
    new_version=\${1:?"Please specify a version to upgrade to. Example: node-upgrade 18"}
    nvm install "\$new_version" --reinstall-packages-from=current
    nvm alias default "\$new_version"
    # nvm uninstall "\$prev_ver"
    nvm cache clear
}

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------


EOT
}

writetoZshProfile() {
cat << EOT >> ~/.zprofile


# --------------------------------------------------------------------
# Begin ZSH autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------

# Start Homebrew
if [[ "\$(uname -p)" == "arm" ]]; then
    # Apple Silicon M1/M2 Macs
    eval "\$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel Macs
    eval "\$(/usr/local/bin/brew shellenv)"
fi

# Brew Autocompletion
if type brew &>/dev/null; then
    fpath+=\$(brew --prefix)/share/zsh/site-functions
fi

# Zsh Autocompletion
# Note: must run after Brew Autocompletion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
fpath=(/usr/local/share/zsh-completions \$fpath)

# Google Cloud SDK
[ -e "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ] && \
    source "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
[ -e "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ] && \
    source "\$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Golang
export GOPRIVATE="github.com/vendasta"
export GOPROXY="direct"
export GO111MODULE="on"
export GOPATH=\$HOME/go
export GOBIN=\$GOPATH/bin
export PATH=\$PATH:\$GOBIN

# NVM 
# This needs to be after "Setting up Path for Homebrew" to override Homebrew Node
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \
    source "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \
    source "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node
# Increases the default memory limit for Node, so larger Anglar prjects can be built
export NODE_OPTIONS=--max_old_space_size=12000

# Update Node to selected version and reinstall previous packages
node-upgrade() {
    readonly new_version=\${1:?"Please specify a version to upgrade to. Example: node-upgrade 18"}
    nvm install "\$new_version" --reinstall-packages-from=current
    nvm alias default "\$new_version"
    # nvm uninstall "\$prev_ver"
    nvm cache clear
}

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------


EOT
}


writetoHuskrc() {
cat << EOT >> ~/.huskyrc


# --------------------------------------------------------------------
# Begin Husky autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------

# This loads nvm.sh and sets the correct PATH before running hook

export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \
    source "\$NVM_DIR/nvm.sh"
   

# --------------------------------------------------------------------
# End autogenerated content from setup-new-computer.sh   $VERSION
# --------------------------------------------------------------------


EOT
}


#===============================================================================
# Installer: Settings
#===============================================================================


# Show IDE Selection Menu
clear
while 
    showIDEMenuLoop && \
    read -r -e -p "Enable or Disable by typing number. Hit ENTER to continue " \
    -n1 SELECTION && [[ -n "$SELECTION" ]]; \
do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${devtoolchoices[SELECTION]}" == "+" ]]; then
            devtoolchoices[SELECTION]=""
        else
            devtoolchoices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done
printDivider



#===============================================================================
#  Installer: Set up shell profiles
#===============================================================================


# Create .bash_profile and .zprofile if they dont exist
printHeading "Prep Bash and Zsh"
printDivider
    echo "✔ Touch ~/.bash_profile"
        touch ~/.bash_profile
printDivider
    echo "✔ Touch ~/.zprofile"
        touch ~/.zprofile
printDivider
    if grep --quiet "setup-new-computer.sh" ~/.bash_profile; then
        echo "✔ .bash_profile already modified. Skipping"
    else
        writetoBashProfile
        echo "✔ Added to .bash_profile"
    fi
printDivider
    # Zsh profile
    if grep --quiet "setup-new-computer.sh" ~/.zprofile; then
        echo "✔ .zprofile already modified. Skipping"
    else
        writetoZshProfile
        echo "✔ Added to .zprofile"
    fi
printDivider
    echo "(zsh) Rebuild zcompdump"
    rm -f ~/.zcompdump
printDivider


#===============================================================================
#  Installer: Main Payload
#===============================================================================


# Install xcode cli development tools
printHeading "Installing xcode cli development tools"
printDivider
    xcode-select --install && \
        read -n 1 -r -s -p $'\n\nWhen Xcode cli tools are installed, press ANY KEY to continue...\n\n' || \
            printDivider && echo "✔ Xcode cli tools already installed. Skipping"
printDivider


# Install Brew
printHeading "Installing Homebrew"
printDivider
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
printDivider
    echo "✔ Setting Path for Homebrew"
    echo "Path Before:"
    echo $PATH

    if [[ "$(uname -p)" == "arm" ]]; then
        # Apple Silicon M1/M2 Macs
        export PATH=/opt/homebrew/bin:$PATH
    else
        # Intel Macs
        export PATH=/usr/local/bin:$PATH
    fi
    
    echo "Path After:"
    echo $PATH
printDivider
    echo "✔ (zsh) Fix brew insecure directories warning"
    chmod go-w "$(brew --prefix)/share"
printDivider


# Install Utilities
printHeading "Installing Brew Packages"
    printStep "Bash"                        "brew install bash"
    printStep "bash-completion"             "brew install bash-completion"
    printStep "zsh-completions"             "brew install zsh-completions"
    printStep "Ruby"                        "brew install ruby"
    printStep "Git"                         "brew install git"
printDivider



# Install  Apps
printHeading "Installing Applications"

    if [[ -d "/Applications/Slack.app" ]]; then
        printDivider
        echo "✔ Slack already installed. Skipping"
    else
        printStep "Slack"                     "brew install --cask slack"
    fi

    if [[ -d "/Applications/Firefox.app" ]]; then
        printDivider
        echo "✔ Firefox already installed. Skipping"
    else
        printStep "Firefox"                     "brew install --cask firefox"
    fi

    if [[ -d "/Applications/Google Chrome.app" ]]; then
        printDivider
        echo "✔ Google Chrome already installed. Skipping"
    else
        printStep "Google Chrome"               "brew install --cask google-chrome"
    fi

    if [[ -d "/Applications/Docker.app" ]]; then
        printDivider
        echo "✔ Docker already installed. Skipping"
    else
        printStep "Docker for Mac"              "brew install --cask docker"
    fi

    if [[ -d "/Applications/Postman.app" ]]; then
        printDivider
        echo "✔ Postman already installed. Skipping"
    else
        printStep "Postman"                     "brew install --cask postman"
    fi

    # Install Visual Studio Code
    if [[ "${devtoolchoices[0]}" == "+" ]]; then
        printStep "Visual Studio Code"      "brew install --cask visual-studio-code"
    fi
    # Install Jetbrains Toolbox
    if [[ "${devtoolchoices[1]}" == "+" ]]; then
        printStep "Jetbrains Toolbox"       "brew install --cask jetbrains-toolbox"
    fi
    # Install PyCharm
    if [[ "${devtoolchoices[2]}" == "+" ]]; then
        printStep "PyCharm"                 "brew install --cask pycharm"
    fi
    # Install Goland
    if [[ "${devtoolchoices[3]}" == "+" ]]; then
        printStep "Goland"                  "brew install --cask goland"
    fi
    # Install WebStorm
    if [[ "${devtoolchoices[4]}" == "+" ]]; then
        printStep "WebStorm"                "brew install --cask webstorm"
    fi
    # Install Sublime Text
    if [[ "${devtoolchoices[5]}" == "+" ]]; then
        printStep "Sublime Text"            "brew install --cask sublime-text"
    fi
    # Install iTerm2
    if [[ "${devtoolchoices[6]}" == "+" ]]; then
        printStep "iTerm2"                  "brew install --cask iterm2"
    fi
printDivider


#Install Go
# TODO: check with @cpenner about current best way to install
printHeading "Installing Go"
    printDivider
        echo "✔ Creating Go directory in home folder [~/go]"
            mkdir -p ~/go
    printStep "Go"            "brew install go"
    printDivider
        echo "✔ Setting GOPRIVATE enviromental variable"
            go env -w GOPRIVATE="github.com/vendasta"
printDivider


# Install Node
printHeading "Installing Node and Angular CLI through NVM"
    printDivider
        getLastestNVM() {
            # From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
            # Get latest release from GitHub api | Get tag line | Pluck JSON value
            curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | 
                grep '"tag_name":' |
                sed -E 's/.*"([^"]+)".*/\1/'
        }
        echo "✔ Current NVM is $(getLastestNVM)"
    printDivider
        echo "Installing NVM (Node Version Manager) $(getLastestNVM)..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(getLastestNVM)/install.sh | bash
    printDivider
        echo "✔ Loading NVM into PATH"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    printDivider
        echo "Installing Node..."
        nvm install 18
    printStep "Angular CLI"             "npm install --location=global @angular/cli"
    printStep "NX"                      "npm install --location=global nx"
    printStep "Husky"                   "npm install --location=global husky"
    printStep "Node Sass"               "npm install --location=global node-sass"
    printStep "Node Gyp"                "npm install --location=global node-gyp"
    printDivider
        echo "✔ Touch ~/.huskyrc"
            touch ~/.huskyrc
    printDivider
        # Husky profile
        if grep --quiet "nvm" ~/.huskyrc; then
            echo "✔ .huskyrc already includes nvm. Skipping"
        else
            writetoHuskrc
            echo "✔ Add nvm to .huskyrc"
        fi
printDivider


# Install Google Cloud SDK and Components
printHeading "Install Google Cloud SDK and Components"
    printStep "Google Cloud SDK"        "brew install --cask google-cloud-sdk"
    printDivider
        echo "✔ Prepping Autocompletes and Paths"
        source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
        source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
    printDivider
        if [ -e ~/google-cloud-sdk ]; then
            echo "✔ ~/google-cloud-sdk exists. Skipping"
        else
            echo "✔ Creating ~/google-cloud-sdk symlink"
            ln -s "$(brew --prefix)/Caskroom/google-cloud-sdk" ~/google-cloud-sdk &>/dev/null
            # make a convenience symlink at the install path for google-cloud-sdk when installed manually
        fi
    printStep "App Engine - Go"             "gcloud components install app-engine-go --quiet"
    printStep "App Engine - Python"         "gcloud components install app-engine-python --quiet"
    printStep "App Engine - Python Extras"  "gcloud components install app-engine-python-extras --quiet"
    printStep "Kubectl"                     "gcloud components install kubectl --quiet"
    printStep "Docker Credentials"          "gcloud components install docker-credential-gcr --quiet"
printDivider


# Install System Tweaks
printHeading "System Tweaks"
    printDivider
    echo "✔ General: Expand save and print panel by default"
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
        defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
        defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    echo "✔ General: Save to disk (not to iCloud) by default"
        defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    echo "✔ General: Avoid creating .DS_Store files on network volumes"
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    printDivider
        
    echo "✔ Typing: Disable smart quotes and dashes as they cause problems when typing code"
        defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
        defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    echo "✔ Typing: Disable press-and-hold for keys in favor of key repeat"
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    printDivider

    echo "✔ Finder: Show status bar and path bar"
        defaults write com.apple.finder ShowStatusBar -bool true
        defaults write com.apple.finder ShowPathbar -bool true
    echo "✔ Finder: Disable the warning when changing a file extension"
        defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    echo "✔ Finder: Show the ~/Library folder"
        chflags nohidden ~/Library
    printDivider
        
    echo "✔ Safari: Enable Safari’s Developer Settings"
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
        defaults write com.apple.Safari IncludeDevelopMenu -bool true
        defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
        defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
        defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    printDivider
    
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
    echo "✔ Chrome: Disable the all too sensitive backswipe on Trackpads and Magic Mice"
        defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
    echo "✔ Chrome: Use the system print dialog and expand dialog by default"
        defaults write com.google.Chrome DisablePrintPreview -bool true
        defaults write com.google.Chrome.canary DisablePrintPreview -bool true
        defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
        defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
printDivider



#===============================================================================
#  Installer: Git
#===============================================================================


# Set up Git
printHeading "Set Up Git"

printDivider
    echo "✔ Set Git to store credentials in Keychain"
    git config --global credential.helper osxkeychain
printDivider
    if [ -n "$(git config --global user.email)" ]; then
        echo "✔ Git email is set to $(git config --global user.email)"
    else
        read -p 'What is your Git email address?: ' gitEmail
        git config --global user.email "$gitEmail"
    fi
printDivider
    if [ -n "$(git config --global user.name)" ]; then
        echo "✔ Git display name is set to $(git config --global user.name)"
    else
        read -p 'What is your Git display name (Firstname Lastname)?: ' gitName
        git config --global user.name "$gitName"
    fi
printDivider
    echo "✔ Configure git to always ssh when dealing with https github repos"
        git config --global url."git@github.com:".insteadOf https://github.com/
        # you can remove this change by editing your ~/.gitconfig file
printDivider
    echo "✔ Creating .ssh directory in home folder [~/.ssh]"
        mkdir -p ~/go
printDivider
    echo "✔ Adding github.com to known_hosts file [~/.ssh/known_hosts]"
        ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
printDivider



#===============================================================================
#  Installer: Complete
#===============================================================================

printHeading "Script Complete"
printDivider

tput setaf 2 # set text color to green
cat << "EOT"

   ╭─────────────────────────────────────────────────────────────────╮
   │░░░░░░░░░░░░░░░░░░░░░░░░░░░ Next Steps ░░░░░░░░░░░░░░░░░░░░░░░░░░│
   ├─────────────────────────────────────────────────────────────────┤
   │                                                                 │
   │   There are still a few steps you need to do to finish setup.   │
   │                                                                 │
   │        The link below has Post Installation Instructions        │
   │                                                                 │
   └─────────────────────────────────────────────────────────────────┘

EOT
tput sgr0 # reset text
echo "Link:"
echo $README
echo ""
echo ""
tput bold # bold text
read -n 1 -r -s -p $'             Press any key to to open the link in a browser...\n\n'
open $README
tput sgr0 # reset text

echo ""
echo ""
echo "Please open a new terminal window to continue your setup steps"
echo ""
echo ""


exit
