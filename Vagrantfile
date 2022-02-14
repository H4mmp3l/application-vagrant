# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))

unless File.exists? "#{current_dir}/local.yaml"
  FileUtils.cp("#{current_dir}/local.yaml.dist", "#{current_dir}/local.yaml")
end

configs        = YAML.load_file("#{current_dir}/config.yaml")
local_config   = YAML.load_file("#{current_dir}/local.yaml")
smb_settings   = local_config['smb']
vagrant_config = configs['configs']
hosts          = []
Dir.glob("./*/").each do |folder|
    project = /^\.\/(.*)\/$/.match(folder)[1];

    if ['ansible', 'lib'].include?(project)
        next
    end

    hosts.push(project << "." << vagrant_config['servername'])
end

os = vagrant_config['distribution'] + "/" + vagrant_config['version']

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Check minimum Vagrant version
Vagrant.require_version ">= 2.2.19"

# Detect host OS for different folder share configuration
module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
        !OS.windows?
    end

    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

# Use parallels as default on mac os
if OS.windows?
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
else
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'parallels'
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = os
  config.vm.boot_timeout = 2700

  config.vm.provider "parallels"
  config.vm.provider "virtualbox"

  # Set minimal vagrant version
  Vagrant.require_version ">= 2.2.19"

  # Define required Plugins
  if OS.windows?
      config.vagrant.plugins = ["vagrant-winnfsd", "vagrant-hostmanager"]
  else
      config.vagrant.plugins = "vagrant-hostmanager"
  end

  # Check available Plugins
  if OS.windows?
      if !Vagrant.has_plugin?('vagrant-winnfsd')
          exec "vagrant plugin install vagrant-winnfsd" unless Vagrant.has_plugin?('vagrant-winnfsd')
      end
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
      config.vbguest.auto_update = false
  else
      exec "vagrant plugin install vagrant-vbguest" unless Vagrant.has_plugin?('vagrant-vbguest')
      config.vbguest.auto_update = false
  end

  if !Vagrant.has_plugin?('vagrant-hostmanager')
      exec "vagrant plugin install vagrant-hostmanager" unless Vagrant.has_plugin?('vagrant-hostmanager')
  end

  config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", vagrant_config["memory"]]
      vb.customize ["modifyvm", :id, "--cpus", vagrant_config["cpus"]]
      vb.customize ["modifyvm", :id, "--name", vagrant_config["vmname"]]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provider "parallels" do |v|
      v.memory = vagrant_config["memory"]
      v.cpus = vagrant_config["cpus"]
  end

  # Configure the VM
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.aliases = hosts
  config.vm.hostname = vagrant_config['servername']
  config.vm.network :private_network, ip: vagrant_config['private_ip']
  if vagrant_config['forward_ports'] == true
    config.vm.network :forwarded_port, host: 80, guest: 80, auto_correct: true
    config.vm.network :forwarded_port, host: 443, guest: 443, auto_correct: true
  end

  # Configure shared folder
  if OS.windows?
    if smb_settings['use'] == true
          config.vm.synced_folder ".", "/vagrant", type: "smb", smb_username: smb_settings['username'], smb_password: smb_settings['password']
       else
          config.vm.synced_folder ".", "/vagrant", type: "nfs"
          config.winnfsd.host_ip = (vagrant_config['private_ip'].split('.')[0..2] << '1').join('.')
       end
  else
    config.vm.synced_folder ".", "/vagrant", :owner => "vagrant", :group => "vagrant"
  end

  #Install pip3
  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install python3-pip -y && pip3 install jmespath", run: "always", name: "vagrant install pip3"

  # Run the provisioning
  ## Install Ansible
  config.vm.provision "shell", path: "ansible/tools/install_ansible_in_Vagrantbox.sh"

  config.ssh.forward_agent = true

  ## Install and configure software
  config.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.become = true
      ansible.verbose = ""
      ansible.extra_vars = {
        servername: vagrant_config['servername'],
        projectname: 0,
        testing_mode: 0, # 0 = skip this part // 1 = show installed software versions
        ansible_host: vagrant_config['private_ip'],
      }
  end

  if File.exist?("alias.sh")
    config.vm.provision :file, source: 'alias.sh', destination: '/home/vagrant/.bash_aliases', run: "always"
  end
end
