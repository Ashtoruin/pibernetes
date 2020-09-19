# pibernetes

### Running
* edit vars/all.yml
* ansible-playbook k3s-init.yml -i inventory/hosts.ini

### Testing
* will only work with default vars/all.yml values
* ansible-playbook k3s-init.yml -i inventory/hosts.ini -e testing_enabled=true
