#!/bin/bash

# Prepare the cinc build environment

set -e

origin=${ORIGIN:-https://github.com/chef/chef.git}
ref=${REF:-master}
project_dir=${CI_PROJECT_DIR:-$(pwd)}

echo "Cloning reference $ref from $origin"
rm -rf chef
git clone --depth=10 -b $ref $origin 

echo "Preparing the cinc build environment..."
cp -R cinc/* chef/
mkdir -p ${project_dir}/{cache,cache/git_cache}
echo "cache_dir '${project_dir}/cache'" >> chef/omnibus/omnibus.rb
echo "git_cache_dir '${project_dir}/cache/git_cache'" >> chef/omnibus/omnibus.rb
sed -i -e 's/^use_git_caching false/use_git_caching true/g' chef/omnibus/omnibus.rb
