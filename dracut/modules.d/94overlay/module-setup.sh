#!/bin/bash

# called by dracut
check() {
	return 0
}

# called by dracut
installkernel() {
    hostonly='' instmods overlay
}

# called by dracut
install() {
	inst_hook pre-pivot 01 "$moddir/create-overlay.sh"
}
