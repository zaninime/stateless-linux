#!/bin/sh

rootmnt=${NEWROOT%/}
lower_fs=${rootmnt}.lower
rw_fs=${rootmnt}.rw
upper_dir=${rw_fs}/upper
work_dir=${rw_fs}/work

overlay_base=${rootmnt}/overlay/base
overlay_rw=${rootmnt}/overlay/rw

mkdir $lower_fs $rw_fs

info "Creating tmpfs"
mount -t tmpfs tmpfs $rw_fs
mkdir $upper_dir $work_dir

info "Moving the root fs"
mount --bind $rootmnt $lower_fs
umount $rootmnt

info "Creating the overlay"
mount -t overlay -o lowerdir=$lower_fs,upperdir=$upper_dir,workdir=$work_dir overlay $rootmnt

info "Making the parts accessible in the new root"
mkdir -p $overlay_base $overlay_rw
mount --bind $lower_fs $overlay_base
mount --bind $rw_fs $overlay_rw
