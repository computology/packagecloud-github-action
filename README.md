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
