# Node.js Management

## Upgrading Node.js

A handy `node-upgrade` function is available in your shell to automatically install your chosen version of Node.js, re-install any global npm packages, and set the newly installed version as default.

To upgrade to the latest version of Node 20, re-install global npm packages, and set it as default, run the following command:

```shell
node-upgrade 20
```

If you wish to install a version of node without reinstalling all global packages or setting it to be default, you can use NVM directly ([Official docs](https://github.com/nvm-sh/nvm/blob/main/README.md#usage)):

```shell
# Install a specific version of Node
nvm install 18 # or 10.10.0, 8.9.1, etc
```

## Switching Node Versions

Use `nvm` to switch between installed versions of Node.js ([Official docs](https://github.com/nvm-sh/nvm/blob/main/README.md#usage)).

```shell
# To switch to the latest Node
nvm use node # "node" is an alias for the latest version

# Switch to long term support (lts) version of Node
nvm use --lts

# To switch to a specific verison of Node
nvm use 18 # or 10.10.0, 8.9.1, etc
```
