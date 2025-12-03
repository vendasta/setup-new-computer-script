# Post-Installation

After you have run the script, please complete the following steps to finish setting up your computers:

## 1. Github Command-line SSH Authentication

Git is now configured to use SSH by default for github urls. You will need to generate and add an SSH key to your Github account or you will run into errors. Do the following to authorize Github on your computer:

-   [Generate an SSH key for your new computer](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
-   [Add the SSH public key to your Github account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## 2. Badal Specific Setup

Follow our onboarding document to complete your setup:

-   Placeholder: this will link to a confluence page, but I don't see anything that exists yet

## 3. Fix ZSH Errors

If you are using ZSH as your shell (default in newer Mac OS versions) you may get this error after running the setup script:

> zsh compinit: insecure directories, run compaudit for list.
> Ignore insecure directories and continue [y] or abort compinit [n]?

You can fix this by running the following command in your terminal:

```shell
compaudit | xargs chmod g-w
```
