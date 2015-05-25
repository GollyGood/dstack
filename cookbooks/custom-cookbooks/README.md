# Custom cookbooks

This is where you may place custom cookbooks. Cookbooks in this directory are
automatically added to the usable cookbook directories. The specific cookbook
that you would like to run would still need to be added to the recipes run list
in you dstack.config.

Example:

```
chef:
  recipes:
    - avahi
    - mycustomcookbook

```
