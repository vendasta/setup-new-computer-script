# Docusaurus Documentation Plan for setup-new-computer-script

This document outlines a plan for creating comprehensive documentation for the `setup-new-computer-script` repository using Docusaurus.

## 1. Project Overview

The `setup-new-computer-script` repository contains a set of shell scripts designed to automate the setup of a new developer machine on macOS. The main script, `setup-new-computer.sh`, installs a variety of tools, applications, and system tweaks. It is designed to be idempotent and user-friendly. The repository also includes a company-specific script, `badal-io.sh`, which installs tools like Terraform and Vault.

The project already contains a Docusaurus installation in the `/docs` directory, but it is the default template and does not contain any documentation specific to this project.

## 2. Docusaurus and Content Strategy

The goal is to create a Docusaurus site that is the single source of truth for documentation, while the root `README.md` will serve as a concise entry point.

### 2.1. Re-use Existing Documentation

The existing `README.md` is very detailed and will be the primary source for the new documentation. Specifically, the "What's Installed" section will be broken down into individual pages within the Docusaurus site.

### 2.2. Fact-Checking and Corrections

The documentation will be fact-checked against the current version of the shell scripts. Any discrepancies will be corrected.

- **Note on `functions.sh`:** The `functions.sh` file duplicates functions already present in `setup-new-computer.sh`. The documentation will note this redundancy and recommend consolidating the functions into `functions.sh` and sourcing it in the main script for better maintainability.
- **External Links:** All external links will be checked for validity. The GitHub help links in the `README.md` should be verified.

### 2.3. Docusaurus Structure

The documentation in `/docs/docs` will be structured as follows:

-   **Introduction (`intro.md`):** A landing page that explains the purpose of the script and how to use it. This will be adapted from the current `README.md`.
-   **Getting Started:**
    -   `installation.md`: Detailed installation instructions, including the quick and manual methods.
    -   `post-installation.md`: The post-installation steps, such as setting up SSH for GitHub.
-   **What's Installed:** A section with dedicated pages for each category of installed software.
    -   `shell-setup.md`: Details on the `.bash_profile` and `.zprofile` modifications.
    -   `command-line-tools.md`: Information on `brew`, `git`, etc.
    -   `languages.md`: Go, Node.js (with NVM), Ruby.
    -   `applications.md`: Docker, Postman, Chrome, Firefox, and optional IDEs.
    -   `system-tweaks.md`: A list and explanation of all the `defaults write` commands.
-   **Company-Specific Setup:**
    -   `badal-io.md`: Documentation for the `badal-io.sh` script, explaining what it installs (Terraform, Vault).
-   **Advanced Usage:**
    -   `node-management.md`: How to use the `node-upgrade` function and `nvm`.
    -   `keeping-tools-updated.md`: How to use `brew` to keep tools up-to-date.
-   **For Maintainers:**
    -   `customization.md`: Tips for other companies to fork and customize the script.
    -   `testing.md`: The advice on testing in VMs from the current `README.md`.

## 3. Docusaurus Theme and Plugins

The following plugins and themes will be installed and configured to improve the documentation experience:

-   **`@docusaurus/theme-live-codeblock`:** To provide live-updating shell script examples. This will be particularly useful for showing the output of certain commands.
-   **Mermaid.js support:** To create diagrams if needed. For example, a diagram could illustrate the script's execution flow. This can be added by following the Docusaurus documentation on Mermaid.js.
-   **`docusaurus-plugin-image-zoom`:** For better viewing of any screenshots or images.

## 4. New README.md

A new `README.md` will be created at the root of the repository. It will be a more concise and focused document.

The new `README.md` will contain:

-   A brief overview of the project's purpose.
-   Quick install instructions.
-   A prominent note that the main documentation is hosted in Backstage.
-   A section with relative links to the Docusaurus documentation pages for easy browsing on GitHub. This will provide a good experience for users who are browsing the code on GitHub. The links will point to the `.md` files in the `/docs/docs` directory.
-   A section on how to run and build the documentation site locally.

This plan provides a clear path to creating high-quality documentation for the `setup-new-computer-script` repository, making it easier for new developers to get started and for maintainers to keep it up-to-date.
