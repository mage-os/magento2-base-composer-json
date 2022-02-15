# Magento Open Source generated composer.json files

This repository contains the composer.json file of every Magento 2 release for the magento/magento2-base package, the project composer.json, and the root composer.json for the given tag.

## Directory Structure

```
<RELEASE-VERSION>
├── git-tag
│   └── composer.json
├── magento2-base
│   └── composer.json
├── product-community-edition
│   └── composer.json
└── project-community-edition
    └── composer.json
```

The **git-tag** directories contain the composer.json as tagged in the root of the magento/magento2 repository, for example <https://raw.githubusercontent.com/mage-os/mirror-magento2/2.4.1/composer.json>.

The **magento2-base** directories contain the `magento/magento2-base` package composer.json for the given tag.

The **product-community-edition** directories contain the `magento/product-community-edition` metapackage composer.json files for the given tag.

The **magento-community-projct** directories contain the `magento/project-community-edition` composer.json files for the given tag.

## New Releases

When a new version of Magento Open Source is tagged on https://github.com/magento/magento2 and the https://github.com/mage-os/mirror-magento2 is updated, run the commands

```bash
RELEASE=2.4.3-p2 # replace with the new release tag name
./add-release.sh $RELEASE
git add $RELEASE && git ci -m"Add release $RELEASE" && git push
```

It will download the composer packages and extract the composer.json files into the different directories.

Be sure to list your Magento repository access keys in `~/.composer/auth.json`.


## Copyright

Each Magento source file included in this repository is licensed under OSL 3.0 or the terms and conditions of the applicable ordering document between Licensee/Customer and Adobe (or Magento).

Open Software License (OSL 3.0) – Please see LICENSE.txt for the full text of the OSL 3.0 license.

Subject to Licensee's/Customer's payment of fees and compliance with the terms and conditions of the applicable ordering document between Licensee/Customer and Adobe (or Magento), the terms and conditions of the applicable ordering between Licensee/Customer and Adobe (or Magento) supersede the OSL 3.0 license for each source file.


