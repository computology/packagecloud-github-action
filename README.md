[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fcomputology%2Fpackagecloud-github-action.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fcomputology%2Fpackagecloud-github-action?ref=badge_shield)

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


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fcomputology%2Fpackagecloud-github-action.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fcomputology%2Fpackagecloud-github-action?ref=badge_large)


## Usage
* To use the github action, you need to:
  1. Create a directory `.github/workflows`.
  2. In that directory, create a yml file (can be any name, e.g., 'upload.yml') containing github action configuration.
    * To use the official packagecloud.io github action, the yml file should contain the contents below with the sections marked `MODIFY` replaced with appropriate values
  3. See 'Additional Steps' to add your packagecloud.io API token.
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
        uses: computology/packagecloud-github-action@master
        with:
##### MODIFY: Change to packagecloud username, reponame, distro type
#####         To understand the available distro type, see <https://www.rubydoc.info/gems/package_cloud/#pushing-a-package>
          PACKAGE-NAME: dist/*.tar.gz
          PACKAGECLOUD-USERNAME: test_user
          PACKAGECLOUD-REPONAME: test_repo
          PACKAGECLOUD-DISTRO: python
          PACKAGECLOUD-TOKEN: ${{ secrets.packagecloud_token }}
```

### Runtime and certificate updates

The action builds the checked-in Dockerfile on the GitHub runner instead of
pulling the old prebuilt Docker Hub image. This adds image-build time to each
workflow run, but ensures the action uses the runtime and certificate policy in
the selected Git revision. Prefer pinning a reviewed full commit SHA or release
containing this change rather than the moving `master` example above. Existing
older action tags still reference the old image and do not receive this fix.

The image uses Ruby 3.4 and Debian Bookworm's system certificate store. Builds
require `ca-certificates` version `20250419~deb12u2` or newer, which removes trust
in `emSign ECC Root CA - G3` and `AAA Certificate Services` following the
[eMudhra intermediate CA compromise](https://emudhra.we-have-a-problem.com/).
Certificate and hostname verification remain enabled; the action does not add a
custom certificate blocklist or modify the runner host's trust store.

To build and check the image locally without uploading a package:

```bash
docker build --pull -t packagecloud-action:test .
docker run --rm --entrypoint package_cloud packagecloud-action:test version
```

## Example

* https://github.com/computology/python-github-action-example

## Additional Steps

* Add to your github repository settings, a secret called `packagecloud_token`, which is
  the API token you get from <https://packagecloud.io/api_token>
  * On your github repo, click 'Settings'
  * On the left nav bar, under 'Security', click 'Secrets and variables'
  * Add a secret with name 'packagecloud_token' and value of API token from <https://packagecloud.io/api_token>
