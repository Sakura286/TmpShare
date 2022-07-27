#!bin/bash

qemu-system-riscv64 \
  -nographic -machine virt \
  -smp 8,cores=8,threads=1,sockets=1 -m 8G \
  -display sdl -vga std \
  -kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf \
  -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
  -drive file=rootfs.img,format=raw,id=hd0 \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-vga \
  -device virtio-rng-device,rng=rng0 \
  -device virtio-blk-device,drive=hd0 \
  -device virtio-net-device,netdev=usernet \
  -netdev user,id=usernet,hostfwd=tcp::22222-:22 \
  -device qemu-xhci -usb -device usb-kbd -device usb-tablet \
  -append 'root=/dev/vda1 rw console=ttyS0 swiotlb=1 loglevel=3 systemd.default_timeout_start_sec=600 selinux=0 highres=off mem=8096M earlycon'
