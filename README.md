# ublue-ssweeny &nbsp; [![bluebuild build badge](https://github.com/ssweeny/ublue-ssweeny/actions/workflows/build.yml/badge.svg)](https://github.com/ssweeny/ublue-ssweeny/actions/workflows/build.yml)
Custom images based on [Universal Blue](https://universal-blue.org/):

* A Bazzite-based image with Bluefin artwork and support for the System76 Thelio I/O board
* A Bluefin-based image with some niceties borrowed from Pop!_OS

## Installation

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/ssweeny/bazzite-system76:latest
  ```
  ** OR **
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/ssweeny/bluefin-dx-system76:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ssweeny/<image>:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/ssweeny/bazzite-system76
```
