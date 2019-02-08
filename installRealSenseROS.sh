#!/bin/bash
# Install the Intel Realsense library librealsense 2 on a Jetson TX Development Kit
# Copyright (c) 2017-2018 Jetsonhacks 
# MIT License
# Usage:
# ./installLibRealSense.sh <catkin workspace>
# If <catkin workspace> is omitted "catkin_ws" assumed
# ROS should already be installed, and a catkin workspace created
# Figure out where to install librealsense
# Save the directory we're installing from:
INSTALL_DIR=$PWD
# Now go get ready to install librealsense
source /opt/ros/kinetic/setup.bash
DEFAULTDIR=catkin_ws
CLDIR="$1"
if [ ! -z "$CLDIR" ]; then 
 DEFAULTDIR="$CLDIR"
fi
# Check to see if qualified path already
if [ -d "$DEFAULTDIR" ] ; then
   echo "Fully qualified path"
else
   # Have to add path qualification
   DEFAULTDIR=$HOME/$DEFAULTDIR
fi
echo "DEFAULTDIR: $DEFAULTDIR"



if [ -e "$DEFAULTDIR" ] ; then
  echo "$DEFAULTDIR exists" 
  CATKIN_WORKSPACEHIDDEN=$DEFAULTDIR/.catkin_workspace
  CATKIN_BUILD_WORKSPACEHIDDEN=$DEFAULTDIR/.catkin_tools
  if [ -e "$CATKIN_WORKSPACEHIDDEN" ] || [ -e "$CATKIN_BUILD_WORKSPACEHIDDEN" ] ; then
	# This appears to be a Catkin_Workspace
	echo "Found catkin workspace in directory: $DEFAULTDIR"
  else
	echo "$DEFAULTDIR does not appear to be a Catkin Workspace"
        echo "The directory does not contain the hidden file .catkin_workspace or .catkin_tools"
	echo "Terminating Installation"
	exit 1
  fi
else 
  echo "Catkin Workspace named $DEFAULTDIR does not exist"
  echo "Please create a Catkin Workspace before installation"
  echo "Terminating Installation"
  exit 1
fi
if [ "${DEFAULTDIR: -1}" != "/" ] ; then
	DEFAULTDIR=$DEFAULTDIR/
fi

INSTALLDIR="$DEFAULTDIR"src
if [ -e "$INSTALLDIR" ] ; then
  echo "Installing librealsense in: $INSTALLDIR"
else
  echo "$INSTALLDIR does not appear to be a source of a Catkin Workspace"
  echo "The source directory src does not exist"
  echo "Terminating Installation"
  exit 1
fi 

echo "Starting installation of librealsense"

cd $INSTALLDIR
echo "Starting installation of RealSense ROS package"

# Update the dependencies database
rosdep update
echo "Cloning Intel ROS realsense package"
git clone https://github.com/intel-ros/realsense.git
cd realsense
git checkout 2.0.3
cd ../..
echo "Making Intel ROS realsense"
sudo rosdep -y install --from-paths src --ignore-src --rosdistro kinetic
if [ -e "$CATKIN_WORKSPACEHIDDEN" ] ; then
	catkin_make
	echo "RealSense 2 ROS Package installed"
if [ -e "$CATKIN_BUILD_WORKSPACEHIDDEN" ] ; then
	catkin build
	echo "RealSense 2 ROS Package installed"
else
	echo "Error: couldn't deciede to use catkin_make or atkin build"
	echo "Aborting..."
fi
