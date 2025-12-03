# Badal-IO Specific Setup

The `badal-io.sh` script is sourced by the main `setup-new-computer.sh` script and installs tools specific to Badal-IO.

## What it Installs

-   **Hashicorp tap:** Adds the Hashicorp tap to Homebrew.
    ```shell
    brew tap hashicorp/tap
    ```
-   **Terraform:** Installs Terraform.
    ```shell
    brew install terraform
    ```
-   **Vault CLI:** Installs the Vault command-line interface.
    ```shell
    brew install vault-cli
    ```
