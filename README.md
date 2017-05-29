# Deploy instructions

1. Add your public key to github
  * You can copy it using: `cat ~/.ssh/id_rsa.pub | pbcopy`
  * Go to https://github.com/settings/keys and paste it

* Add your SSH key to the ssh-agent
  * https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent

* Add your key to the server's authorized keys
  * You can copy it using: `cat ~/.ssh/id_rsa.pub | pbcopy`
  * Add it to authorized_keys: `vim ~/.ssh/authorized_keys`

* Run `bundle exec cap deploy` on your machine
