# Android SDK with Ansible
Android SDK configuration on linux with Android L emulator configured optionally. Note that this Ansible script works on both **Debian** and **RedHat** linux distros.

## Prerequisite

To use this script, make sure you have [Cucumber](https://github.com/cucumber/cucumber) CLI installed and of course, Ansible :)

## Configuration

### Config Files
``` 
features/support/env.rb.default
playbooks/vars.yml
```

To begin, open the two configuration files above. Remove the extension `.default` from the `env.rb` file above so that the config files become:
```
features/support/env.rb
playbooks/hosts.ini
```

Open the `env.rb` file and enter your preferred commands to check that the server is running and provision the server. Also enter path to your inventory file. A sample of an inventory file is found in `playbooks/hosts.ini.default`.

Below is an example of the `env.rb` file configuration.
_**Note:** The constants in `env.rb` should not be deleted. However, they can have empty strings as values (for instance, if you do not need an ssh key to get into your server)._

```
# Server check command
RUNNING_SERVER_CHECK = "ping -c2 server.example.com"

# Server provision command (This can be a ping command as well)
SERVER_PROVISION_COMMAND = "ssh user@server.example.com './warmup.sh'"

# Path to hosts inventory file
HOSTS_INVENTORY_FILE = "playbooks/hosts.ini"

# Path to private key
PRIVATE_KEY = "/home/user/.ssh/private_key"

```

Next, open `playbooks/vars.yml` file and enter your desired variables. The `hosts` variable should be the hosts from your configured `playbooks/hosts.ini` or default ansible inventory file. The `user` variable should be the ssh username. 

You can configure the remaining variables using your preferred version for all the tools and software.

## Running

After the setup is complete, run ``` $ cucumber features/setup.feature ``` from the project root directory and that it!

