
# order of calls is
#   pre_install_drbd_devstack
#   install_drbd_devstack
#   configure_drbd_devstack
#   init_drbd_devstack

if is_service_enabled drbd-devstack; then

    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        source "$dir/devstack/settings"
        # Set up system services
        source "$dir/devstack/lib/drbd_devstack"
        echo_summary "Configuring system services drbd_devstack"
        pre_install_drbd_devstack

    elif [[ "$1" == "stack" && "$2" == "install" ]]; then
        # Perform installation of service source
        echo_summary "Installing drbd_devstack"
        install_drbd_devstack

    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        # Configure after the other layer 1 and 2 services have been configured
        echo_summary "Configuring drbd_devstack"
        configure_drbd_devstack

    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        # Initialize and start the drbd_devstack service
        echo_summary "Initializing drbd_devstack"
        init_drbd_devstack
    fi

    if [[ "$1" == "unstack" ]]; then
        # Shut down drbd_devstack services
        source "$dir/devstack/lib/drbd_devstack"
        shutdown_drbd_devstack
    fi

    if [[ "$1" == "clean" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        source "$dir/devstack/lib/drbd_devstack"
        cleanup_drbd_devstack
    fi

    if [[ "$1" == "make-a-storage-node" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        source "$dir/devstack/settings"
        source "$dir/devstack/lib/drbd_devstack"
        pre_install_drbd_devstack
        install_drbd_devstack
        configure_drbd_devstack
        init_drbd_devstack
    fi
fi
