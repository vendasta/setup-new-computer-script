# Setup a New Developer Computer

This script will help with the quick setup and installation of tools and applications for new developers at Badal-IO.

## Quick Install Instructions

Paste the command below in a Mac OS Terminal:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/badal-io/setup-new-computer-script/main/setup-new-computer.sh)"
```

## Documentation

The main documentation for this project is hosted in Backstage.

For browsing on GitHub, you can find the documentation in the `/docs/docs` directory:

-   [Introduction](./docs/docs/intro.md)
-   **Getting Started**
    -   [Installation](./docs/docs/getting-started/installation.md)
    -   [Post-Installation](./docs/docs/getting-started/post-installation.md)
-   **What's Installed**
    -   [Shell Setup](./docs/docs/what-is-installed/shell-setup.md)
    -   [Command-Line Tools](./docs/docs/what-is-installed/command-line-tools.md)
    -   [Languages](./docs/docs/what-is-installed/languages.md)
    -   [Applications](./docs/docs/what-is-installed/applications.md)
    -   [System Tweaks](./docs/docs/what-is-installed/system-tweaks.md)
-   **Company-Specific Setup**
    -   [Badal-IO](./docs/docs/company-specific-setup/badal-io.md)
-   **Advanced Usage**
    -   [Node Management](./docs/docs/advanced-usage/node-management.md)
    -   [Keeping Tools Updated](./docs/docs/advanced-usage/keeping-tools-updated.md)
-   **For Maintainers**
    -   [Customization](./docs/docs/for-maintainers/customization.md)
    -   [Testing](./docs/docs/for-maintainers/testing.md)

## Running the Documentation Site Locally

To run the documentation site locally, navigate to the `/docs` directory and run the following commands:

```shell
npm install
npm start
```

To build the site for production, run:

```shell
npm run build
```