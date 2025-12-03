# System Tweaks

The script applies the following system tweaks:

## General

-   **Expand save and print panel by default:**
    ```shell
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    ```
-   **Save to disk (not to iCloud) by default:**
    ```shell
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    ```
-   **Avoid creating .DS_Store files on network volumes:**
    ```shell
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    ```

## Typing

-   **Disable smart quotes and dashes:**
    ```shell
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    ```
-   **Disable press-and-hold for keys in favor of key repeat:**
    ```shell
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    ```

## Finder

-   **Show status bar and path bar:**
    ```shell
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    ```
-   **Disable the warning when changing a file extension:**
    ```shell
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    ```
-   **Show the `~/Library` folder:**
    ```shell
    chflags nohidden ~/Library
    ```

## Safari

-   **Enable Safari’s Developer Settings:**
    ```shell
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    ```

## Chrome

-   **Disable the backswipe on Trackpads and Magic Mice:**
    ```shell
    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
    defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
    defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
    defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
    ```
-   **Use the system print dialog and expand dialog by default:**
    ```shell
    defaults write com.google.Chrome DisablePrintPreview -bool true
    defaults write com.google.Chrome.canary DisablePrintPreview -bool true
    defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
    defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
    ```
    > **Note:** The chrome defaults can cause your Chrome browser to display a message stating that Chrome is "Managed by your organization" when it isn't. To view policies that are affecting this message, view `chrome://policy` and `chrome://management/`.

## Git

-   **Set Git to store credentials in Keychain:**
    ```shell
    git config --global credential.helper osxkeychain
    ```
-   **Set git display name and email:** The script will prompt you for your name and email.
