thanas-x86-64-kernel
====================
modded fork of torvalds dev git.
auto install - use "MENU.sh".
ONLY USE MASTER BRANCH - will contain latest changes.

**copy & paste underneath line in console to start:**

```
git clone --depth=1 https://github.com/thanasxda/thanas-x86-64-kernel.git && cd thanas-x86-64-kernel && sudo chmod 755 *.sh && ./0_MENU.sh
```
also preconfigured in:
- [basic-linux-setup](https://github.com/thanasxda/basic-linux-setup.git)


Linux kernel
============

There are several guides for kernel developers and users. These guides can
be rendered in a number of formats, like HTML and PDF. Please read
Documentation/admin-guide/README.rst first.

In order to build the documentation, use ``make htmldocs`` or
``make pdfdocs``.  The formatted documentation can also be read online at:

    https://www.kernel.org/doc/html/latest/

There are various text files in the Documentation/ subdirectory,
several of them using the Restructured Text markup notation.

Please read the Documentation/process/changes.rst file, as it contains the
requirements for building and running the kernel, and information about
the problems which may result by upgrading your kernel.
