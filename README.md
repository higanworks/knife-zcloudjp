# Knife::Zcloudjp

[![Build Status](https://secure.travis-ci.org/higanworks/knife-zcloudjp.png)](http://travis-ci.org/higanworks/knife-zcloudjp)

A Knife(Opscode Chef) plugin for [Z Cloud](http://z-cloud.jp).

## Installation

Drop the following line into your application's `Gemfile`.

    gem 'knife-zcloudjp', :git => "git://github.com/higanworks/knife-zcloudjp.git"

And execute the `bundle` command.

    $ bundle

## Usage

Add the following entries to your `.chef/knife.rb`.

    knife[:zcloudjp_api_token] = "YOUR-API-TOKEN"
    knife[:zcloudjp_api_url] = "https://my.z-cloud.jp"

### Retrieve the product catalog that are currently available.

    $ knife zcloudjp product list (options)
    name                   os            dataset                      package
    SmartOS Small 1        SmartOS       sdc:sdc:smartos64:1.5.3      Small_1GB
    SmartOS Medium 2       SmartOS       sdc:sdc:smartos64:1.5.3      Medium_2GB
    SmartOS Medium 4       SmartOS       sdc:sdc:smartos64:1.5.3      Medium_4GB
    SmartOS Large 8        SmartOS       sdc:sdc:smartos64:1.5.3      Large_8GB
    SmartOS Plus Small 1   SmartOS       sdc:sdc:smartosplus64:3.0.7  Small_1GB
    SmartOS Plus Medium 2  SmartOS       sdc:sdc:smartosplus64:3.0.7  Medium_2GB
    SmartOS Plus Medium 4  SmartOS       sdc:sdc:smartosplus64:3.0.7  Medium_4GB
    SmartOS Plus Large 8   SmartOS       sdc:sdc:smartosplus64:3.0.7  Large_8GB
    MySQL Small 1          SmartOS       sdc:sdc:mysql:1.4.1          Small_1GB
    MySQL Medium 2         SmartOS       sdc:sdc:mysql:1.4.1          Medium_2GB
    MySQL Medium 4         SmartOS       sdc:sdc:mysql:1.4.1          Medium_4GB
    MySQL Large 1          SmartOS       sdc:sdc:mysql:1.4.1          Large_8GB


<pre><code>knife zcloudjp product list (options)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
        --defaults                   Accept default values for all questions
    -d, --disable-editing            Do not open EDITOR, just accept the data as is
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -F, --format FORMAT              Which format to use for output
    -u, --user USER                  API Client Username
        --print-after                Show the data after a destructive operation
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -h, --help                       Show this message
</code></pre>


### Print the machine list

    $ knife zcloudjp machine list (options)
    name               id                                    ips                  dataset                    package     state
    Son_of_Jenkins_02  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Medium_2GB  running
    chef-sv01          xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Small_1GB   running
    shinobra           xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.1    Small_1GB   running
    growthforecast     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
    rabi01             xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
    zootest_south      xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running

<pre><code>knife zcloudjp machine list (options)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
        --defaults                   Accept default values for all questions
    -d, --disable-editing            Do not open EDITOR, just accept the data as is
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -F, --format FORMAT              Which format to use for output
    -u, --user USER                  API Client Username
        --print-after                Show the data after a destructive operation
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -h, --help                       Show this message
</code></pre>

### Create a new machine and integrate it to the Chef Server

    $ knife zcloudjp machine create -I DATASET [-p PACKAGE] [-r role|recipie] (options)

Notice that the Linux virtual machine can be bootstrapped with the above command but the SmartMachine based on SmartOS can not be. To work out this issue, please refer to the following workaround.

#### Workaround for bootstrapping a machine based on SmartOS

Login into a newly provisonned machine based on SmartOS via ssh, and introduce the `chef-client` with the following commands.

    # pkg_trans /tmp/chef-{version}.{arc}.solaris
    # cp -rp chef/root/opt/chef /opt/
    # /opt/chef/bin/chef-client

`client.rb` and `validation.pem` may be already stored in the `/etc/chef` directory. Now `chef-client` command is available on your machine, so you can perfome `run_list` with it.

<pre><code>knife zcloudjp machine create (options)
        --bootstrap-version VERSION  The version of Chef to install
    -N, --node-name NAME             The Chef node name for your new node (default uuid)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
    -I DATASET_IMAGE,                Dataset image of the machine
        --dataset-image
        --defaults                   Accept default values for all questions
        --disable-editing            Do not open EDITOR, just accept the data as is
    -d, --distro DISTRO              Bootstrap a distro using a template; default is 'chef-full'
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -j JSON_ATTRIBS,                 A JSON string to be added to the first run of chef-client
        --json-attributes
    -F, --format FORMAT              Which format to use for output
        --[no-]host-key-verify       Verify host key, disabled by default
    -i IDENTITY_FILE,                The SSH identity file used for authentication
        --identity-file
    -n, --machine-name NAME          Name tag value for your new machne (dafault uuid's first period)
    -u, --user USER                  API Client Username
    -p, --package PACKAGE            Package of machine; default is Small_1GB
        --prerelease                 Install the pre-release chef gems
        --print-after                Show the data after a destructive operation
    -r, --run-list RUN_LIST          Comma separated list of roles/recipes to apply
    -x, --ssh-user USERNAME          The ssh username; default is 'root'
        --template-file TEMPLATE     Full path to location of template to use
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -M, --zcloud-metadata JSON       JSON string version of metadata hash to be supplied with the machine create call
    -h, --help                       Show this message
</code></pre>


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


