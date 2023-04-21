# Push/Upload  package to packagecloud.io

This action encapsulates the setup to push/upload any package to packagecloud.io.


## Inputs
```yaml
inputs:
  package-name:
    description: Name of the package to upload
    required: true
  packagecloud-username:
    description: The username to use on packagecloud.io
    required: true
  packagecloud-reponame:
    description: The repository name to upload to (must belong to user)
    required: true
  packagecloud-distro:
    description: The distribution/version this package. See the list of distros and format [here](https://www.rubydoc.info/gems/package_cloud/#pushing-a-package)
    required: true
  packagecloud-token:
    description: The Token with push access. If logged in, you can get it [here](https://packagecloud.io/api_token)
    required: true
```

## Usage
```yaml
name: dev-ci
on: [push]
jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
##### MODIFY: Add steps to build package or copy package to github action container
#####         so it is available to github action to upload to packagecloud
      - name: push package to packagecloud.io
        uses: computology/packagecloud-github-action@v0.6
        with:
##### MODIFY: Change to packagecloud username, reponame, distro type
#####         To understand the available distro type, see <https://www.rubydoc.info/gems/package_cloud/#pushing-a-package>
          PACKAGE-NAME: dist/*.tar.gz
          PACKAGECLOUD-USERNAME: test_user
          PACKAGECLOUD-REPONAME: test_repo
          PACKAGECLOUD-DISTRO: python
          PACKAGECLOUD-TOKEN: ${{ secrets.packagecloud_token }}
```

## Example

* https://github.com/computology/python-github-action-example

## Additional Steps

* Add to your github repository settings, a secret called `packagecloud_token`, which is
  the API token you get from <https://packagecloud.io/api_token>
  * On your github repo, click 'Settings'
  * On the left nav bar, under 'Security', click 'Secrets and variables'
  * Add a secret with name 'packagecloud_token' and value of API token from <https://packagecloud.io/api_token>


