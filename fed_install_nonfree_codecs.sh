#!/usr/bin/env bash
# Fedora 42 Multimedia Setup Script
# RPM Fusion, replaces ffmpeg-free with full ffmpeg, installs non-free-codecs

set -e

echo "Updating system..."
sudo dnf -y upgrade

echo "Enabling RPM Fusion repositories..."
sudo dnf -y install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Replacing ffmpeg-free with full ffmpeg..."
sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing

echo "Installing multimedia codec groups..."
sudo dnf -y group install multimedia --allowerasing
sudo dnf -y group install sound-and-video

echo "Installing extra codecs ..."
sudo dnf -y install \
  gstreamer1-plugins-{bad-free,base,good,ugly} \
  gstreamer1-libav \
  lame*

echo "Done! Checking ffmpeg..."
ffmpeg -version

echo "Setup complete!"
