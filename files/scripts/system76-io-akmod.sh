#!/bin/sh
set -oeux pipefail

ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q "${KERNEL_NAME:-kernel}" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

if [[ "${RELEASE}" -ge 42 ]]; then
    COPR_RELEASE="rawhide"
else
    COPR_RELEASE="${RELEASE}"
fi

wget "https://copr.fedorainfracloud.org/coprs/ssweeny/system76-hwe/repo/fedora-${COPR_RELEASE}/ssweeny-system76-hwe-fedora-${COPR_RELEASE}.repo" -O /etc/yum.repos.d/_copr_ssweeny-system76-hwe.repo

### BUILD system76-io (succeed or fail-fast with debug output)
rpm-ostree install \
    "akmod-system76-io-*.fc${RELEASE}.${ARCH}"
akmods --force --kernels "${KERNEL}" --kmod system76-io
modinfo "/usr/lib/modules/${KERNEL}/extra/system76-io/system76-io.ko.xz" >/dev/null ||
    (find /var/cache/akmods/system76-io/ -name \*.log -print -exec cat {} \; && exit 1)

rm -f /etc/yum.repos.d/_copr_ssweeny-system76-hwe.repo
