## WINDOWS VM SETUP

WINDOWS_SSH_ACCOUNT=""

windows-ssh-user(){
  WINDOWS_SSH_ACCOUNT="onikenx@$(sudo virsh domifaddr win10 | grep vnet | tr -s ' ' | cut -d ' ' -f 5 | cut -d '/' -f 1)"
  echo $WINDOWS_SSH_ACCOUNT
}


windows-connect(){
  ssh $WINDOWS_SSH_ACCOUNT $@
}
windows-connect-dev(){
  ssh $WINDOWS_SSH_ACCOUNT vsdev $@
}

windows-connect-dev-print(){
  windows-ssh-user
  ssh $WINDOWS_SSH_ACCOUNT $@
}

windows-start(){
  sudo virsh start win10
  windows-ssh-user
}

windows-mount(){
  WINDOWSMOUNT=/run/media/onikenx/winsshfs
  if [ ! -d "$WINDOWSMOUNT" ]; then
    # Control will enter here if $DIRECTORY exists.
    sudo mkdir $WINDOWSMOUNT -p 
    sudo chown onikenx $WINDOWSMOUNT
  fi
  windows-ssh-user
  sshfs $WINDOWS_SSH_ACCOUNT:'/C:/' /run/media/onikenx/winsshfs
}
windows(){
  windows-start && while $(return 0) ; do; windows-ssh-user&& windows-connect; sleep 1 ;done
}
