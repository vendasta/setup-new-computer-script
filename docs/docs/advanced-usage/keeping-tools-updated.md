# Keeping Tools Updated

Homebrew can keep your command-line tools and languages up-to-date.

```shell
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
